//
//  ARKCompanySearchResult.h
//  Arkio
//
//  Created by Ray Scott on 29/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKEntitySearchResult.h"

/**
 *  Represents a single result response for a company search.
 */
@interface ARKCompanySearchResult : ARKEntitySearchResult

/**
 *  Returns a set of `ARKCompany` objects.
 *
 *  @return A set containing the company search results.
 */
- (NSSet *)companies;


/**
 *  Sets the set of companies as the search results.
 *
 *  @param companies A set of `ARKCompany` objects.
 */
- (void)setCompanies:(NSSet *)companies;

@end
