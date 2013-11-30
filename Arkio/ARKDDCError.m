//
//  ARKDDCError.m
//  Arkio
//
//  Created by Ray Scott on 29/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKDDCError.h"

// Error Domain
NSString * const ARKDDCErrorDomain = @"com.alienhitcher.arkio.ddc.ErrorDomain";

@implementation ARKDDCError

#pragma mark - Designated Object Initializers

+ (id)errorWithCode:(NSInteger)code message:(NSString *)message
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
    return [NSError errorWithDomain:ARKDDCErrorDomain code:code userInfo:userInfo];
}

+ (id)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict
{
    return [NSError errorWithDomain:ARKDDCErrorDomain code:code userInfo:dict];
}

- (id)initWithCode:(NSInteger)code userInfo:(NSDictionary *)dict
{
    self = [self initWithDomain:ARKDDCErrorDomain code:code userInfo:dict];
    if (self) {
        
    }
    return self;
}

@end
