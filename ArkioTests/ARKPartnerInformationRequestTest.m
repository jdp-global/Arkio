//
//  ARKPartnerInformationRequestTest.m
//  Arkio
//
//  Created by Ray Scott on 02/12/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKXCNetworkingTest.h"

@interface ARKPartnerInformationRequestTest : ARKXCNetworkingTest

@end

@implementation ARKPartnerInformationRequestTest


- (void)testPartnerInformationRequest
{
    NSString *partnerToken = (NSString *)[self testDataForKey:@"arkio.xctest.partner.token"];
    ARKPartner *partner = [[ARKPartner alloc] init];
    [partner setAPIDeveloperToken:partnerToken];
    self.session = [[ARKSession alloc] initWithPartner:partner];
    
    [self.session partnerInformation:^(long points, ARKError *error) {

        if (error) {
            XCTFail(@"%s failed with error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
        }
        XCTAssertNotEqual(points, -1, @"%s no points value found for test", __PRETTY_FUNCTION__);
    
        [self signalFinished];
    }
                             failure:^(NSError *error) {
                                 XCTFail(@"%s failed with error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                                 [self signalFinished];
                             }
    ];
    
    [self waitUntilFinished];
}

@end
