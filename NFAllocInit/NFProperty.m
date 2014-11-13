//
//  NFProperty.m
//  NFAllocInit
//
//  Created by Andrew Williams on 20/02/2014.
//  Copyright (c) 2014 NextFaze SD. All rights reserved.
//
// inspired by code from boliva
// (http://stackoverflow.com/questions/754824/get-an-object-properties-list-in-objective-c)

#import "NFProperty.h"
#import <objc/runtime.h>

// redefine properties as read/write internally
@interface NFProperty ()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NFPropertyDataType valueType;
@property (nonatomic, assign) int pointerLevel;
@property (nonatomic, assign) Class valueClass;
@end

@implementation NFProperty

- (BOOL)isPointer {
    return self.pointerLevel > 0;
}

+ (NSDictionary *)propertiesDictionaryFromClass:(Class)klass {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for(NFProperty *property in [self propertiesFromClass:klass]) {
        [dict setValue:property forKey:property.name];
    }
    return dict;
}

+ (NSArray *)propertiesFromClass:(Class)klass {
    NSMutableArray *list = [NSMutableArray array];
    unsigned int outCount, i;
    
    while(klass != [NSObject class]) {
        objc_property_t *properties = class_copyPropertyList(klass, &outCount);
        for(i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *propName = property_getName(property);
            if(propName) {
                NSArray *attributes = [NFProperty attributesOfProperty:property];
                NSString *propertyName = [NSString stringWithUTF8String:propName];
                
                NFProperty *property = [[NFProperty alloc] init];
                property.name = propertyName;
                property.attributes = attributes;
                
                //NFLog(@"property: %@", property);
                
                [list addObject:property];
            }
        }
        free(properties);

        klass = [klass superclass];
    }
    return list;
}

- (void)setAttributes:(NSArray *)attributes {
    NSString *propertyType = nil;
    _attributes = attributes;
    
    for(NSString *attribute in attributes) {
        if([attribute hasPrefix:@"T"] && !propertyType) {
           propertyType = attribute;
        }
        else if([attribute isEqualToString:@"R"]) {
            _readonly = YES;
        }
        else if([attribute isEqualToString:@"W"]) {
            _weak = YES;
        }
        else if([attribute isEqualToString:@"N"]) {
            _nonatomic = YES;
        }
        else if([attribute isEqualToString:@"C"]) {
            _copy = YES;
        }
        else if([attribute isEqualToString:@"D"]) {
            _dynamic = YES;
        }
        else if([attribute isEqualToString:@"&"]) {
            _strong = YES;
        }
    }
    
    [self processPropertyType:propertyType];
}

- (NSString *)description {
    NSMutableArray *modifiers = [NSMutableArray array];

    [modifiers addObject:self.nonatomic ? @"nonatomic" : @"atomic"];
    if(self.weak) [modifiers addObject:@"weak"];
    if(self.copy) [modifiers addObject:@"copy"];
    if(self.readonly) [modifiers addObject:@"readonly"];
    if(self.strong) [modifiers addObject:@"strong"];
    if(self.dynamic) [modifiers addObject:@"dynamic"];
    
    return [NSString stringWithFormat:@"(%@) %@ %.*s%@ (class %@)",
            [modifiers componentsJoinedByString:@", "],
            [self dataTypeToString], self.pointerLevel, "***************", self.name,
            NSStringFromClass(self.valueClass)];
}

- (NSString *)dataTypeToString {
    switch(self.valueType) {
        case NFPropertyDataTypeChar:
            return @"char";
        case NFPropertyDataTypeUnsignedChar:
            return @"unsigned char";
        case NFPropertyDataTypeInt:
            return @"int";
        case NFPropertyDataTypeLong:
            return @"long";
        case NFPropertyDataTypeObject:
            return self.valueClass ? NSStringFromClass(self.valueClass) : @"NSObject";
        case NFPropertyDataTypeUnsignedInt:
            return @"unsigned int";
        case NFPropertyDataTypeUnsignedLong:
            return @"unsigned long";
        case NFPropertyDataTypeUnknown:
            return @"?";
        case NFPropertyDataTypeLongLong:
            return @"long long";
        case NFPropertyDataTypeUnsignedLongLong:
            return @"unsigned long long";
        case NFPropertyDataTypeShort:
            return @"short";
        case NFPropertyDataTypeUnsignedShort:
            return @"unsigned short";
    }
}

#pragma mark -

- (void)processPropertyType:(NSString *)propertyType {
    
    self.valueClass = [self propertyTypeClass:propertyType];
    
    if(self.valueClass) {
        // object, e.g. T@"NSString"
        self.valueType = NFPropertyDataTypeObject;
        self.pointerLevel = 1;
    } else if([propertyType characterAtIndex:1] == '^') {
        // pointer, e.g. T^i
        self.pointerLevel = (int)[propertyType length] - 2;  // e.g T^^i == int **value;
        self.valueType = [self propertyDataType:propertyType];
    } else {
        // primitive, e.g. Ti
        self.valueType = [self propertyDataType:propertyType];
    }
    
    // special case T* = char *, T^* == char **
    if([propertyType hasSuffix:@"*"])
        self.pointerLevel++;
}

- (NFPropertyDataType)propertyDataType:(NSString *)propertyType {
    unichar ptype = [propertyType characterAtIndex:[propertyType length] - 1];
    
    switch(ptype) {
        case 'i':
            return NFPropertyDataTypeInt;
        case 'I':
            return NFPropertyDataTypeUnsignedInt;
        case 's':
            return NFPropertyDataTypeShort;
        case 'S':
            return NFPropertyDataTypeUnsignedShort;
        case 'l':
            return NFPropertyDataTypeLong;
        case 'L':
            return NFPropertyDataTypeUnsignedLong;
        case 'c':
        case 'B':  // boolean, only returned by newer devices
            return NFPropertyDataTypeChar;
        case 'C':
            return NFPropertyDataTypeUnsignedChar;
        case '*':
            return NFPropertyDataTypeChar;  // char *
        case 'Q':
            return NFPropertyDataTypeUnsignedLongLong;
        case 'q':
            return NFPropertyDataTypeLongLong;
        default:
            NFLog(@"unhandled property type: %c", ptype);
            return NFPropertyDataTypeUnknown;
    }
}

- (Class)propertyTypeClass:(NSString *)propertyType {
    if([propertyType hasPrefix:@"T@\""]) {
        NSRange range = NSMakeRange(3, [propertyType length] - 4);
        NSString *className = [propertyType substringWithRange:range];
        return NSClassFromString(className);
    }
    return nil;
}

+ (NSArray *)attributesOfProperty:(objc_property_t)property {
    const char * propAttr = property_getAttributes(property);
    NSString *propString = [NSString stringWithUTF8String:propAttr];
    NSArray *attrArray = [propString componentsSeparatedByString:@","];
    return attrArray;
}

@end
