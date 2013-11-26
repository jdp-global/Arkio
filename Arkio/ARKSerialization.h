//
//  ARKSerialization.h
//  Arkio
//
//  Created by Ray Scott on 25/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Serializes JSON data into various objects.
 */
@interface ARKSerialization : NSObject


#pragma mark - User Account

///-------------------
/// @name User Account
///-------------------

/**
 *  Returns the number of points for a user account.
 *
 *  @param data  The JSON data to inspect for a point balance.
 *  @param error An error is set if something went wrong during the underlying JSON serialization.
 *
 *  @return an integer containing the number of points available to the user.
 */
- (NSInteger)pointBalanceWithData:(NSData *)data error:(NSError **)error;

///---------------------
/// @name Model Entities
///---------------------

#pragma mark - Contact Serialization

/**
 *  Parses a list of `ARKContact` objects from a block of JSON data.
 *
 *  @param data  The JSON data to parse for contacts.
 *  @param error An error is set if something went wrong during the underlying JSON serialization.
 *
 *  @return An array of `ARKContact` objects.
 */
- (NSArray *)contactsWithData:(NSData *)data error:(NSError **)error;

#pragma mark - Company Serialization

/**
 *  Parses a list of `ARKCompany` objects from a block of JSON data.
 *
 *  @param data  The JSON data to parse for companies.
 *  @param error An error is set if something went wrong during the underlying JSON serialization.
 *
 *  @return An array of `ARKCompany` objects.
 */
- (NSArray *)companiesWithData:(NSData *)data error:(NSError **)error;

#pragma mark - Error Handling

///---------------------
/// @name Error Handling
///---------------------

/**
 *  Parses an API error code from a block of JSON data.
 *
 *  @param data  The JSON data to inspect for an error code.
 *  @param error An error is set if something went wrong during the underlying JSON serialization.
 *
 *  @return an integer containing the error code or -1 (`ARKUnknownError`) if one wasn't found.
 */
- (NSInteger)errorCodeWithData:(NSData *)data error:(NSError **)error;

/**
 *  Parses an NSError from a block of JSON data for the given message key.
 *
 *  @param data  The JSON data to inspect for an error.
 *  @param key   The error message key to inspect the JSON data for.
 *  @param error An error is set if something went wrong during the underlying JSON serialization.
 *
 *  @return An error object representing the underlying Data.com API error.
 */
- (NSError *)errorWithData:(NSData *)data key:(NSString *)key error:(NSError **)error;

/**
 *  Parses an NSError from a block of JSON data.
 *
 *  @param data  The JSON data to inspect for an error.
 *  @param error An error is set if something went wrong during the underlying JSON serialization.
 *
 *  @return An error object representing the underlying Data.com API error.
 */
- (NSError *)errorWithData:(NSData *)data error:(NSError **)error;



@end
