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

@implementation NSString (NSString_IEK)

- (NSString*)urlEncodedString
{
    return nil;
}

- (NSString*)base64String
{
    return nil;
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
