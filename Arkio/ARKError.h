//
//  ARKError.h
//  Arkio
//
//  Created by Ray Scott on 25/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

/* NSError codes in the ARKErrorDomain.
 */
enum {
    
    ARKUnknownError                     = -1,
    
    ARKJSONSerializationError           = 1,   // error has occurred in underlying JSON Serialization call
    ARKInvalidArgumentError             = 2,   // method contract wasn't upheld
    ARKValueNotFoundError               = 3,   // expected value is missing
    ARKValidationError                  = 4,   // invalid data encountered
    ARKNetworkNotReachableError         = 5,   // no network connection. can't connect to network via wifi or GPRS/EDGE etc.
    ARKMalformedURLError                = 6,   // for ARKURLFactory errors
    
    
    // HTTP Error Codes
    // 400s
    ARKHTTPBadRequestError              = 400,  // bad request E.G missing or incorrect parameter
    ARKHTTPForbiddenError               = 403,  // typical failure, E.G. authentication failure, or incorrect developer token
    ARKHTTPNotFoundError                = 404,  // attempt to access non-existent data, E.G. contact not found for ID
    ARKHTTPMethodNotAllowedError        = 405,  // E.G. on contact not owned.
    
    // 500s
    ARKHTTPInternalServerError          = 500,  // typically caused by a system or search error
    ARKHTTPNotSupportedError            = 501,  // attempted to acceess an unimplemented feature
    ARKHTTPServiceAvailableError        = 503   // the service is unavailable
};

/**
 *  Represents an error in the Arkio library
 */
@interface ARKError : NSError

#pragma mark - Designated Object Initializers


+ (instancetype)errorWithCode:(NSString *)code
               httpStatusCode:(NSInteger)httpStatusCode
                      message:(NSString *)message
                   stackTrace:(NSString *)stackTrace;

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

// Additional userInfo dictionary keys
extern NSString * const ARKErrorAPIErrorCodeKey;
extern NSString * const ARKErrorAPIStackTraceKey;

// DDC Error Codes
extern NSString * const ARKDDCParameterErrorCode;
extern NSString * const ARKDDCLoginFailureErrorCode;
extern NSString * const ARKDDCTokenFailureErrorCode;
extern NSString * const ARKDDCPurchaseLowPointsErrorCode;
extern NSString * const ARKDDCContactNotFoundErrorCode;
extern NSString * const ARKDDCContactNotOwnedErrorCode;
extern NSString * const ARKDDCSearchErrorCode;
extern NSString * const ARKDDCSystemErrorCode;
extern NSString * const ARKDDCNotImplementedErrorCode;
extern NSString * const ARKDDCNotAvailableErrorCode;
