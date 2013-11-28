//
//  ARKCompanyStatistics.m
//  Arkio
//
//  Created by Ray Scott on 28/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKCompanyStatistics.h"

@implementation ARKCompanyStatistics

#pragma mark - Designated Object Initializers

- (instancetype)initWithCompanyID:(long)companyID
{
    self = [super init];
    if (self) {
        self.companyID = companyID;
    }
    return self;
}


@end
