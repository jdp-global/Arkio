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
    [self.session searchContactsWithString:@"Ray"
                                    offset:0
                                      size:20
                                   success:^(ARKContactSearchResult *result, ARKError *error) {
                                       NSLog(@"blah");
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
