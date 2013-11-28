//
//  ARKUserCredentials.h
//  Arkio
//
//  Created by Ray Scott on 22/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

/**
 *  The `ARKUserCredentials` class is used to encapsulate the authentication credentials for a Data.com user account.
 */
@interface ARKUserCredentials : NSObject

/**
 *  The user name associated with the Data.com account.
 */
@property (nonatomic, strong) NSString *username;

/**
 *  The password assigned to this user account. 
 */
@property (nonatomic, strong) NSString *password;

#pragma mark - Designated Object Initializers

///-------------------------------------------------
///  @name Creating and Intializing User Credentials
///-------------------------------------------------

/**
 *  Initializes a new user credentials instance with the given user name and password.
 *
 *  @param username The user name for the Data.com account.
 *  @param password The password for the Data.com account with this user name.
 *
 *  @return A newly initialized `ARKUserCredentials` object.
 */
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password;

/**
 *  Creates a user credential object and initializes the username and password values by retrieving them from the dictionary with the following keys:
 *
 *  - `"arkio.account.username"` - stored as plain text
 *  - `"arkio.account.password"` - stored as plain text
 *
 *  @param dictionary a dictionary containing username and password values mapped as described in the discussion.
 *
 *  @return an account instance initialized from values stored in the given dictionary
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 *  This method creates a user credentials object and initializes the username and password values by retrieving them from `NSUserDefaults` with the following keys:
 *
 *  - `"arkio.account.username"` - store the username as an `NSString` object
 *  - `"arkio.account.password"` - store the password as an unecrypted `NSString` object
 *
 *  @return A user credentials instance initialized with values from `NSUserDefaults`.
 */
+ (instancetype)defaultCredentials;

@end

extern NSString * const kARKAccountUsernameKey;
extern NSString * const kARKAccountPasswordKey;
