//
//  ARKUser.h
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
