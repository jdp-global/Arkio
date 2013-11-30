//
//  ARKContactSearchResult.h
//  Arkio
//
//  Created by Ray Scott on 30/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKEntitySearchResult.h"

/**
 *  Represents a single result response for a contact search.
 */
@interface ARKContactSearchResult : ARKEntitySearchResult

/**
 *  Returns a set of `ARKContact` objects.
 *
 *  @return A set containing the contact search results.
 */
- (NSSet *)contacts;


/**
 *  Sets the set of contacts as the search results.
 *
 *  @param contacts A set of `ARKContact` objects.
 */
- (void)setContacts:(NSSet *)contacts;

@end
