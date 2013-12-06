//
//  ARKContactGetRequestTest.m
//  Arkio
//
//  Created by Ray Scott on 06/12/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKXCNetworkingTest.h"

@interface ARKContactGetRequestTest : ARKXCNetworkingTest

@end

@implementation ARKContactGetRequestTest

- (void)testContactGetRequest
{
    __block NSNumber *contactNumber = (NSNumber *)[self testDataForKey:@"arkio.xctest.contact.id"];
    
    [self.session contactWithID:[contactNumber longValue]
                        success:^(ARKContact *contact, ARKError *error) {
                            
                            XCTAssertNil(error, @"%s failed with ARK error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                            XCTAssertNotNil(contact, @"no contact object returned.");
                            XCTAssertEqual([contactNumber longValue],
                                           [contact contactId],
                                           @"Returned contact ID doesn't match requested contact ID.");
                            
                            [self signalFinished];
                        }
                        failure:^(NSError *error) {
                            XCTFail(@"%s failed with network error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                            [self signalFinished];

                        }];
    
    [self waitUntilFinished];
}

@end
