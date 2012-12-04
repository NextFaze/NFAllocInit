//
//  DictionaryUtils.h
//  Toyota-Showroom-iPad
//
//  Created by Wade on 19/05/11.
//  Copyright 2011 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NFDictionaryUtils : NSObject {

}


+(NSDictionary*) getDictionaryWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey;
+(NSArray*) getArrayWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey;
+(NSString*) getStringWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey;
+(int) getIntWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey;
+(int) getIntWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey errorValue:(int)iDefault;
+(BOOL) getBoolWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey;

+(NSDictionary*) getDictionaryWithIndexFromArray:(NSArray*)aItems index:(int)iIndex;
+(NSArray*) getArrayWithIndexFromArray:(NSArray*)aItems index:(int)iIndex;
+(NSString*) getStringWithIndexFromArray:(NSArray*)aItems index:(int)iIndex;


@end
