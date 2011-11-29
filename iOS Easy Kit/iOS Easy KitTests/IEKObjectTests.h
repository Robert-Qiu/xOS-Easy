//
//  IEKObjectTests.h
//  iOS Easy Kit
//
//  Created by Wei Jia Qiu on 8/31/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <SenTestingKit/SenTestingKit.h>
#import "IEKObject.h"

@interface TestObject : IEKObject
{
    int  intValue;
    short shortValue;
    long longValue;
    long long longlongValue;
    unsigned char ucValue;
    unsigned int uiValue;
    unsigned short usValue;
    unsigned long ulValue;
    unsigned long long ullValue;
    float floatValue;
    double doubleValue;
    bool boolValue;
    
    NSString *strValue;
    NSDate *dateValue1;
    NSDate *dateValue2;
    NSDate *dateValue3;
}

@property (nonatomic, assign) int intValue;
@property (nonatomic, assign) short shortValue;
@property (nonatomic, assign) long longValue;
@property (nonatomic, assign) long long longlongValue;
@property (nonatomic, assign) unsigned char ucValue;
@property (nonatomic, assign) unsigned int uiValue;
@property (nonatomic, assign) unsigned short usValue;
@property (nonatomic, assign) unsigned long ulValue;
@property (nonatomic, assign) unsigned long long ullValue;
@property (nonatomic, assign) float floatValue;
@property (nonatomic, assign) double doubleValue;
@property (nonatomic, assign) bool boolValue;
@property (nonatomic, copy) NSString* strValue;
@property (nonatomic, retain) NSDate *dateValue1;
@property (nonatomic, retain) NSDate *dateValue2;
@property (nonatomic, retain) NSDate *dateValue3;
@property (nonatomic, assign) CGPoint point;

@end

@interface IEKObjectTests : SenTestCase



@end
