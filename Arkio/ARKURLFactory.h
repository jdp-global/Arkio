//
//  ARKURLFactory.h
//  Arkio
//
//  Created by Ray Scott on 25/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

#import "Arkio.h"

/**
 *  Creates Data.com API Request URLs for an `ARKSession`.
 */
@interface ARKURLFactory : NSObject

/**
 *  The session this factory generates API Request URL's for.
 */
@property ARKSession *session;

#pragma mark - Designated Object Initializers

///----------------------------------------------
/// @name Creating and Initializing a URL Factory
///----------------------------------------------

/**
 *  Creates and initializes a URL factory for the given session.
 *
 *  @param session The `ARKSession` we want to create the URL factory for.
 *
 *  @return An `ARKURLFactory` initialized with the give session.
 */
- (instancetype)initWithSession:(ARKSession *)session;


#pragma mark - Constructing API Request URLs
#pragma mark - User / Authentication Request URLs

///-------------------------------------------
/// @name User and Authentication Request URLs
///-------------------------------------------

/**
 *  Creates a URL to authenticate the user with Data.com.
 *
 *  @return An `NSURL` built using the session's user authentication credentials and API server endpoint.
 */
- (NSURL *)userAuthURL;

/**
 *  Creates a URL to request the user's info from Data.com.
 *
 *  @return An `NSURL` that can be used to request the session user's info from Data.com.
 */
- (NSURL *)userInfoURL;


#pragma mark - Contact Request URLs

///---------------------------
/// @name Contact Request URLs
///---------------------------

/**
 *  Creates and returns a contact request URL with the given contact ID number.
 *
 *  @param contactID The ID number of the contact to request.
 *
 *  @return A contact request URL for the given contact ID.
 */
- (NSURL *)contactURLWithID:(long)contactID;

/**
 *  Creates and returns a contact search URL with the given search string and result offset.
 *
 *  @param string A string containing the text we want to use for a contact search.
 *  @param offset An `int` containing the offset from which to begin returning results from.
 *  @param size An `int` containing the number of results to return.
 *
 *  @return A contact search URL for the given search string and result offset.
 */
- (NSURL *)contactSearchURLWithString:(NSString *)string
                               offset:(int)offset
                                 size:(int)size;

/**
 *  Creates and returns a contact search URL with the given search parameters.
 *
 *  @param companyName The company name to limit the search results to.
 *  @param firstLast   The first and last name of a contact to limit the search results to.
 *  @param level       A `ARKContactLevel` to limit the search results to.
 *  @param offset      The number of search results by which to offset the response payload data.
 *  @param size        An `int` containing the number of results to return.
 *
 *  @return A contact search URL for the given search parameters.
 */
- (NSURL *)contactSearchURLWithCompanyName:(NSString *)companyName
                                 firstLast:(NSString *)firstLast
                                     level:(ARKContactLevel)level
                                    offset:(int)offset
                                      size:(int)size;

#pragma mark - Company Request URLs

///---------------------------
/// @name Company Request URLs
///---------------------------

/**
 *  Creates and returns a company statistics URL for requesting the contact count statistics for a given company ID.
 *
 *  @param companyID The unique identifier for a company in Data.com.
 *
 *  @return A company statistics URL for the given company ID.
 */
- (NSURL *)companyStatisticsURLWithID:(long)companyID;

/**
 *  Creates and returns a company search URL with the given search string and result offset.
 *
 *  @param string A string containing the text we want to use for a company search.
 *  @param offset A numeric offset which to begin returning results from.
 *  @param size An `int` containing the number of results to return.
 *  @param detailed Set to `YES` to have detailed information for each contact, otherwise set to `NO`.
 *
 *  @return A company search URL for the given search string and result offset.
 */
- (NSURL *)companySearchURLWithString:(NSString *)string
                               offset:(int)offset
                                 size:(int)size
                             detailed:(BOOL)detailed;

@end
