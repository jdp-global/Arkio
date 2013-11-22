//
//  ARKUserCredentials.h
//  Arkio
//
//  Created by Ray Scott on 22/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARKUserCredentials : NSObject
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

#pragma mark - Designated Object Initializers

/**
 *  Initializes a new user credentials instance with the given user name and password.
 *
 *  @param username The user name for the Data.com account.
 *  @param password The password for the Data.com account with this user name.
 *
 *  @return A newly initialized `ARKUserCredentials` object.
 */
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password;

@end
