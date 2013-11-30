//
//  ARKCompanySearchRequestTest.m
//  Arkio
//
//  Created by Ray Scott on 29/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKXCNetworkingTest.h"

#import "ARKCompanySearchResult.h"
#import "ARKCompany.h"

@interface ARKCompanySearchRequestTest : ARKXCNetworkingTest

@end

@implementation ARKCompanySearchRequestTest

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

- (void)testCompanySearchRequest
{
    [self.session searchCompaniesWithString:@"salesforce"
                                     offset:0
                                       size:20
                                   detailed:YES
                                    success:^(ARKCompanySearchResult *result, ARKError *error) {
                                        
                                        XCTAssertNotNil(result, @"no result object returned.");
                                        XCTAssertNotNil([result companies], @"no set of companies returned.");
                                        XCTAssertNotEqual([[result companies] count], 0, @"result set contains no company objects.");

                                        BOOL hasDetailedResults = NO;
                                        for (ARKCompany *company in [result companies]) {
                                            if ([company ownership] != nil) {
                                                hasDetailedResults = YES;
                                                break;
                                            }
                                        }
                                        
                                        XCTAssertTrue(hasDetailedResults, @"no detailed results found.");
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
