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

- (void)testAuthenticationRequest
{
    [self.session authenticate:^(BOOL authenticated, ARKError *error) {
        
        if (!authenticated) {
            XCTFail(@"%s failed to authenticate default user credentials: %@",
                    __PRETTY_FUNCTION__,
                    [error localizedDescription]);
        }
        [self signalFinished];
    }
                       failure:^(NSError *error) {
                           XCTFail(@"%s authentication test fail with error message: %@",
                                   __PRETTY_FUNCTION__,
                                   [error localizedDescription]);
                           [self signalFinished];
    }];

    [self waitUntilFinished];
}

@end
