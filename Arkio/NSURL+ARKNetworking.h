//
//  NSURL+ARKNetworking.h
//  Arkio
//
//  Created by Ray Scott on 27/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Utilities for NSURL's query string.
 */
@interface NSURL (ARKNetworking)

/**
 *  Returns a dictionary of the URL's query parameters.
 *
 *  @return a dictionary containing the URL's query parameters.
 */
- (NSDictionary *)queryDictionary;

@end
