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

+ (NSArray *)propertiesFromClass:(Class)klass {
    NSMutableArray *list = [NSMutableArray array];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithCString:propName
                                                        encoding:[NSString defaultCStringEncoding]];
            NSString *propertyType = [self propertyType:property];
            
            NFProperty *property = [[NFProperty alloc] init];
            property.name = propertyName;
            
            [property processPropertyType:propertyType];
            
            //NFLog(@"property: %@", property);
            
            [list addObject:property];
        }
    }
    free(properties);
    
    return list;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %.*s%@",
            [self dataTypeToString], self.pointerLevel, "***************", self.name];
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
        case 'l':
            return NFPropertyDataTypeLong;
        case 'L':
            return NFPropertyDataTypeUnsignedLong;
        case 'c':
            return NFPropertyDataTypeChar;
        case 'C':
            return NFPropertyDataTypeUnsignedChar;
        case '*':
            return NFPropertyDataTypeChar;  // char *
    }
    
    return NFPropertyDataTypeUnknown;
}

- (Class)propertyTypeClass:(NSString *)propertyType {
    if([propertyType hasPrefix:@"T@\""]) {
        NSRange range = NSMakeRange(3, [propertyType length] - 4);
        NSString *className = [propertyType substringWithRange:range];
        return NSClassFromString(className);
    }
    return nil;
}

+ (NSString *)propertyType:(objc_property_t)property {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        //NFLog(@"attr: %s", attribute);
        if (attribute[0] == 'T') {
            return [NSString stringWithCString:attribute encoding:[NSString defaultCStringEncoding]];
        }
    }
    return nil;
}

@end
