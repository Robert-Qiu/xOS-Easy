//
//  UIFont+IEK.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/28/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "UIFont+IEK.h"
#import "IEKFontManager.h"

@implementation UIFont (IEK)

+ (void)setFont:(UIFont*)font withKey:(NSString*)key
{
    [[IEKFontManager sharedManager] setFont:font forKey:key];
}

+ (UIFont*)fontWithKey:(NSString*)key
{
    return [[IEKFontManager sharedManager] fontForKey:key];
}

@end
