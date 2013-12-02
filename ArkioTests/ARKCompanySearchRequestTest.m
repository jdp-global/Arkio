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

- (void)testCompanySearchRequest
{
    NSString *string = (NSString *)[self testDataForKey:@"arkio.xctest.company.name"];
    NSNumber *offset = (NSNumber *)[self testDataForKey:@"arkio.xctest.search.offset"];
    NSNumber *size = (NSNumber *)[self testDataForKey:@"arkio.xctest.search.size"];
    BOOL detailed = [(NSString *)[self testDataForKey:@"arkio.xctest.search.detailed"] boolValue];
    
    [self.session searchCompaniesWithString:string
                                     offset:[offset intValue]
                                       size:[size intValue]
                                   detailed:detailed
                                    success:^(ARKCompanySearchResult *result, ARKError *error) {
                                        
                                        XCTAssertNotNil(result, @"%s no result object returned", __PRETTY_FUNCTION__);
                                        XCTAssertNotNil([result companies], @"%s no set of companies returned", __PRETTY_FUNCTION__);
                                        XCTAssertNotEqual([[result companies] count], 0, @"%s result set contains no company objects",
                                                          __PRETTY_FUNCTION__);

                                        BOOL hasDetailedResults = NO;
                                        for (ARKCompany *company in [result companies]) {
                                            if ([company ownership] != nil) {
                                                hasDetailedResults = YES;
                                                break;
                                            }
                                        }
                                        XCTAssertEqual(detailed, hasDetailedResults,
                                                       @"%s result detail, %@, doesn't match request detailed, %@",
                                                       __PRETTY_FUNCTION__,
                                                       detailed ? @"YES" : @"NO",
                                                       hasDetailedResults ? @"YES" : @"NO");
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
