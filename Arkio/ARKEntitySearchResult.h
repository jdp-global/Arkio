//
//  ARKEntitySearchResult.h
//  Arkio
//
//  Created by Ray Scott on 30/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Represents a single result response for an entity search.
 */
@interface ARKEntitySearchResult : NSObject

/**
 *  The total number of entries in the database that match the search criteria.
 */
@property long totalHits;

/**
 *  The set of entities returned for a single entity search request.
 */
@property (nonatomic, strong) NSSet *entities;

@end
