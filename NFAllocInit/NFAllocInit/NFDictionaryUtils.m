//
//  DictionaryUtils.m
//  Toyota-Showroom-iPad
//
//  Created by Wade on 19/05/11.
//  Copyright 2011 NextFaze. All rights reserved.
//

#import "NFDictionaryUtils.h"


@implementation NFDictionaryUtils

//
// Returns an item from the specifified dictionary with the specified key, but only if the item is a dictionary.
//
+(NSDictionary*) getDictionaryWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey
{
	NSDictionary* pOutput = nil;
	
	id pTestDictionary = [pDictionary objectForKey:strKey];

	if ([pTestDictionary isKindOfClass:[NSDictionary class]])
		pOutput = pTestDictionary;
	
	return pOutput;
}


//
// Returns an item from the specifified dictionary with the specified key, but only if the item is an array.
//
+(NSArray*) getArrayWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey
{
	NSArray* pOutput = nil;
	
	id pTestArray = [pDictionary objectForKey:strKey];
	
	if ([pTestArray isKindOfClass:[NSArray class]])
		pOutput = pTestArray;
	
    // return an empty array instead of nil, so we don't have to test for nil later
    if(pOutput == nil)
        pOutput = [NSArray array];
    
	return pOutput;	
}


//
// Returns an item from the specifified dictionary with the specified key, but only if the item is a dictionary.
//
+(NSString*) getStringWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey
{
	NSString* pOutput = nil;
	
	id pTestString = [pDictionary objectForKey:strKey];
	
	if ([pTestString isKindOfClass:[NSString class]])
	{
		// Return the trimmed output
		pOutput = pTestString;
		pOutput = [pOutput stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
		
	return pOutput;
}

//
// Returns an item from the specifified dictionary with the specified key, but only if the item is a dictionary.
//
+(int) getIntWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey;
{
	return [NFDictionaryUtils getIntWithKeyFromDictionary:pDictionary key:strKey errorValue:0];
}

//
// Returns an item from the specifified dictionary with the specified key, but only if the item is a dictionary.
// Otherwise the default will be returned.
//
+(int) getIntWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey errorValue:(int)iDefault
{
	int iResult = iDefault;
	
	id pTestNumber = [pDictionary objectForKey:strKey];
	
	if ([pTestNumber isKindOfClass:[NSNumber class]])
		iResult = [pTestNumber intValue];
	else if ([pTestNumber isKindOfClass:[NSString class]])
		iResult = [pTestNumber intValue];
	
	return iResult;
}


//
// Returns an item from the specified dictionary.
//
+(BOOL) getBoolWithKeyFromDictionary:(NSDictionary*)pDictionary key:(NSString*)strKey;
{
	BOOL bOutput = NO;
	
	bOutput = [[pDictionary objectForKey:strKey] boolValue];
	
	return bOutput;
}

//
// Returns an item form the specifified dictionary with the specified key, but only if the item is a dictionary.
//
+(NSDictionary*) getDictionaryWithIndexFromArray:(NSArray*)aItems index:(int)iIndex
{
	NSDictionary* pOutput = nil;
	
	id pTestDictionary = [aItems objectAtIndex:iIndex];
	
	if ([pTestDictionary isKindOfClass:[NSDictionary class]])
		pOutput = pTestDictionary;
	
	return pOutput;
}


//
// Returns an item form the specifified dictionary with the specified key, but only if the item is a dictionary.
//
+(NSArray*) getArrayWithIndexFromArray:(NSArray*)aItems index:(int)iIndex
{
	NSArray* pOutput = nil;
	
	id pTestArray = [aItems objectAtIndex:iIndex];
	
	if ([pTestArray isKindOfClass:[NSArray class]])
		pOutput = pTestArray;
	
	return pOutput;		
}


//
// Returns an item form the specifified dictionary with the specified key, but only if the item is a dictionary.
//
+(NSString*) getStringWithIndexFromArray:(NSArray*)aItems index:(int)iIndex
{
	NSString* pOutput = nil;
	
	id pTestString = [aItems objectAtIndex:iIndex];
	
	if ([pTestString isKindOfClass:[NSString class]])
	{
		// Return the trimmed output
		pOutput = pTestString;
		pOutput = [pOutput stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
	
	return pOutput;
}


@end
