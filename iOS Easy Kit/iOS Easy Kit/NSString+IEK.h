//
//  NSString+IEK.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/24/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_IEK)

- (NSString*)urlEncodedString;
- (NSString*)base64String;
- (NSString*)MD5String;
- (NSString*)SHA1String;
- (NSString*)hmacMD5StringWithKey:(NSString*)key;
- (NSString*)hmacSHA1StringWithKey:(NSString*)key;

@end
