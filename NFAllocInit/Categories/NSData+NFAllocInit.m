//
//  NSData+Base64
//
//  Created by Andreas Wulf.
//  Copyright 2012 NextFaze. All rights reserved.
//

#import "NSData+NFAllocInit.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSData (NFAllocInit)

- (NSString *)encodeToBase64 {  
	NSData *plainText = self;
	
	char *alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	
    int encodedLength = (((([plainText length] % 3) + [plainText length]) / 3) * 4) + 1;  
    unsigned char *outputBuffer = malloc(encodedLength);  
    unsigned char *inputBuffer = (unsigned char *)[plainText bytes];  
	
    NSInteger i;  
    NSInteger j = 0;  
    int remain;  
	
    for(i = 0; i < [plainText length]; i += 3) {  
        remain = [plainText length] - i;  
		
        outputBuffer[j++] = alphabet[(inputBuffer[i] & 0xFC) >> 2];  
        outputBuffer[j++] = alphabet[((inputBuffer[i] & 0x03) << 4) |   
                                     ((remain > 1) ? ((inputBuffer[i + 1] & 0xF0) >> 4): 0)];  
		
        if(remain > 1)  
            outputBuffer[j++] = alphabet[((inputBuffer[i + 1] & 0x0F) << 2)  
                                         | ((remain > 2) ? ((inputBuffer[i + 2] & 0xC0) >> 6) : 0)];  
        else   
            outputBuffer[j++] = '=';  
		
        if(remain > 2)  
            outputBuffer[j++] = alphabet[inputBuffer[i + 2] & 0x3F];  
        else  
            outputBuffer[j++] = '=';              
    }  
	
    outputBuffer[j] = 0;  
	
    NSString *result = [NSString stringWithCString:(const char *)outputBuffer encoding:NSUTF8StringEncoding];
    free(outputBuffer);  
	
    return result;  
}  

- (NSString *)md5 {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, [self length], result);
    return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

@end
