//
//  ARKAuthenticationRequestTest.m
//  Arkio
//
//  Created by Ray Scott on 27/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKXCNetworkingTest.h"

@interface ARKAuthenticationRequestTest : ARKXCNetworkingTest

@end

@implementation ARKAuthenticationRequestTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testAuthenticationRequest
{
    [self.session authenticate:^(BOOL authenticated, ARKError *error) {
        
        if (!authenticated) {
            XCTFail(@"Failed to authenticate default user credentials: %@", [error localizedDescription]);
        }
        
        NSLog(@"%s returned authentication value: %@", __PRETTY_FUNCTION__, authenticated ? @"YES" : @"NO");
        [self signalFinished];
    }
                       failure:^(NSError *error) {
                           XCTFail(@"Authentication test fail with error message: %@", [error localizedDescription]);
                           [self signalFinished];
    }];

    [self waitUntilFinished];
}

@end
