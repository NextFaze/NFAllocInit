// UIImage (NFAllocInit_Paths)
/*
 * full image suffix search path (when orientation is known):
 
 "-Portrait@2x~568h",
 "-Portrait~568h",
 "-Portrait@2x~iphone",
 "-Portrait~iphone",
 "-Portrait@2x",
 "-Portrait",
 "-568h@2x~568h",
 "-568h~568h",
 "-568h@2x~iphone",
 "-568h~iphone",
 "-568h@2x",
 "-568h",
 "@2x~568h",
 "~568h",
 "@2x~iphone",
 "~iphone",
 "@2x",
 ""
 */

#import <objc/runtime.h>
#import "UIImage+NFAllocInit_Paths.h"

#define DEFAULT_EXTENSION @"png"
#define IMAGE_EXTENSION(imageName) ([imageName pathExtension].length ? [imageName pathExtension] : DEFAULT_EXTENSION)

@interface NSBundle ()
- (NSString *)nextfazePathForResource:(NSString *)name ofType:(NSString *)ext;
@end

@implementation UIImage (NFAllocInit_Paths)

static BOOL isRetina = NO;
static BOOL isLoaded = NO;

+ (void)initialize {
    @synchronized(self) {
        // avoid running this code twice
        // this is called twice when running unit tests for some reason
        if(isLoaded) return;
        isLoaded = YES;
    }
    
    Method m1 = class_getInstanceMethod(NSClassFromString(@"UIImageNibPlaceholder"), @selector(initWithCoder:));
    Method m2 = class_getInstanceMethod(self, @selector(nextfazeInitWithCoder:));
    method_exchangeImplementations(m1, m2);
    
    Method m3 = class_getClassMethod(self, @selector(imageNamed:));
    Method m4 = class_getClassMethod(self, @selector(nextfazeImageNamed:));
    method_exchangeImplementations(m3, m4);
    
    isRetina = ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00);
    NFLog(@"isRetina: %@", isRetina ? @"YES" : @"NO");
}

- (id)nextfazeInitWithCoder:(NSCoder *)aDecoder {
	NSString *resourceName = [aDecoder decodeObjectForKey:@"UIResourceName"];
	NSString *extension = IMAGE_EXTENSION(resourceName);
	NSString *name = [resourceName stringByDeletingPathExtension];
	
    NSString *newName = [[self class] suffixedNameForImageNamed:name orientation:UIInterfaceOrientationPortrait];
    
	if (newName)
		return [self initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:newName ofType:extension]];
	else
		return [self nextfazeInitWithCoder:aDecoder];
}

+ (UIImage *)imageNamed:(NSString *)imageName orientation:(UIInterfaceOrientation)orientation {
    NSString *extension = IMAGE_EXTENSION(imageName);
    NSString *newName = [self suffixedNameForImageNamed:imageName orientation:orientation];

    //NFLog(@"imageNamed: %@ -> %@", imageName, newName);
    
    // if an image with a suffix was found, return it
    if(newName) {
        NSRange range2x = [newName rangeOfString:@"@2x"];
        if([newName hasSuffix:@"@2x"]) {
            // if the suffix is @2x, we can drop it, because the original implementation will find it and set the scale correctly
            newName = [newName substringToIndex:newName.length - 3];
        }
        
        // get the image using the original imageNamed implementation
        UIImage *image = [self nextfazeImageNamed:[newName stringByAppendingPathExtension:extension]];

        // check scale property has been set correctly
        if(range2x.location != NSNotFound && image.scale != 2.0) {
            // image scale should be set to 2.0, but isn't
            // (this can happen when @2x is within the string, e.g. name-Portrait@2x~ipad)
            NSString *path = [[NSBundle mainBundle] pathForResource:newName ofType:extension];
            NSData *data = [NSData dataWithContentsOfFile:path];
            image = [UIImage imageWithData:data scale:2.0];
        }
        //NFLog(@"image scale: %.1f", image.scale);
        return image;
    }

    // an image with a suffix was not found, call original implementation method
    return [self nextfazeImageNamed:imageName];
}

+ (UIImage *)nextfazeImageNamed:(NSString *)imageName {
    UIInterfaceOrientation orientation = UIDeviceOrientationUnknown;
    return [self imageNamed:imageName orientation:orientation];
}

+ (NSString *)suffixedNameForImageNamed:(NSString *)imageName orientation:(UIInterfaceOrientation)orientation {
    NSString *extension = IMAGE_EXTENSION(imageName);
    NSString *name = [imageName stringByDeletingPathExtension];
    
    // remove any @2x component of image name
    if([name hasSuffix:@"@2x"])
        name = [name substringToIndex:name.length - 3];
    
    // get the list of suffixes to search
    NSArray *searchSuffix = [self suffixSearchPathOrientation:orientation];
    for(NSString *suffix in searchSuffix) {
        // test for an existing file with this suffix
        NSString *name2 = [NSString stringWithFormat:@"%@%@", name, suffix];
        //NFLog(@"looking for resource: %@ ofType: %@", name2, extension);
        NSString *path = [[NSBundle mainBundle] pathForResource:name2 ofType:extension];
        // image found with this suffix, return new name
        if(path) {
            return name2;
        }
    }
    return nil;
}

// return the search path for the given image name
// <basename><orientation_modifier/usage_modifier><scale_modifier><device_modifier>.png
+ (NSArray *)suffixSearchPathOrientation:(UIInterfaceOrientation)orientation {
    NSMutableArray *list = [NSMutableArray array];
    NSString *orientationModifier = (orientation == UIDeviceOrientationUnknown ? @"SKIP" :
                                     UIInterfaceOrientationIsPortrait(orientation) ? @"-Portrait" : @"-Landscape");
    NSString *orientationModifier2 = orientation == UIInterfaceOrientationPortraitUpsideDown ? @"-PortraintUpsideDown" : @"SKIP";
    NSString *usageModifier = [NFDeviceUtils is4inch] ? @"-568h" : @"SKIP";
    NSString *deviceModifier = [NFDeviceUtils isPad] ? @"~ipad" : @"~iphone";
    NSString *deviceModifier2 = [NFDeviceUtils is4inch] ? @"~568h" : @"SKIP";
    NSArray *scaleModifiers = [self retinaScaleModifiers];
    
    for(NSString *orientMod in @[orientationModifier2, orientationModifier, usageModifier, @""]) {
        if([orientMod isEqualToString:@"SKIP"]) continue;
        
        for(NSString *devMod in @[deviceModifier2, deviceModifier, @""]) {
            if([devMod isEqualToString:@"SKIP"]) continue;
            
            for(NSString *scaleMod in scaleModifiers) {
                [self addSearchPaths:list modifiers:@[orientMod, scaleMod, devMod]];
            }
        }
    }

    //NFLog(@"suffix search list: %@", list);

    return list;
}

+ (void)addSearchPaths:(NSMutableArray *)list modifiers:(NSArray *)modifiers {
    NSString *path = [modifiers componentsJoinedByString:@""];
    [list addObject:path];
}

+ (NSArray *)retinaScaleModifiers {
    NSMutableArray *list = [NSMutableArray array];
    [list addObject:@"@2x"];
    [list addObject:@""];

    // if on a non-retina device, look for images without a @2x extension first
    return isRetina ? list : [[list reverseObjectEnumerator] allObjects];
}

@end
