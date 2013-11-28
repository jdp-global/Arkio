//
//  NSString+ARKNetworking.h
//  Arkio
//
//  Created by Ray Scott on 27/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Utilities for strings formatted to RFC 3986 http://tools.ietf.org/html/rfc3986
 */
@interface NSString (ARKNetworking)

/**
 *  Decodes a URL encoded UTF-8 string
 *
 *  @return a URL decoded string.
 */
- (NSString *)stringByDecodingURLFormat;

/**
 *  Creates a dictionary from the query parameters
 *
 *  @return A dictionary of key/values.
 */
- (NSDictionary *)dictionaryFromQueryComponents;

@end
