//
//  UIDevice+IEK.h
//  iOS Easy Kit
//
//  Created by Wei Jia Qiu on 11/28/11.
//  Copyright (c) 2011 Robert Qiu. All rights reserved.
//

//reference https://github.com/gekitz/UIDevice-with-UniqueIdentifier-for-iOS-5

#import <UIKit/UIKit.h>

@interface UIDevice (IEK)

- (NSString *)uniqueDeviceIdentifier;
- (NSString *)uniqueGlobalDeviceIdentifier;

@end
