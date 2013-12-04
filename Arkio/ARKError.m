//
//  ARKError.m
//  Arkio
//
//  Created by Ray Scott on 25/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKError.h"

// Error Domain
NSString * const ARKErrorDomain = @"com.alienhitcher.arkio.ErrorDomain";

// Error Message Keys (for localization)
NSString * const ARKAnUnknownErrorOccurredMessageKey = @"An unknown error occurred.";

// Additional userInfo dictionary keys
NSString * const ARKErrorAPIErrorCodeKey = @"ARKErrorAPIErrorCodeKey";
NSString * const ARKErrorAPIStackTraceKey = @"ARKErrorAPIStackTraceKey";

// DDC Error Codes
NSString * const ARKDDCParameterErrorCode = @"PARAM_ERROR";
NSString * const ARKDDCLoginFailureErrorCode = @"LOGIN_FAIL";
NSString * const ARKDDCTokenFailureErrorCode = @"TOKEN_FAIL";
NSString * const ARKDDCPurchaseLowPointsErrorCode = @"PURCHASE_LOW_POINTS";
NSString * const ARKDDCContactNotFoundErrorCode = @"CONTACT_NOT_EXIS";
NSString * const ARKDDCContactNotOwnedErrorCode = @"CONTACT_NOT_OWNED";
NSString * const ARKDDCSearchErrorCode = @"SEARCH_ERROR";
NSString * const ARKDDCSystemErrorCode = @"SYS_ERROR";
NSString * const ARKDDCNotImplementedErrorCode = @"NOT_IMPLEMENTED";
NSString * const ARKDDCNotAvailableErrorCode = @"NOT_AVAILABLE";


@implementation ARKError

#pragma mark - Designated Object Initializers

+ (instancetype)errorWithCode:(NSString *)code
               httpStatusCode:(NSInteger)httpStatusCode
                      message:(NSString *)message
                   stackTrace:(NSString *)stackTrace
{
    if (!message) {
        message = ARKAnUnknownErrorOccurredMessageKey;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[ARKErrorAPIErrorCodeKey] = code;
    userInfo[NSLocalizedDescriptionKey] = message;
    userInfo[ARKErrorAPIStackTraceKey] = stackTrace;
    
    return [[ARKError alloc] initWithCode:httpStatusCode userInfo:userInfo];
}

+ (id)errorWithCode:(NSInteger)code message:(NSString *)message
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
    return [NSError errorWithDomain:ARKErrorDomain code:code userInfo:userInfo];
}

+ (id)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict
{
    return [NSError errorWithDomain:ARKErrorDomain code:code userInfo:dict];
}

- (id)initWithCode:(NSInteger)code userInfo:(NSDictionary *)dict
{
    self = [self initWithDomain:ARKErrorDomain code:code userInfo:dict];
    if (self) {
        
    }
    return self;
}

@end
