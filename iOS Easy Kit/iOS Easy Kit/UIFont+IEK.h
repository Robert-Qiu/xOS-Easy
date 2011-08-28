//
//  UIFont+IEK.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/28/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIFont (IEK)

+ (void)setFont:(UIFont*)font withKey:(NSString*)key;
+ (UIFont*)fontWithKey:(NSString*)key;

@end
