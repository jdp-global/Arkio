//
//  ARKCompany.h
//  Arkio
//
//  Created by Ray Scott on 24/11/2013.
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
 *  A Company entity in the Data.com service.
 */
@interface ARKCompany : NSObject

@property (nonatomic, strong) NSNumber *companyId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSURL *website;
@property (nonatomic, strong) NSString *stockSymbol;
@property (nonatomic, strong) NSString *stockExchange;
@property (nonatomic, strong) NSString *ownership;
@property (nonatomic, strong) NSNumber *fortuneRank;
@property (nonatomic, strong) NSNumber *employeeCount;
@property (nonatomic, strong) NSString *employeeRange;
@property (nonatomic, strong) NSString *revenue;
@property (nonatomic, strong) NSString *industry1;
@property (nonatomic, strong) NSString *industry2;
@property (nonatomic, strong) NSString *industry3;
@property (nonatomic, strong) NSString *subIndustry1;
@property (nonatomic, strong) NSString *subIndustry2;
@property (nonatomic, strong) NSString *subIndustry3;
@property (nonatomic, strong) NSString *sicCode;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSNumber *activeContacts;
@property (nonatomic, strong) NSURL *linkInJigsaw;
@property (nonatomic, strong) NSDate *createdOn;

@end
