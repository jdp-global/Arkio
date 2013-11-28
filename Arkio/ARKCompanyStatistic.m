//
//  ARKCompanyStatistic.m
//  Arkio
//
//  Created by Ray Scott on 28/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKCompanyStatistic.h"

@implementation ARKCompanyStatistic

#pragma mark - Designated Object Initializers

- (id)initWithGroupType:(ARKStatisticGroupType)type
{
    self = [super init];
    if (self) {
        self.group = type;
    }
    return self;
}

@end
