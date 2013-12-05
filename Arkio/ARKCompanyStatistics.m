//
//  ARKCompanyStatistics.m
//  Arkio
//
//  Created by Ray Scott on 28/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKCompanyStatistics.h"

#import "NSObject+ARKFoundation.h"

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

#pragma mark - NSObject Overrides
- (NSString *)description
{
    return [self autoDescription];
}

@end
