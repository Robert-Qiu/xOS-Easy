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

- (NSDate*)dateByAddHours:(int)hours minutes:(int)minutes seconds:(int)seconds toDate:(NSDate*)date
{
    NSDateComponents *addComponets = [[NSDateComponents alloc] init];
    [addComponets setHour:hours];
    [addComponets setMinute:minutes];
    [addComponets setSecond:seconds];
    NSDate* newDate = [curCalendar dateByAddingComponents:addComponets toDate:date options:0];
    [addComponets release];
    return newDate;
}

- (NSDate*)dateByAddDays:(int)days toDate:(NSDate*)date
{
    NSDateComponents *addComponets = [[NSDateComponents alloc] init];
    [addComponets setDay:days];
    NSDate* newDate = [curCalendar dateByAddingComponents:addComponets toDate:date options:0];
    [addComponets release];
    return newDate;

}

- (NSDate*)dateByAddWeeks:(int)weeks toDate:(NSDate*)date
{
    NSDateComponents *addComponets = [[NSDateComponents alloc] init];
    [addComponets setWeek:weeks];
    NSDate* newDate = [curCalendar dateByAddingComponents:addComponets toDate:date options:0];
    [addComponets release];
    return newDate;

}

- (NSDate*)dateByAddMonths:(int)months toDate:(NSDate*)date
{
    NSDateComponents *addComponets = [[NSDateComponents alloc] init];
    [addComponets setMonth:months];
    NSDate* newDate = [curCalendar dateByAddingComponents:addComponets toDate:date options:0];
    [addComponets release];
    return newDate;

}

- (NSDate*)dateByAddYears:(int)years toDate:(NSDate*)date
{
    NSDateComponents *addComponets = [[NSDateComponents alloc] init];
    [addComponets setYear:years];
    NSDate* newDate = [curCalendar dateByAddingComponents:addComponets toDate:date options:0];
    [addComponets release];
    return newDate;
}


@end
