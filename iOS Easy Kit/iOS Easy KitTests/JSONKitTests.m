//
//  JSONKitTests.m
//  iOS Easy Kit
//
//  Created by Wei Jia Qiu on 11/29/11.
//  Copyright (c) 2011 Robert Qiu. All rights reserved.
//

#import "JSONKitTests.h"
#import "JSONKit.h"

@implementation JSONKitTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testNSStringAddition
{
    NSString *jsonStr = @"{\"username\":\"用户\", \"password\":\"pass\"}";
    NSDictionary *decodedObj = [jsonStr objectFromJSONString];
    
    STAssertEqualObjects([decodedObj objectForKey:@"username"], @"用户", @"json parse error!");
    STAssertEqualObjects([decodedObj objectForKey:@"password"], @"pass", @"json parse error!");
}

@end
