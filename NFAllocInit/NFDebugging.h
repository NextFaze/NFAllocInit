//
//  NFDebugging.h
//
//  Copyright 2012 NextFaze. All rights reserved.
//

// "DEBUG=1" needs to be added to the "Preprocessor Macros" for the Debug configuration

#ifdef DEBUG
    #define NFLog(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);
#else
    #define NFLog(format, ...) ; // null statement
#endif

#define NSStringFromBool(value) (value ? @"YES" : @"NO")
