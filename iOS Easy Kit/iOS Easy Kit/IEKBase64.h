//
//  IEKBase64.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/27/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IEKBase64 : NSObject
{

}

- (NSString*)encodeString:(NSString*)str;
- (NSString*)encodeData:(NSData*)data;
- (NSString*)encodeBytes:(void*)bytes length:(NSUInteger)len;

//users are responsible to free output buffer
- (void)decodeString:(NSString*)str output:(void**)output length:(NSUInteger*)len;
- (NSString*)decodeString:(NSString*)str;

//users are responsible to free output buffer
- (void)decodeBytes:(void*)bytes length:(NSUInteger)len output:(void**)output length:(NSUInteger*)len;
- (NSString*)decodeBytes:(void*)bytes length:(NSUInteger)len;

@end
