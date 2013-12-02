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

- (void)testCompanyStatisticsRequest 
{
    NSNumber *IDNumber = (NSNumber *)[self testDataForKey:@"arkio.xctest.company.id"];
    long companyID = [IDNumber longValue];
    
    [self.session statisticsForCompanyID:companyID
                                 success:^(ARKCompanyStatistics *stats, ARKError *error) {
                                     
                                     if (error) {
                                         XCTFail(@"%s failed with ARK error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                                     }
                                     else {

                                         XCTAssertTrue([stats companyID] == companyID, @"%s returned Company ID \'%ld\' doesn\'t match requested Company ID \'%ld\'",
                                                       __PRETTY_FUNCTION__,
                                                       [stats companyID],
                                                       companyID);
                                         
                                         XCTAssertNotNil([stats url], @"%s page url is nil", __PRETTY_FUNCTION__);
                                         XCTAssertTrue([[stats departments] count] > 0, @"%s departments missing", __PRETTY_FUNCTION__);
                                         XCTAssertTrue([[stats levels] count] > 0, @"%s levels missing", __PRETTY_FUNCTION__);
                                     }
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
