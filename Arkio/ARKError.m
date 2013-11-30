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

@implementation ARKError

#pragma mark - Designated Object Initializers

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
