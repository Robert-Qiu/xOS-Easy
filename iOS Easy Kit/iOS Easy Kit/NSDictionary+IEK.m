//
//  IEKDictionary+IEK.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/30/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "NSDictionary+IEK.h"
#include <objc/runtime.h>

@implementation NSDictionary (IEK)

+ (NSDictionary*)dictionaryForObject:(IEKObject*)object
{
    return [object dictionary];
}


- (IEKObject*)createObjectFromClassName:(const char*)className
{
    return [IEKObject objectForClassName:className fromDictionary:self];
}

@end
