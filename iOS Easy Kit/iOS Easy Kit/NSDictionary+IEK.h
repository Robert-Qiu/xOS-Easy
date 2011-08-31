//
//  IEKDictionary+IEK.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/30/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IEKObject.h"

@interface NSDictionary (IEK)

+ (NSDictionary*)dictionaryForObject:(IEKObject*)object;
- (IEKObject*)createObjectFromClassName:(const char*)className;

@end
