//
//  IEKHmac.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/25/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>

typedef enum 
{
    IEKHmacMD5,
    IEKHmacSHA1
} IEKHmacType;

@interface IEKHmac : NSObject
{
    IEKHmacType type;
    CCHmacContext ctx;
    unsigned char *result;
    unsigned char *key;
    int keyLength;
}

+ (IEKHmac*)md5HmacWithStrKey:(NSString*)key;
+ (IEKHmac*)md5HmacWithBytesKey:(void*)bytes length:(int)len;
+ (IEKHmac*)sha1HmacWithStrKey:(NSString*)key;
+ (IEKHmac*)sha1HmacWithBytesKey:(void*)bytes length:(int)len;
- (id)initWithHmacType:(IEKHmacType)type strKey:(NSString*)key;
- (id)initWithHmacType:(IEKHmacType)type bytesKey:(void*)bytes length:(int)len;
- (id)initWithStrKey:(NSString*)key;
- (id)initWithBytekey:(void*)bytes length:(int)len;

- (void)reset;
- (void)addBytes:(void*)bytes length:(int)len;
- (void)addData:(NSData*)data;
- (void)addString:(NSString*)str;
- (unsigned char*)hmacBytes;
- (NSString*)hmacString;

@end
