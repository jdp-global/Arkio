//
//  ARKSerialization.h
//  Arkio
//
//  Created by Ray Scott on 25/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ARKError.h"
#import "ARKCompanyStatistics.h"
#import "ARKCompanySearchResult.h"
#import "ARKContactSearchResult.h"

/**
 *  Serializes JSON data into various objects.
 */
@interface ARKSerialization : NSObject


#pragma mark - User Account

///-------------------
/// @name User Account
///-------------------

/**
 *  Parses the number of user account points from a JSON object.
 *
 *  @param dictionary The JSON object to parse for a point balance.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return An integer containing the number of points available to the user.
 */
- (NSInteger)pointBalanceWithDictionary:(NSDictionary *)dictionary error:(ARKError * __autoreleasing *)error;

/**
 *  Parses the point balance from a JSON object.
 *
 *  @param dictionary The JSON object to parse for a point balance.
 *  @param key        The key for the point balance field in the JSON object.
 *  @param error      An error is set if something went wrong during parsing.
 *
 *  @return An integer containing the point balance.
 */
- (NSInteger)pointBalanceWithDictionary:(NSDictionary *)dictionary
                                    key:(NSString *)key
                                  error:(ARKError * __autoreleasing *)error;


#pragma mark - Contacts

///---------------
/// @name Contacts
///---------------

/**
 *  Parses a list of `ARKContact` objects from a JSON object.
 *
 *  @param dictionary The JSON object to parse for contacts.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return A set of `ARKContact` objects.
 */
- (NSSet *)contactsWithDictionary:(NSDictionary *)dictionary
                              error:(ARKError * __autoreleasing *)error;

/**
 *  Parses a contact search result set from a JSON object.
 *
 *  @param dictionary The JSON object to parse for contact search results.
 *  @param error      An error is set if something went wrong during parsing.
 *
 *  @return An `ARKContactSearchResult` object containing the search results response.
 */
- (ARKContactSearchResult *)contactSearchResultWithDictionary:(NSDictionary *)dictionary
                                                        error:(ARKError * __autoreleasing *)error;

#pragma mark - Companies and Related Data

///---------------------------------
/// @name Companies and Related Data
///---------------------------------

/**
 *  Parses a list of `ARKCompany` objects from a JSON object.
 *
 *  @param dictionary The JSON object to parse for companies.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return A set of `ARKCompany` objects.
 */
- (NSSet *)companiesWithDictionary:(NSDictionary *)dictionary
                             error:(ARKError * __autoreleasing *)error;


/**
 *  Parses a `ARKCompanyStatistics` object from a JSON object.
 *
 *  @param dictionary The JSON object to parse for company count statistics.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return A `ARKCompanyStatistics` object containing the count statistics
 */
- (ARKCompanyStatistics *)companyStatisticsWithDictionary:(NSDictionary *)dictionary
                                                    error:(ARKError * __autoreleasing *)error;

/**
 *  Parses a company search result set from a JSON object.
 *
 *  @param dictionary The JSON object to parse for company search results.
 *  @param error      An error is set if something went wrong during parsing.
 *
 *  @return An `ARKCompanySearchResult` object containing the search results response.
 */
- (ARKCompanySearchResult *)companySearchResultWithDictionary:(NSDictionary *)dictionary
                                                        error:(ARKError * __autoreleasing *)error;

#pragma mark - Error Handling

///---------------------
/// @name Error Handling
///---------------------

/**
 *  Parses an API error code from a JSON object.
 *
 *  @param dictionary  The JSON object to parse for an error code.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return an integer containing the error code or -1 (`ARKUnknownError`) if one wasn't found.
 */
- (NSInteger)errorCodeWithDictionary:(NSDictionary *)dictionary
                               error:(ARKError * __autoreleasing *)error;

/**
 *  Parses an NSError from a JSON object.
 *
 *  @param dictionary  The JSON object to parse for an error.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return An error object representing the underlying Data.com API error.
 */
- (ARKError *)errorWithDictionary:(NSDictionary *)dictionary
                            error:(ARKError * __autoreleasing *)error;



@end
