//
//  IEKHmac.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/25/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "IEKHmac.h"

@implementation IEKHmac

#pragma mark - init & release

+ (IEKHmac*)md5HmacWithStrKey:(NSString*)key
{
    return [[[IEKHmac alloc] initWithHmacType:IEKHmacMD5 strKey:key] autorelease];
}


+ (IEKHmac*)md5HmacWithBytesKey:(void*)bytes length:(int)len
{
    return [[[IEKHmac alloc] initWithHmacType:IEKHmacMD5 bytesKey:bytes length:len] autorelease];
}


+ (IEKHmac*)sha1HmacWithStrKey:(NSString*)key
{
    return [[[IEKHmac alloc] initWithHmacType:IEKHmacSHA1 strKey:key] autorelease];
}

+ (IEKHmac*)sha1HmacWithBytesKey:(void*)bytes length:(int)len
{
    return [[[IEKHmac alloc] initWithHmacType:IEKHmacSHA1 bytesKey:bytes length:len] autorelease];
}


- (id)initWithHmacType:(IEKHmacType)aType strKey:(NSString*)aKey
{
    return [self initWithHmacType:aType bytesKey:(void*)[aKey UTF8String] length:[aKey lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
}


- (id)initWithHmacType:(IEKHmacType)aType bytesKey:(void*)bytes length:(int)len
{
    if (self = [super init]) {
        result = NULL;
        type = aType;
        keyLength = len;
        key = malloc(keyLength);
        memcpy(key, bytes, keyLength);
        [self reset];
    }
    return self;
}

- (id)initWithStrKey:(NSString*)aKey
{
    return [self initWithHmacType:IEKHmacMD5 strKey:aKey];
}

- (id)initWithBytekey:(void*)bytes length:(int)len
{
    return [self initWithHmacType:IEKHmacMD5 bytesKey:bytes length:len];
}

- (id)init
{
    @throw [[NSException alloc] initWithName:@"non implemented methods" reason:@"use other initialization methods" userInfo:nil];
}


- (void)reset
{
    if (result) {
        free(result);
    }
    
    switch (type) {
        case IEKHmacSHA1:
            CCHmacInit(&ctx, kCCHmacAlgSHA1, key, keyLength);
            result = malloc(CC_SHA1_DIGEST_LENGTH);
            break;
        case IEKHmacMD5:
        default:
            CCHmacInit(&ctx, kCCHmacAlgMD5, key, keyLength);
            result = malloc(CC_MD5_DIGEST_LENGTH);
            break;
    }
}

#pragma mark - create HMAC

- (void)addBytes:(void*)bytes length:(int)len
{
    CCHmacUpdate(&ctx, bytes, len);
}


- (void)addData:(NSData*)data
{
    CCHmacUpdate(&ctx, [data bytes], [data length]);
}


- (void)addString:(NSString*)str
{
    CCHmacUpdate(&ctx, [str UTF8String], [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
}


- (unsigned char*)hmacBytes
{
    CCHmacFinal(&ctx, result);
    return result;
}


- (NSString*)hmacString
{
    CCHmacFinal(&ctx, result);
    
    NSString *resultStr;
    
    switch (type) {
        case IEKHmacSHA1:
            resultStr = [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                         result[0], result[1],
                         result[2], result[3],
                         result[4], result[5],
                         result[6], result[7],
                         result[8], result[9],
                         result[10], result[11],
                         result[12], result[13],
                         result[14], result[15],
                         result[16], result[17],
                         result[18], result[19]
                         ];
            break;
        case IEKHmacMD5:
            resultStr = [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                         result[0], result[1],
                         result[2], result[3],
                         result[4], result[5],
                         result[6], result[7],
                         result[8], result[9],
                         result[10], result[11],
                         result[12], result[13],
                         result[14], result[15]
                         ];
        default:
            break;
    }
    
    return resultStr;
}


@end
