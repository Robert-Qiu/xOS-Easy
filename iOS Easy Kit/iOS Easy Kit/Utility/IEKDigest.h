//
//  IEKDigest.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/25/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

typedef enum 
{
    IEKDigestMD5,
    IEKDigestSHA1
} IEKDigestType;

@interface IEKDigest : NSObject {
    
    CC_MD5_CTX *md5Ctx;
    CC_SHA1_CTX *sha1Ctx;
    unsigned char *result;
    IEKDigestType type;
}

+ (IEKDigest*)md5Digest;
+ (IEKDigest*)sha1Digest;
- (id)initWithDigestType:(IEKDigestType)aType;
- (void)reset;
- (void)addBytes:(void*)bytes length:(int)len;
- (void)addData:(NSData*)data;
- (void)addString:(NSString*)str;
- (unsigned char*)digestBytes;
- (NSString*)digestString;

@end
