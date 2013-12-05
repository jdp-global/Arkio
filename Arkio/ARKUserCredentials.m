//
//  ARKUserCredentials.m
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

#import "ARKUserCredentials.h"

#import "NSObject+ARKFoundation.h"

NSString * const kARKAccountUsernameKey = @"arkio.account.username";
NSString * const kARKAccountPasswordKey = @"arkio.account.password";

@implementation ARKUserCredentials

#pragma mark - Designated Object Initializers

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password {

    self = [self init];
	if (self) {

		self.username = username;
		self.password = password;
	}
	return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self) {
        if (![dictionary objectForKey:kARKAccountUsernameKey] ||
            ![dictionary objectForKey:kARKAccountPasswordKey]) {
            return nil;
        }
        
        self.username = [dictionary objectForKey:kARKAccountUsernameKey];
        self.password = [dictionary objectForKey:kARKAccountPasswordKey];
    }
    
    return self;
}

+ (instancetype)defaultCredentials
{
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:kARKAccountUsernameKey];
    NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:kARKAccountPasswordKey];

    ARKUserCredentials *defaultCredentials = [[ARKUserCredentials alloc] initWithUsername:username
                                                                                 password:password];
    
    return defaultCredentials;
}

#pragma mark - NSObject Overrides
- (NSString *)description
{
    return [self autoDescription];
}

@end
