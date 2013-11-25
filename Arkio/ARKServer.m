//
//  ARKServer.m
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

#import "ARKServer.h"

#warning add the correct Data.com API endpoint URL
NSString *kArkApiDefaultEndpoint = @"https://api.data.com/v1/";

NSString *kArkApiUrlKey = @"arkio.api.url";
NSString *kArkApiHostKey = @"arkio.api.host";
NSString *kArkApiPathKey = @"arkio.api.path";


@interface ARKServer ()
@property (nonatomic, strong, readwrite) NSURL *host;
@property (nonatomic, strong, readwrite) NSString *path;
@property (nonatomic, strong, readwrite) NSURL *endpoint;

@end

@implementation ARKServer

#pragma mark - Designated Object Initializers

+ (instancetype)mainBundleServer;
{
    ARKServer *mainServer = [[ARKServer alloc] init];
    
    
    // host & path setting take precendence
    NSString *hostStr = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:kArkioApiHostKey];
    
    if (hostStr) {
        
        if ((mainServer.host = [NSURL URLWithString:hostStr])) {
            mainServer.path = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:kArkioApiPathKey];
            if (mainServer.path) {
                mainServer.endpoint = [mainServer.host URLByAppendingPathComponent:mainServer.path
                                                                       isDirectory:YES];
            }
            else {
                mainServer.endpoint = mainServer.host;
            }
            
            // we're done if we have synthesized a valid endpoint from host & path settings
            if (![NSURL URLWithString:[mainServer.endpoint absoluteString]]) { return mainServer; }
        }
    }
    
    // use arkio.api.url if host & path invalid
    
    NSString *urlStr = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:kArkioApiUrlKey];
    
    if (urlStr) {
        if ((mainServer.endpoint = [NSURL URLWithString:urlStr])) {
            // derive constituents
            mainServer.host = [NSURL URLWithString:[mainServer.endpoint host]];
            mainServer.path = [mainServer.endpoint path];
        }
    }
    else {
        // simply use the publically advertized API endpoint
        [mainServer setEndpoint:[NSURL URLWithString:kArkioApiDefaultEndpoint]];
    }
    
    return mainServer;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setEndpoint:[NSURL URLWithString:kArkioApiDefaultEndpoint]];
        [self setHost:[NSURL URLWithString:[self.endpoint host]]];
        [self setPath:[self.endpoint path]];
    }
    return self;
}


- (instancetype)initWithHost:(NSURL *)host path:(NSString *)path
{
    self = [self init];
    if (self) {
        self.host = host;
        self.path = path;
        self.endpoint = [self.host URLByAppendingPathComponent:self.path isDirectory:YES];
    }
    
    return self;
}


- (instancetype)initWithAPIEndpoint:(NSURL *)endpoint
{
    self = [self init];
    if (self) {
        self.endpoint = endpoint;
        self.host = [NSURL URLWithString:[endpoint host]];
        self.path = [endpoint path];
    }
    
    return self;
}
#warning add a description

@end
