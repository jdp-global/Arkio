//
//  ARKCompanyRequestTest.m
//  Arkio
//
//  Created by Ray Scott on 30/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKXCNetworkingTest.h"

#import "ARKCompany.h"

@interface ARKCompanyRequestTest : ARKXCNetworkingTest

@end

@implementation ARKCompanyRequestTest

/*
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
 */

- (void)testCompanyRequest
{
    long companyID = 159110;
    
    [self.session companyForID:companyID
                       success:^(ARKCompany *company, ARKError *error) {
                           if (error) {
                               XCTFail(@"%s failed with ARK error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                           }
                           else {
        
                               XCTAssertNotNil(company, @"no company object returned.");
                               XCTAssertEqual(companyID, [company companyID], @"company with ID \'%ld \' not returned.", companyID);
                           }
                       }
                       failure:^(NSError *error) {
                           XCTFail(@"%s failed with network error: %@",
                                   __PRETTY_FUNCTION__, [error localizedDescription]);
                           [self signalFinished];
                       }];
    
    [self waitUntilFinished];
}

@end
