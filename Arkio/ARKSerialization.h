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
 *  @param dictionary The JSON object to inspect for a point balance.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return an integer containing the number of points available to the user.
 */
- (NSInteger)pointBalanceWithDictionary:(NSDictionary *)dictionary error:(ARKError **)error;

#pragma mark - Contacts

///---------------
/// @name Contacts
///---------------

/**
 *  Parses a list of `ARKContact` objects from a JSON object.
 *
 *  @param data  The JSON object to inspect for contacts.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return An array of `ARKContact` objects.
 */
- (NSArray *)contactsWithData:(NSData *)data error:(ARKError **)error;

#pragma mark - Companies and Related Data

///---------------------------------
/// @name Companies and Related Data
///---------------------------------

/**
 *  Parses a list of `ARKCompany` objects from a JSON object.
 *
 *  @param data  The JSON object to parse for companies.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return An array of `ARKCompany` objects.
 */
- (NSArray *)companiesWithData:(NSData *)data error:(ARKError **)error;


/**
 *  Parses a `ARKCompanyStatistics` object from a JSON object.
 *
 *  @param dictionary The JSON object to parse for company count statistics.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return A `ARKCompanyStatistics` object containing the count statistics
 */
- (ARKCompanyStatistics *)companyStatisticsWithDictionary:(NSDictionary *)dictionary
                                                    error:(ARKError **)error;

#pragma mark - Error Handling

///---------------------
/// @name Error Handling
///---------------------

/**
 *  Parses an API error code from a JSON object.
 *
 *  @param data  The JSON object to inspect for an error code.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return an integer containing the error code or -1 (`ARKUnknownError`) if one wasn't found.
 */
- (NSInteger)errorCodeWithData:(NSData *)data error:(ARKError **)error;

/**
 *  Parses an NSError from a JSON object for the given message key.
 *
 *  @param data  The JSON object to inspect for an error.
 *  @param key   The error message key to inspect the JSON object for.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return An error object representing the underlying Data.com API error.
 */
- (NSError *)errorWithData:(NSData *)data key:(NSString *)key error:(ARKError **)error;

/**
 *  Parses an NSError from a JSON object.
 *
 *  @param data  The JSON object to inspect for an error.
 *  @param error An error is set if something went wrong during parsing.
 *
 *  @return An error object representing the underlying Data.com API error.
 */
- (NSError *)errorWithData:(NSData *)data error:(ARKError **)error;



@end
