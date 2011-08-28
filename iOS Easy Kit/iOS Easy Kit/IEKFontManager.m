//
//  IEKFontManager.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/28/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "IEKFontManager.h"

static IEKFontManager* _sharedFontManager;

@implementation IEKFontManager

+ (IEKFontManager*)sharedManager
{
    if (!_sharedFontManager) {
        _sharedFontManager = [[IEKFontManager alloc] init];
    }
    return _sharedFontManager;
}

- (void)setFont:(UIFont*)font forKey:(NSString*)key
{
    [fontDic setObject:font forKey:key];
}

- (UIFont*)fontForKey:(NSString*)key
{
    return [fontDic objectForKey:key];
}

@end
