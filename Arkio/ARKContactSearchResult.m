//
//  ARKContactSearchResult.m
//  Arkio
//
//  Created by Ray Scott on 30/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKContactSearchResult.h"

#import "NSObject+ARKFoundation.h"

@implementation ARKContactSearchResult

- (NSSet *)contacts
{
    return self.entities;
}

- (void)setContacts:(NSSet *)contacts
{
    self.entities = contacts;
}

#pragma mark - NSObject Overrides

- (NSString *)description
{
    return [self autoDescription];
}

@end
