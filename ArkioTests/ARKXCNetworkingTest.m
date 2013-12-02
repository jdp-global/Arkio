//
//  ARKXCNetworkingTest.m
//  ArkioTests
//
//  Created by Ray Scott on 06/01/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ARKXCNetworkingTest.h"

//#import "AFNetworkActivityLogger.h"

@interface ARKXCNetworkingTest ()
@property dispatch_semaphore_t semaphore;
@property BOOL testFinished;

@end

@implementation ARKXCNetworkingTest
@synthesize loggingEnabled = _loggingEnabled;


- (void)setLoggingEnabled:(BOOL)enabled
{
    _loggingEnabled = enabled;
    
    if (_loggingEnabled) {
        
       // [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
       // [[AFNetworkActivityLogger sharedLogger] startLogging];
    }
    else {
       // [[AFNetworkActivityLogger sharedLogger] stopLogging];
    }
}

- (BOOL)loggingEnabled
{
    return _loggingEnabled;
}

- (void)setUp
{
    [super setUp];
    
    // init xctest instance
    _weakSelf = self;
    self.testFinished = NO;
    self.semaphore = dispatch_semaphore_create(0);
    [self setLoggingEnabled:YES];
    
    // load Info.plist properties
    ARKUserCredentials *creds = [[ARKUserCredentials alloc] initWithDictionary:[[NSBundle bundleForClass:[self class]] infoDictionary]];
    ARKUser *user = [[ARKUser alloc] initWithUserCredentials:creds];
    
    self.session = [[ARKSession alloc] initWithUser:user server:[[ARKServer alloc] init]];
    XCTAssertNotNil(self.session, @"ARKSession is nil");
    
    // load test data
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSString *dataFilePath = [testBundle pathForResource:@"ArkioTestData" ofType:@"plist"];
    self.testData = [NSDictionary dictionaryWithContentsOfFile:dataFilePath];
    XCTAssertNotNil(self.testData, @"no test data dictionary created from ArkioTestData.plist");
}

- (void)tearDown
{
    [super tearDown];
    
    if (self.loggingEnabled) {
        // [[AFNetworkActivityLogger sharedLogger] stopLogging];
    }
}

- (void)waitUntilFinished
{
    // Run loop
    while (dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
}

- (void)signalFinished
{
    self.testFinished = YES;
    dispatch_semaphore_signal(self.semaphore);
}

#pragma mark - XCTest Verification Methods
// this is part of a workaround for capturing strong self issues in blocks that use XCTest macros 
- (void)verifyResult:(void *)result
{
//    XCTAssertNotNil(result, @"%@ is nil", NSStringFromClass(result.class));
}

- (void)verifyFailure:(NSError *)error
{
    XCTFail(@"error = %@", [error localizedDescription]);
}

- (NSObject *)testDataForKey:(NSString *)key
{
    NSObject *obj = [self.testData objectForKey:key];
    XCTAssertNotNil(obj, @"Test Data Error: object for key \'%@\' converted to nil.", key);
    return obj;
}

@end
