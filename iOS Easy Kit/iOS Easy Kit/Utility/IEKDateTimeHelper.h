//
//  IEKDateTimeHelper.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/31/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IEKDateTimeHelper : NSObject
{
    NSCalendar *curCalendar;
}

+ (IEKDateTimeHelper*)defaultHelper;
- (id)initWithCalendarIdentifier:(NSString*)key;

- (NSDate*)dateByAddHours:(int)hours minutes:(int)minutes seconds:(int)seconds toDate:(NSDate*)date;
- (NSDate*)dateByAddDays:(int)days toDate:(NSDate*)date;
- (NSDate*)dateByAddWeeks:(int)weeks toDate:(NSDate*)date;
- (NSDate*)dateByAddMonths:(int)months toDate:(NSDate*)date;
- (NSDate*)dateByAddYears:(int)years toDate:(NSDate*)date;;


@end
