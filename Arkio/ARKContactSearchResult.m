//
//  ARKContactSearchResult.m
//  Arkio
//
//  Created by Ray Scott on 30/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKContactSearchResult.h"

@implementation ARKContactSearchResult


- (NSSet *)contacts
{
    return self.entities;
}

- (void)setContacts:(NSSet *)contacts
{
    self.entities = contacts;
}
@end
