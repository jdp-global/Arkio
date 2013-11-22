//
//  ARKServer.m
//  Arkio
//
//  Created by Ray Scott on 22/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

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

@end
