//
//  ARKUser.m
//  Arkio
//
//  Created by Ray Scott on 22/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKUser.h"

@implementation ARKUser

#pragma mark - Designated Object Initializers

- (instancetype)initWithUserCredentials:(ARKUserCredentials *)credendials
{
    self = [super init];
    if (self) {
        self.credentials = credendials;
    }
    return self;
}


#pragma mark - Convenience Methods
- (BOOL)hasPoints
{
#warning find out why, historically, we're equating zero points, with hasPoints = TRUE.
    return (self.points >= 0);
}

@end
