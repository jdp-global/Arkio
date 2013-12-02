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

#import "Arkio.h"


#import "ARKSession.h"

#import "ARKServer.h"
#import "ARKUser.h"
#import "ARKUserCredentials.h"
#import "ARKURLFactory.h"
#import "ARKSerialization.h"
#import "NSURL+ARKNetworking.h"
#import "ARKCompanySearchResult.h"
#import "ARKCompanyStatistics.h"
#import "ARKContactSearchResult.h"


#import "AFNetworking.h"

NSString * const kARKAPIDeveloperTokenKey = @"arkio.api.developer.token";

@interface ARKSession ()
@property (nonatomic, strong, readwrite) ARKUser *user;
@property (nonatomic, strong, readwrite) ARKPartner *partner;
@property (readwrite) ARKSessionMode mode;
@property (nonatomic, strong, readwrite) ARKServer *server;
@property (nonatomic, strong) ARKURLFactory *URLFactory;
@property (nonatomic, strong) ARKSerialization *serializer;
@property (nonatomic, strong) AFHTTPSessionManager *http;

- (void)initialize;

// tests and responds to the AFNetworkReachabilityStatusNotReachable condition.
- (BOOL)respondedToNetworkFailure:(void (^)(NSError *error))failure;

@end

@implementation ARKSession

// this init method should never be called directly by client code.
- (id)init
{
    self = [super init];
    if (self) {
        
        self.URLFactory = [[ARKURLFactory alloc] initWithSession:self];
        
        //  pull the API token from the Info.plist file
        NSDictionary *infoDict = [[NSBundle bundleForClass:[self class]] infoDictionary];
        if ([infoDict objectForKey:kARKAPIDeveloperTokenKey]) {
            self.APIDeveloperToken = [infoDict objectForKey:kARKAPIDeveloperTokenKey];
        }
    }
    return self;
}

#pragma mark - Designated Object Initializers
#pragma mark - Creating and Initializing a User Session

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password
{
    self = [self init];
    if (self) {
        ARKUserCredentials *credentials = [[ARKUserCredentials alloc] initWithUsername:username
                                                                              password:password];
        ARKUser *user = [[ARKUser alloc] initWithUserCredentials:credentials];
        self.user = user;
        self.server = [[ARKServer alloc] init];
        self.mode = ARKSessionUserMode;
        [self initialize];
    }
    return self;
}

- (instancetype)initWithUser:(ARKUser *)user
{
    self = [self init];
    if (self) {
        self.user = user;
        self.server = [[ARKServer alloc] init];
        self.mode = ARKSessionUserMode;
        [self initialize];
        
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
        self.server = server;
        self.mode = ARKSessionUserMode;
        [self initialize];
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
        self.mode = ARKSessionUserMode;
        [self initialize];
    }
    return self;
}


#pragma mark - Creating and Initializing a Partner Session

- (instancetype)initWithPartner:(ARKPartner *)partner
{
    self = [self init];
    if (self) {
        self.partner = partner;
        self.server = [[ARKServer alloc] init];
        self.mode = ARKSessionPartnerMode;
        [self initialize];
    }
    return self;
}

- (instancetype)initWithPartner:(ARKPartner *)partner
                         server:(ARKServer *)server

{
    self = [self init];
    if (self) {
        self.partner = partner;
        self.server = server;
        self.mode = ARKSessionPartnerMode;        
        [self initialize];        
    }
    return self;
}

#pragma mark - User / Authentication

- (void)authenticate:(void (^)(BOOL authenticated, ARKError *error))success
             failure:(void (^)(NSError *error))failure
{
    if ([self respondedToNetworkFailure:failure]) return;
    
    NSURL *url = [self.URLFactory userAuthURL];

    [self.http GET:[url path]
        parameters:[url queryDictionary]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               
               ARKError *arkError = nil;
               NSInteger points = [self.serializer pointBalanceWithDictionary:(NSDictionary *)responseObject error:&arkError];
               
               success((points > 0)? YES : NO, arkError);
           }
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               
               // mark an HTTP response code of 403 as a authentication failure
               NSRange range = [[error localizedDescription] rangeOfString:@"(403)"];
               if (range.location != NSNotFound) {
                   ARKError *arkError = [ARKError errorWithCode:ARKValidationError message:NSLocalizedString(@"Invalid username or password.", nil)];
                   success(NO, arkError);
               }
               else {
                   // HTTP request failed for some other reason
                   failure(error);
               }
           }
     ];
}


- (void)userInformation:(void (^)(long points, ARKError *error))success
                failure:(void (^)(NSError *error))failure
{
    if ([self respondedToNetworkFailure:failure]) return;

    NSURL *url = [self.URLFactory userInfoURL];
    
    [self.http GET:[url path]
        parameters:[url queryDictionary]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               
               ARKError *arkError = nil;
               NSInteger points = [self.serializer pointBalanceWithDictionary:(NSDictionary *)responseObject
                                                                        error:&arkError];
               
               success(points, arkError);
           }
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               
               // HTTP request failed for some other reason
               failure(error);
           }
     ];
}

