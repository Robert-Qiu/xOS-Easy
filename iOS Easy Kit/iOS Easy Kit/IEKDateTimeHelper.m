//
//  IEKDateTimeHelper.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/31/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "IEKDateTimeHelper.h"

static IEKDateTimeHelper *_defaultHelper;

@implementation IEKDateTimeHelper

+ (IEKDateTimeHelper*)defaultHelper
{
    if (!_defaultHelper) {
        _defaultHelper = [[IEKDateTimeHelper alloc] init];
    }
    return _defaultHelper;
}

- (id)initWithCalendarIdentifier:(NSString*)key
{
    self = [super init];
    if (self) {
        curCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:key];
    }
    return self;
}

- (id)init
{
    return [self initWithCalendarIdentifier:NSGregorianCalendar];
}

- (NSDate*)dateByAddHours:(int)hours minutes:(int)minutes seconds:(int)seconds fromDate:(NSDate*)date
{
    return nil;
}

- (NSDate*)dateByAddDays:(int)days fromDate:(NSDate*)date
{
    return nil;
}

- (NSDate*)dateByAddWeeks:(int)weeks fromDate:(NSDate*)date
{
    return nil;
}

- (NSDate*)dateByAddMonths:(int)months fromDate:(NSDate*)date
{
    return nil;
}

- (NSDate*)dateByAddYears:(int)years fromDate:(NSDate*)date
{
    return nil;
}


@end
