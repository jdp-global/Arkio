//
//  ARKPartner.m
//  Arkio
//
//  Created by Ray Scott on 02/12/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKPartner.h"

@implementation ARKPartner

#pragma mark - Designated Object Initializers

- initWithAPIDeveloperToken:(NSString *)token
{
    self = [super init];
    if (self) {
        self.APIDeveloperToken = token;
    }
    return self;
}

@end