#pragma mark - Partner Information Requests

- (void)partnerInformation:(void (^)(long points, ARKError *error))success
                   failure:(void (^)(NSError *error))failure
{
    if ([self respondedToNetworkFailure:failure]) return;
    
    NSURL *url = [self.URLFactory partnerInfoURL];
    
    [self.http GET:[url path]
        parameters:[url queryDictionary]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               NSLog(@"%@", responseObject);
           }
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               failure(error);
           }
     ];
}


#pragma mark - Contact Requests

- (void)searchContactsWithString:(NSString *)string
                          offset:(int)offset
                            size:(int)size
                         success:(void (^)(ARKContactSearchResult *result, ARKError *error))success
                         failure:(void (^)(NSError *error))failure
{
    if ([self respondedToNetworkFailure:failure]) return;
    
    NSURL *url = [self.URLFactory contactSearchURLWithString:string
                                                      offset:offset
                                                        size:size];
    [self.http GET:[url path]
        parameters:[url queryDictionary]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               ARKError *arkError = nil;
               ARKContactSearchResult *result = [self.serializer contactSearchResultWithDictionary:(NSDictionary *)responseObject
                                                                                             error:&arkError];
               success(result, arkError);
           }
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               failure(error);
           }
     ];
}

- (void)searchContactsWithCompanyName:(NSString *)companyName
                            firstLast:(NSString *)firstLast
                                level:(ARKContactLevel)level
                               offset:(int)offset
                                 size:(int)size
                              success:(void (^)(ARKContactSearchResult *result, ARKError *error))success
                              failure:(void (^)(NSError *error))failure
{
    if ([self respondedToNetworkFailure:failure]) return;
    
    NSURL *url = [self.URLFactory contactSearchURLWithCompanyName:companyName
                                                        firstLast:firstLast
                                                            level:level
                                                           offset:offset
                                                             size:size];
    
    [self.http GET:[url path]
        parameters:[url queryDictionary]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               ARKError *arkError = nil;
               ARKContactSearchResult *result = [self.serializer contactSearchResultWithDictionary:(NSDictionary *)responseObject
                                                                                             error:&arkError];
               success(result, arkError);
           }
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               failure(error);
           }
     ];
}


#pragma mark - Company Requests

- (void)statisticsForCompanyID:(long)companyID
                       success:(void (^)(ARKCompanyStatistics *stats, ARKError *error))success
                       failure:(void (^)(NSError *error))failure
{
    if ([self respondedToNetworkFailure:failure]) return;
    
    NSURL *url = [self.URLFactory companyStatisticsURLWithID:companyID];
    
    [self.http GET:[url path]
        parameters:[url queryDictionary]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               
               ARKError *arkError = nil;
               ARKCompanyStatistics *stats = [self.serializer companyStatisticsWithDictionary:(NSDictionary *)responseObject
                                                                                        error:&arkError];
               success(stats, arkError);
           }
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               failure(error);
           }
     ];
}

- (void)searchCompaniesWithString:(NSString *)string
                           offset:(int)offset
                             size:(int)size
                         detailed:(BOOL)detailed
                          success:(void (^)(ARKCompanySearchResult *results, ARKError *error))success
                          failure:(void (^)(NSError *error))failure
{
    if ([self respondedToNetworkFailure:failure]) return;
    
    NSURL *url = [self.URLFactory companySearchURLWithString:string
                                                      offset:offset
                                                        size:size
                                                    detailed:detailed];
    [self.http GET:[url path]
        parameters:[url queryDictionary]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               ARKError *arkError = nil;
               ARKCompanySearchResult *results = [self.serializer companySearchResultWithDictionary:(NSDictionary *)responseObject
                                                                                              error:&arkError];
               success(results, arkError);
           }
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               failure(error);
           }
     ];
    
}


#warning add a description method
#pragma mark - Class Extentions
- (void)initialize
{
    self.http = [[AFHTTPSessionManager alloc] initWithBaseURL:self.server.endpoint];
    [self.http.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        
    }];
    [self.http.reachabilityManager startMonitoring];
    self.serializer = [[ARKSerialization alloc] init];
}

- (BOOL)respondedToNetworkFailure:(void (^)(NSError *error))failure
{
    BOOL responded = NO;
    
    if ([[self.http reachabilityManager] networkReachabilityStatus] == AFNetworkReachabilityStatusNotReachable) {
        ARKError *error = [ARKError errorWithCode:ARKNetworkNotReachableError message:@"No network connection."];
        failure(error);
        responded = YES;
    }
    
    return responded;
}

@end
