//
//  ARKSession.h
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

@class ARKUser;
@class ARKServer;

/**
 *  The `ARKSession` class provides methods for interacting with the Data.com API service on an `ARKServer` for an `ARKUser`.
 */
@interface ARKSession : NSObject

/**
 *  The Data.com user account  incl. authentication credentials to use for API requests to the server.
 */
@property (nonatomic, strong, readonly) ARKUser *user;

/**
 *  The Data.com server instance to which API requests will be sent.
 */
@property (nonatomic, strong, readonly) ARKServer *server;

/**
 *  The Data.com API Developer Token to send with each request.
 */
@property (nonatomic, strong) NSString *APIDeveloperToken;



#pragma mark - Designated Object Initializers
///------------------------------------------
/// @name Creating and Initializing a Session
///------------------------------------------

/**
 *  Creates an `ARKSession`, initialized with the given Data.com account username and password.
 *
 *  @param username The name of the Data.com account we want to access.
 *  @param password The password associated with the given account username.
 *  @return An `ARKSession` instance initialized with the given account credentials.
 */
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password;

/**
 *  Creates an `ARKSession`, initialized with the give `ARKUser`.
 *
 *  @param user An `ARKUser` instance.
 *  @return An `ARKSession` instance initialized with the given user account credentials.
 */
- (instancetype)initWithUser:(ARKUser *)user;

/**
 *  Creates an `ARKSession`, initialized with the values stored in `NSUserDefaults`.
 *
 *  Looks for the following keys in `NSUserDefaults`:
 *
 *  - arkio.account.username
 *  - arkio.account.password
 *
 *  @return An `ARKSession` instance initialized with the `NSUserDefaults` user account credentials.
 */
- (instancetype)initWithDefaultUser;
#warning implement initWithDefaultUser method
/**
 *  Creates an `ARKSession`, initialized with the given Data.com username and password
 *  and configured to connect to the given `ARKServer`.
 *
 *  @param username The name of the Data.com account we want to access.
 *  @param password The password associated with the given account username.
 *  @param server   An `ARKServer` to connect this `ARKSession` instance to.
 *
 *  @return An `ARKSession` instance initialized with the given account credentials and server.
 */
- (instancetype)initWithUsername:(NSString *)username
                        password:(NSString *)password
                          server:(ARKServer *)server;

/**
 *  Returns an `ARKSession`, initialized with the give `ARKUser` account credentials.
 *
 *  @param user An `ARKUser` instance.
 *  @param server  An `ARKServer` to connect this `ARKSession` instance to.
 *
 *  @return an `ARKSession` instance initialized with the given account credentials and server.
 */
- (instancetype)initWithUser:(ARKUser *)user
                      server:(ARKServer *)server;



@end
