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

- (void)testUserInformationRequest
{
    [self.session userInformation:^(long points, ARKError *error) {
        
        XCTAssertNil(error, @"%s failed with ARK error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
        if (error) {
            XCTFail(@"%s failed with error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
        }
        XCTAssertNotEqual(points, -1, @"%s no points value found for test", __PRETTY_FUNCTION__);
        [self signalFinished];
        
    }
                          failure:^(NSError *error) {
                              
                              XCTFail(@"%s failed with network error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                              [self signalFinished];
                          }
     ];
    
    [self waitUntilFinished];
}

@end
