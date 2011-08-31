//
//  IEKObject.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/30/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//
//  Rewrite some Key-Value related methods of NSObject 

#import <Foundation/Foundation.h>

@interface IEKObject : NSObject
{
    
}

+ (void)registerDateFormat:(NSString*)formatStr;
+ (IEKObject*)objectForClassName:(const char*)className;
+ (IEKObject*)objectForClassName:(const char*)className fromDictionary:(NSDictionary*)dic;
- (void)setDate:(id)value forKey:(NSString*)key;
- (NSDictionary*)dictionary;

@end
