//
//  ARKCompanyStatisticsRequestTest.m
//  Arkio
//
//  Created by Ray Scott on 28/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKXCNetworkingTest.h"

#import "ARKCompanyStatistics.h"

@interface ARKCompanyStatisticsRequestTest : ARKXCNetworkingTest

@end

@implementation ARKCompanyStatisticsRequestTest

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

- (void)testCompanyStatisticsRequest 
{    
    [self.session statisticsForCompanyID:159110l
                                 success:^(ARKCompanyStatistics *stats, ARKError *error) {
                                     
                                     if (error) {
                                         XCTFail(@"%s failed with ARK error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                                     }
                                     else {

                                         XCTAssertTrue([stats companyID] > 0, @"Stats company ID is missing.");
                                         XCTAssertNotNil([stats url], @"Stats page url is nil.");
                                         XCTAssertTrue([[stats departments] count] > 0, @"departments missing.");
                                         XCTAssertTrue([[stats levels] count] > 0, @"levels missing.");
                                     }
                                     [self signalFinished];
                                 }
                                 failure:^(NSError *error) {
                                     XCTFail(@"%s failed with network error: %@",
                                             __PRETTY_FUNCTION__, [error localizedDescription]);
                                     [self signalFinished];
                                 }
     ];
    
    [self waitUntilFinished];
}

@end
