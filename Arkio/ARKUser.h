//
//  ARKUser.h
//  Arkio
//
//  Created by Ray Scott on 22/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ARKUserCredentials.h"

/**
 *  The `ARKUser` class represents a single Data.com user's account.
 */
@interface ARKUser : NSObject

/**
 *  The authentication credentials for this user's account.
 */
@property (nonatomic, strong) ARKUserCredentials *credentials;

/**
 *  The number of Data.com points this user has accumulated.
 */
@property long points;


#pragma mark - Designated Object Initializers

/**
 *  Creates a new user object with the given `ARKUserCredentials`
 *
 *  @param credendials The `ARKUserCredentials` with which to initialize this new user object.
 *
 *  @return A new `ARKUser` object initialized with the given `ARKUserCredentials`.
 */
- (instancetype)initWithUserCredentials:(ARKUserCredentials *)credendials;


#pragma mark - Convenience Methods

/**
 *  Returns `YES` if the user has accumulated a number of Data.com points, otherwise this method returns `NO`.
 *
 *  @return A `BOOL` indicating whether the user has accumulated any Data.com points or not.
 */
- (BOOL)hasPoints;

@end
