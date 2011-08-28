//
//  UIColor+IEK.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/28/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "UIColor+IEK.h"
#import "IEKColorManager.h"

@implementation UIColor (IEK)

+ (void)setColor:(UIColor*)color forKey:(NSString*)key
{
    [[IEKColorManager sharedManager] setColor:color forKey:key];
}

+ (UIColor*)colorForKey:(NSString*)key
{
   return [[IEKColorManager sharedManager] colorForKye:key];
}

@end
