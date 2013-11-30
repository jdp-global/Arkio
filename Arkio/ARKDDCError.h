//
//  ARKDDCError.h
//  Arkio
//
//  Created by Ray Scott on 29/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKError.h"

/**
 *  Represents an error returned from the Data.com system.
 */
@interface ARKDDCError : ARKError

/**
 *  Creates an error with the Data.com API error domain and the given parameters.
 *
 *  @param code    The Data.com API error code for the error.
 *  @param message The message for the error.
 *
 *  @return An NSError object in the `ARKDDCErrorDomain` with the specified error code and message.
 */
+ (id)errorWithCode:(NSInteger)code message:(NSString *)message;

/**
 *  Creates an error with the Data.com API error domain and the given parameters.
 *
 *  @param code The Data.com API error code for the error.
 *  @param dict The userInfo dictionary for the error. userInfo may be nil.
 *
 *  @return An NSError object in the `ARKDDCErrorDomain` with the specified error code and the dictionary of arbitrary data userInfo.
 */
+ (id)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict;

/**
 *  Creates an error with the Data.com API error domain and the given parameters.
 *
 *  @param code The Data.com API error code for the error.
 *  @param dict The userInfo dictionary for the error. userInfo may be nil.
 *
 *  @return An NSError object in the `ARKDDCErrorDomain` with the specified error code and the dictionary of arbitrary data userInfo.
 */
- (id)initWithCode:(NSInteger)code userInfo:(NSDictionary *)dict;

@end

/**
 *  Data.com Error Domain
 */
extern NSString * const ARKDDCErrorDomain;

