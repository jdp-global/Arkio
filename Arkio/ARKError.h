//
//  ARKError.h
//  Arkio
//
//  Created by Ray Scott on 25/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSError codes in the ARKErrorDomain.
 *
 *  @param NSInteger    <#NSInteger description#>
 *  @param ARKErrorCode <#ARKErrorCode description#>
 *
 *  @return <#return value description#>
 */
typedef NS_ENUM(NSInteger, ARKErrorCode) {
    
    /// Unknown error.
    ARKUnknownError                     = -1,
    
    /// error has occurred in underlying JSON Serialization call
    ARKJSONSerializationError           = 1,
    /// method contract wasn't upheld
    ARKInvalidArgumentError             = 2,
    /// expected value is missing
    ARKValueNotFoundError               = 3,
    /// invalid data encountered
    ARKValidationError                  = 4,
    /// no network connection. can't connect to network via wifi or GPRS/EDGE etc.
    ARKNetworkNotReachableError         = 5,
    /// ARKURLFactory errors
    ARKMalformedURLError                = 6,
    
    
    
    // HTTP Error Codes
    // 400s
    /// bad request E.G missing or incorrect parameter
    ARKHTTPBadRequestError              = 400,
    /// typical failure, E.G. authentication failure, or incorrect developer token
    ARKHTTPForbiddenError               = 403,
    /// attempt to access non-existent data, E.G. contact not found for ID
    ARKHTTPNotFoundError                = 404,
    /// E.G. on contact not owned.
    ARKHTTPMethodNotAllowedError        = 405,
    
    // 500s
    /// typically caused by a system or search error
    ARKHTTPInternalServerError          = 500,
    /// attempted to acceess an unimplemented feature
    ARKHTTPNotSupportedError            = 501,
    /// the service is unavailable
    ARKHTTPServiceAvailableError        = 503
};

/**
 *  Represents an error in the Arkio library
 */
@interface ARKError : NSError

#pragma mark - Designated Object Initializers

/**
 *  Creates an error in the ARKErrorDomain witht the given parameters.
 *
 *  @param code           The Data.com API error code string.
 *  @param httpStatusCode The status code returned with the HTTP response.
 *  @param message        The Data.com API error message.
 *  @param stackTrace     The stack trace data returned by the Data.com API.
 *
 *  @return An `ARKError` in the `ARKErrorDomain` with the specified parameters. 
 */
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
