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
