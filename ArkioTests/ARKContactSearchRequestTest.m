//
//  ARKContactSearchRequestTest.m
//  Arkio
//
//  Created by Ray Scott on 30/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKXCNetworkingTest.h"


@interface ARKContactSearchRequestTest : ARKXCNetworkingTest

@end

@implementation ARKContactSearchRequestTest


- (void)testContactSearchRequest
{
    // reference data
    NSString *firstLast = (NSString *)[self testDataForKey:@"arkio.xctest.contact.firstlast"];
    NSNumber *offset = (NSNumber *)[self testDataForKey:@"arkio.xctest.search.offset"];
    NSNumber *size = (NSNumber *)[self testDataForKey:@"arkio.xctest.search.size"];
    
    [self.session searchContactsWithString:firstLast
                                    offset:[offset intValue]
                                      size:[size intValue]
                                   success:^(ARKContactSearchResult *result, ARKError *error) {

                                       XCTAssertNil(error, @"%s failed with ARK error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                                       XCTAssertNotNil(result, @"%s no result object returned", __PRETTY_FUNCTION__);
                                       XCTAssertTrue([result totalHits] > 0, @"%s total hits returned is 0", __PRETTY_FUNCTION__);
                                       
                                       NSSet *contacts = [result contacts];
                                       XCTAssertNotNil(contacts, @"%s contacts set is nil", __PRETTY_FUNCTION__);
                                       XCTAssertTrue([contacts count] > 0, @"%s contacts set is empty", __PRETTY_FUNCTION__);

                                       NSArray *names = [firstLast componentsSeparatedByString:@" "];
                                       NSString *firstName = [names firstObject];
                                       NSString *lastName = [names lastObject];
                                       XCTAssertTrue([[[contacts anyObject] firstName] isEqualToString:firstName], @"%s incorrect first name in results for contact search", __PRETTY_FUNCTION__);
                                       XCTAssertTrue([[[contacts anyObject] lastName] isEqualToString:lastName], @"%s incorrect last name in results for contact search", __PRETTY_FUNCTION__);
                                       
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
