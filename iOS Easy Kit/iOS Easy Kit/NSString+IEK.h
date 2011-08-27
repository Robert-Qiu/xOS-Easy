//
//  NSString+IEK.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/24/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IEK)

- (NSString*)urlEncodedString;
- (NSString*)urlDecodedString;
- (NSString*)base64EncodedString;
- (NSString*)base64DecodedString;
- (NSString*)MD5String;
- (NSString*)SHA1String;
- (NSString*)hmacMD5StringWithKey:(NSString*)key;
- (NSString*)hmacSHA1StringWithKey:(NSString*)key;

@end
