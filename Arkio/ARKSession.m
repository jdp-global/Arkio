//
//  ARKSession.m
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

#import "ARKSession.h"

#import "ARKServer.h"
#import "ARKUser.h"
#import "ARKUserCredentials.h"
#import "ARKURLFactory.h"

@interface ARKSession ()
@property (nonatomic, strong, readwrite) ARKUser *user;
@property (nonatomic, strong, readwrite) ARKServer *server;
@property (nonatomic, strong) ARKURLFactory *URLFactory;

@end

@implementation ARKSession

#pragma mark - Designated Object Initializers


- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password
{
    self = [self init];
    if (self) {
        ARKUserCredentials *credentials = [[ARKUserCredentials alloc] initWithUsername:username
                                                                              password:password];
        ARKUser *user = [[ARKUser alloc] initWithUserCredentials:credentials];
        self.user = user;
#warning may need to rename server as it seems to conflict with a mach mig_subsystem property
        self.server = [[ARKServer alloc] init];
    }
    return self;
}

- (instancetype)initWithUser:(ARKUser *)user
{
    self = [self init];
    if (self) {
        self.user = user;
#warning may need to rename server as it seems to conflict with a mach mig_subsystem property
        self.server = [[ARKServer alloc] init];
        
    }
    return self;
}

- (instancetype)initWithUsername:(NSString *)username
                        password:(NSString *)password
                          server:(ARKServer *)server
{
    self = [self init];
    if (self) {
        ARKUserCredentials *credentials = [[ARKUserCredentials alloc] initWithUsername:username
                                                                              password:password];
        ARKUser *user = [[ARKUser alloc] initWithUserCredentials:credentials];
        self.user = user;
#warning may need to rename server as it seems to conflict with a mach mig_subsystem property
        self.server = server;
    }
    return self;
}

- (instancetype)initWithUser:(ARKUser *)user
                      server:(ARKServer *)server

{
    self = [self init];
    if (self) {
        self.user = user;
        self.server = server;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
#warning todo: try to pull the API token from the Info.plist file arkio.api.developer.token
        self.URLFactory = [[ARKURLFactory alloc] initWithSession:self];
    }
    return self;
}


#warning add a description method


@end
