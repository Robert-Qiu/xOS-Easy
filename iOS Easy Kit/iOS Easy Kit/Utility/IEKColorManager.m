//
//  IEKColorManager.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/28/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "IEKColorManager.h"

static IEKColorManager* _sharedColorManager;

@implementation IEKColorManager

+ (IEKColorManager*)sharedManager
{
    if (!_sharedColorManager) {
        _sharedColorManager = [[IEKColorManager alloc] init];
    }
    return _sharedColorManager;
}


- (void)setColor:(UIColor*)color forKey:(NSString*)key
{
    [colorDic setObject:color forKey:key];
}

- (UIColor*)colorForKye:(NSString*)key
{
    return [colorDic objectForKey:key];
}

@end
