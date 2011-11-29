//
//  IEKDigest.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/25/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "IEKDigest.h"

@interface IEKDigest(Private)

- (void)getDigest;

@end

@implementation IEKDigest

#pragma mark - init & release

+ (IEKDigest*)md5Digest
{
    return [[[IEKDigest alloc] initWithDigestType:IEKDigestMD5] autorelease];
}


+ (IEKDigest*)sha1Digest
{
    return [[[IEKDigest alloc] initWithDigestType:IEKDigestSHA1] autorelease];
}


- (id)init
{
    return [self initWithDigestType:IEKDigestMD5];
}


- (id)initWithDigestType:(IEKDigestType)aType
{
    if (self = [super init]) {
        md5Ctx = NULL;
        sha1Ctx = NULL;
        result = NULL;
        type = aType;
        [self reset];
    }
    return self;
}


- (void)dealloc
{
    if (md5Ctx) {
        free(md5Ctx);
    }
    if (sha1Ctx) {
        free(sha1Ctx);
    }
    if (result) {
        free(result);
    }
    [super dealloc];
}


- (void)reset
{
    if (result) {
        free(result);
    }
    
    switch(type) {
        
        case IEKDigestSHA1:
            result = malloc(CC_SHA1_DIGEST_LENGTH);
            if (sha1Ctx) {
                free(sha1Ctx);
            }
            sha1Ctx = malloc(sizeof(CC_SHA1_CTX));
            CC_SHA1_Init(sha1Ctx);
            break;
  
        case IEKDigestMD5:
        default:
            result = malloc(CC_MD5_DIGEST_LENGTH);
            if (md5Ctx) {
                free(md5Ctx);
            }
            md5Ctx = malloc(sizeof(CC_MD5_CTX));
            CC_MD5_Init(md5Ctx);
            break;
    }
}

#pragma mark - create digest

- (void)addBytes:(void*)bytes length:(int)len
{
    if (!bytes) {
        len = 0;
    }
    
    switch (type) {
            
        case IEKDigestSHA1:
            CC_SHA1_Update(sha1Ctx, bytes, len);
            break;
            
        case IEKDigestMD5:
        default:
            CC_MD5_Update(md5Ctx, bytes, len);
            break;
    }
}


- (void)addData:(NSData*)data
{
    switch (type) {
            
        case IEKDigestSHA1:
            CC_SHA1_Update(sha1Ctx, [data bytes], [data length]);
            break;
            
        case IEKDigestMD5:
        default:
            CC_MD5_Update(md5Ctx, [data bytes], [data length]);
            break;
    }
}


- (void)addString:(NSString*)str
{
    switch (type) {
            
        case IEKDigestSHA1:
            CC_SHA1_Update(sha1Ctx, [str UTF8String], [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
            break;
            
        case IEKDigestMD5:
        default:
            CC_MD5_Update(md5Ctx, [str UTF8String], [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
            break;
    }
}


- (unsigned char*)digestBytes
{
    [self getDigest];
    return result;
}

- (NSString*)digestString
{
    [self getDigest];
    
    NSString *resultStr = NULL;
    
    switch (type) {
        case IEKDigestSHA1:
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
        case IEKDigestMD5:
        default:
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
            break;
    }
    
    return resultStr;
}

- (void)getDigest
{
    switch (type) {
            
        case IEKDigestSHA1:
            CC_SHA1_Final(result, sha1Ctx);
            break;
            
        case IEKDigestMD5:
            CC_MD5_Final(result, md5Ctx);
        default:
            break;
    }
}

@end
