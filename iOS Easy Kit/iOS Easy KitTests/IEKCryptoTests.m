//
//  iOS_Easy_KitTests.m
//  iOS Easy KitTests
//
//  Created by Wei Jia Qiu on 8/24/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "IEKCryptoTests.h"
#import "IEKDigest.h"
#import "IEKHmac.h"

@implementation IEKCryptoTests

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

- (void)testDegistMD5
{
    IEKDigest *digest = [IEKDigest md5Digest];
    NSString *str1 = @"The quick brown fox jumps over the lazy dog";
    [digest addString:str1];
    STAssertEqualObjects(@"9e107d9d372bb6826bd81d3542a419d6", [[digest digestString] lowercaseString], @"digest string md5 test 1 failed!");
    
    [digest reset];
    [digest addBytes:(void*)[str1 UTF8String] length:[str1 lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    STAssertEqualObjects(@"9e107d9d372bb6826bd81d3542a419d6", [[digest digestString] lowercaseString], @"digest bytes md5 test 1 failed!");
    
    [digest reset];
    [digest addData:[str1 dataUsingEncoding:NSUTF8StringEncoding]];
    STAssertEqualObjects(@"9e107d9d372bb6826bd81d3542a419d6", [[digest digestString] lowercaseString], @"digest data md5 test 1 failed!");
    
    [digest reset];
    [digest addString:@""];
    STAssertEqualObjects(@"d41d8cd98f00b204e9800998ecf8427e", [[digest digestString] lowercaseString], @"digest string md5 test 2 failed");
    
    [digest reset];
    [digest addBytes:(void*)[@"" UTF8String] length:[@"" lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    STAssertEqualObjects(@"d41d8cd98f00b204e9800998ecf8427e", [[digest digestString] lowercaseString], @"digest bytes md5 test 2 failed");
    
    [digest reset];
    [digest addData:[NSData data]];
    STAssertEqualObjects(@"d41d8cd98f00b204e9800998ecf8427e", [[digest digestString] lowercaseString], @"digest data md5 test 2 failed!");
    
    [digest reset];
    [digest addString:nil];
    STAssertEqualObjects(@"d41d8cd98f00b204e9800998ecf8427e", [[digest digestString] lowercaseString], @"digest md5 string test 3 failed");
    
    [digest reset];
    [digest addBytes:NULL length:10];
    STAssertEqualObjects(@"d41d8cd98f00b204e9800998ecf8427e", [[digest digestString] lowercaseString], @"digest md5 bytes test 3 failed");
    
    [digest reset];
    [digest addData:nil];
    STAssertEqualObjects(@"d41d8cd98f00b204e9800998ecf8427e", [[digest digestString] lowercaseString], @"digest md5 databu test 3 failed");
}


- (void)testDegistSHA1
{
    IEKDigest *digest = [IEKDigest sha1Digest];
    NSString *str1 = @"The quick brown fox jumps over the lazy dog";
    [digest addString:str1];
    STAssertEqualObjects(@"2fd4e1c67a2d28fced849ee1bb76e7391b93eb12", [[digest digestString] lowercaseString], @"digest string sha1 test 1 failed!");
    
    [digest reset];
    [digest addBytes:(void*)[str1 UTF8String] length:[str1 lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    STAssertEqualObjects(@"2fd4e1c67a2d28fced849ee1bb76e7391b93eb12", [[digest digestString] lowercaseString], @"digest bytes sha1 test 1 failed!");
    
    [digest reset];
    [digest addData:[str1 dataUsingEncoding:NSUTF8StringEncoding]];
    STAssertEqualObjects(@"2fd4e1c67a2d28fced849ee1bb76e7391b93eb12", [[digest digestString] lowercaseString], @"digest data sha1 test 1 failed!");
    
    [digest reset];
    [digest addString:@""];
    STAssertEqualObjects(@"da39a3ee5e6b4b0d3255bfef95601890afd80709", [[digest digestString] lowercaseString], @"digest string sha1 test 2 failed");
    
    [digest reset];
    [digest addBytes:(void*)[@"" UTF8String] length:[@"" lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    STAssertEqualObjects(@"da39a3ee5e6b4b0d3255bfef95601890afd80709", [[digest digestString] lowercaseString], @"digest bytes sha1 test 2 failed");
    
    [digest reset];
    [digest addData:[NSData data]];
    STAssertEqualObjects(@"da39a3ee5e6b4b0d3255bfef95601890afd80709", [[digest digestString] lowercaseString], @"digest data sha1 test 2 failed!");
    
    [digest reset];
    [digest addString:nil];
    STAssertEqualObjects(@"da39a3ee5e6b4b0d3255bfef95601890afd80709", [[digest digestString] lowercaseString], @"digest string sha1 test 3 failed");
    
    [digest reset];
    [digest addBytes:NULL length:10];
    STAssertEqualObjects(@"da39a3ee5e6b4b0d3255bfef95601890afd80709", [[digest digestString] lowercaseString], @"digest bytes sha1 test 3 failed");
    
    [digest reset];
    [digest addData:nil];
    STAssertEqualObjects(@"da39a3ee5e6b4b0d3255bfef95601890afd80709", [[digest digestString] lowercaseString], @"digest data sha1 test 3 failed");
}

- (void)testHmacMD5
{
    IEKHmac *hmac = [IEKHmac md5HmacWithStrKey:@""];
    [hmac addString:@""];
    STAssertEqualObjects(@"74e6f7298a9c2d168935f58c001bad88", [[hmac hmacString] lowercaseString], @"hmac string md5 test 1 failed");
    
    hmac = [IEKHmac md5HmacWithStrKey:@"key"];
    [hmac addString:@"The quick brown fox jumps over the lazy dog"];
    STAssertEqualObjects(@"80070713463e7749b90c2dc24911e275", [[hmac hmacString] lowercaseString], @"hmac string md5 test 2 failed");

}

- (void)testHmacSHA1
{
    
    IEKHmac *hmac = [IEKHmac sha1HmacWithStrKey:@""];
    [hmac addString:@""];
    STAssertEqualObjects(@"fbdb1d1b18aa6c08324b7d64b71fb76370690e1d", [[hmac hmacString] lowercaseString], @"hmac string sha1 test 1 failed");
    
    hmac = [IEKHmac sha1HmacWithStrKey:@"key"];
    [hmac addString:@"The quick brown fox jumps over the lazy dog"];
    STAssertEqualObjects(@"de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9", [[hmac hmacString] lowercaseString], @"hmac string sha1 test 2 failed");
 
}

@end
