//
//  ARKError.h
//  Arkio
//
//  Created by Ray Scott on 25/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  Represents an error in the Arkio library
 */
@interface ARKError : NSError

#pragma mark - Designated Object Initializers

/**
 *  Creates an error with the default ARK error domain and the given parameters.
 *
 *  @param code    The error code for the error.
 *  @param message The message for the error.
 *
 *  @return An NSError object in the `ARKErrorDomain` with the specified error code and message.
 */
+ (id)errorWithCode:(NSInteger)code message:(NSString *)message;

/**
 *  Creates an error with the default ARK error domain and the given parameters.
 *
 *  @param code The error code for the error.
 *  @param dict The userInfo dictionary for the error. userInfo may be nil.
 *
 *  @return An NSError object in the `ARKErrorDomain` with the specified error code and the dictionary of arbitrary data userInfo.
 */
+ (id)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict;

/**
 *  Creates an error with the default ARK error domain and the given parameters.
 *
 *  @param code The error code for the error.
 *  @param dict The userInfo dictionary for the error. userInfo may be nil.
 *
 *  @return An NSError object in the `ARKErrorDomain` with the specified error code and the dictionary of arbitrary data userInfo.
 */
- (id)initWithCode:(NSInteger)code userInfo:(NSDictionary *)dict;

@end

/**
 *  Arkio Error Domain
 */
extern NSString * const ARKErrorDomain;

/**
 *  Default message for unknown errors.
 */
extern NSString * const ARKAnUnknownErrorOccurredMessageKey;
