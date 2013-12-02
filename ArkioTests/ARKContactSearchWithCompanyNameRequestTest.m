//
//  ARKContactSearchWithCompanyNameRequestTest.m
//  Arkio
//
//  Created by Ray Scott on 02/12/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKXCNetworkingTest.h"

@interface ARKContactSearchWithCompanyNameRequestTest : ARKXCNetworkingTest

@end

@implementation ARKContactSearchWithCompanyNameRequestTest

- (void)testContactSearchWithCompanyNameRequest
{
    NSString *company = (NSString *)[self testDataForKey:@"arkio.xctest.company.name"];
    NSString *firstLast = (NSString *)[self testDataForKey:@"arkio.xctest.contact.firstlast"];
    NSNumber *level = (NSNumber *)[self testDataForKey:@"arkio.xctest.contact.level"];
    NSNumber *offset = (NSNumber *)[self testDataForKey:@"arkio.xctest.search.offset"];
    NSNumber *size = (NSNumber *)[self testDataForKey:@"arkio.xctest.search.size"];
    
    [self.session searchContactsWithCompanyName:company
                                      firstLast:firstLast
                                          level:[level intValue]
                                         offset:[offset intValue]
                                           size:[size intValue]
                                        success:^(ARKContactSearchResult *result, ARKError *error) {
                                            
                                            XCTAssertNotNil(result, @"%s no result object returned", __PRETTY_FUNCTION__);
                                            XCTAssertTrue([result totalHits] > 0, @"%s total hits returned is 0", __PRETTY_FUNCTION__);
                                            
                                            NSSet *contacts = [result contacts];
                                            XCTAssertNotNil(contacts, @"%s contacts set is nil", __PRETTY_FUNCTION__);
                                            XCTAssertTrue([contacts count] > 0, @"%s contacts set is empty", __PRETTY_FUNCTION__);
                                            
                                            NSArray *names = [firstLast componentsSeparatedByString:@" "];
                                            NSString *firstName = [names firstObject];
                                            NSString *lastName = [names lastObject];
                                            XCTAssertTrue([[[contacts anyObject] firstName] isEqualToString:firstName],
                                                          @"%s result first name \'%@\'in doesn't match request first name \'%@\'",
                                                          __PRETTY_FUNCTION__,
                                                          [[contacts anyObject] firstName], firstName);
                                            
                                            XCTAssertTrue([[[contacts anyObject] lastName] isEqualToString:lastName],
                                                          @"%s result last name \'%@\'in doesn't match request last name \'%@\'",
                                                          __PRETTY_FUNCTION__,
                                                          [[contacts anyObject] lastName],
                                                          lastName);
                                            
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
