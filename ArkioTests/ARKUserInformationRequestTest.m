//
//  ARKUserInformationRequestTest.m
//  Arkio
//
//  Created by Ray Scott on 28/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKXCNetworkingTest.h"

@interface ARKUserInformationRequestTest : ARKXCNetworkingTest

@end

@implementation ARKUserInformationRequestTest

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

- (void)testUserInformationRequest
{
    [self.session userInformation:^(long points, ARKError *error) {

        if (error) {
            XCTFail(@"%s failed with ARK error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
        }
        XCTAssertNotEqual(points, -1, @"No points value found for %s test", __PRETTY_FUNCTION__);
        NSLog(@"%s returned %ld points.", __PRETTY_FUNCTION__, points);
        [self signalFinished];
        
    } failure:^(NSError *error) {
        XCTFail(@"%s failed with network error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
        [self signalFinished];
    }];
    
    [self waitUntilFinished];
}

@end
