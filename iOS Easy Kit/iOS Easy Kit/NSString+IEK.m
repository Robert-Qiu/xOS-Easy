//
//  NSString+IEK.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/24/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "NSString+IEK.h"
#import "IEKDigest.h"
#import "IEKHmac.h"
#import "IEKBase64.h"

@implementation NSString (IEK)

+ (NSString*)timestampString
{
    return [NSString stringWithFormat:@"%ld", time(NULL)];
}

+ (NSString*)UUIDString
{
    CFUUIDRef	uuidObj = CFUUIDCreate(nil); //create a new UUID
    NSString *uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);//get the string representation of the UUID
    CFRelease(uuidObj);
    return [uuidString autorelease];
}

- (NSString*)urlEncodedString
{
    NSArray *escapeChars = [NSArray arrayWithObjects:
                            @";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,
                            @"$" , @"," , @"[" , @"]",
                            @"#", @"!", @"'", @"(", 
                            @")", @"*", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:
                             @"%3B" , @"%2F" , @"%3F" , @"%3A",
                             @"%40" , @"%26" , @"%3D" , @"%2B" ,
                             @"%24" , @"%2C" , @"%5B" , @"%5D", 
                             @"%23", @"%21", @"%27", @"%28",
                             @"%29", @"%2A", nil];
    
    int len = [escapeChars count];
    
    NSMutableString *temp = [[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    
    int i;
    for(i = 0; i < len; i++){
        
            [temp replaceOccurrencesOfString: [escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString:temp];
    [temp release];
    return outStr;
}

- (NSString*)urlDecodedString
{
    return nil;
}

- (NSString*)base64EncodedString
{
    IEKBase64 *base64 = [[IEKBase64 alloc] init];
    return [base64 encodeString:self];
}

- (NSString*)base64DecodedString
{
    IEKBase64 *base64 = [[IEKBase64 alloc] init];
    return [base64 decodeString:self];
}
            
- (NSString*)MD5String
{
    IEKDigest *digest = [IEKDigest md5Digest];
    [digest addString:self];
    return [digest digestString];
}

- (NSString*)SHA1String
{
    IEKDigest *digest = [IEKDigest sha1Digest];
    [digest addString:self];
    return [digest digestString];
}

- (NSString*)hmacMD5StringWithKey:(NSString*)key 
{
    IEKHmac *hmac = [IEKHmac md5HmacWithStrKey:key];
    [hmac addString:self];
    return [hmac hmacString];
}

- (NSString*)hmacSHA1StringWithKey:(NSString*)key
{
    IEKHmac *hmac = [IEKHmac sha1HmacWithStrKey:key];
    [hmac addString:self];
    return [hmac hmacString];
}

@end
