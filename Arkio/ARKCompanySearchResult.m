//
//  ARKCompanySearchResult.m
//  Arkio
//
//  Created by Ray Scott on 29/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKCompanySearchResult.h"

#import "NSObject+ARKFoundation.h"

@implementation ARKCompanySearchResult

- (NSSet *)companies
{
    return self.entities;
}

- (void)setCompanies:(NSSet *)companies
{
    self.entities = companies;
}

#pragma mark - NSObject Overrides
- (NSString *)description
{
    return [self autoDescription];
}

@end
