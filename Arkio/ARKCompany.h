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

#import "ARKEntity.h"

/**
 *  A Company entity in the Data.com service.
 */
@interface ARKCompany : ARKEntity

/**
 *  The unique identifier of a company in Data.com.
 */
@property long companyID;

/**
 *  The name of a company.
 */
@property (nonatomic, strong) NSString *name;

/**
 *  The land-line phone number of a company.
 */
@property (nonatomic, strong) NSString *phone;

/**
 *  The URL of a company's website.
 */
@property (nonatomic, strong) NSURL *website;

/**
 *  The stock symbol for a publically traded company.
 */
@property (nonatomic, strong) NSString *stockSymbol;

/**
 *  Indicates whether a public company's shares are traded on the stock exchange.
 */
@property (nonatomic, strong) NSString *stockExchange;

/**
 *  The user ownership type of a company.
 */
@property (nonatomic, strong) NSString *ownership;

/**
 *  The Fortune 500 rank of a company.
 */
@property (nonatomic, strong) NSNumber *fortuneRank;

/**
 *  The number of people currently employed by a company.
 */
@property (nonatomic, strong) NSNumber *employeeCount;

/**
 *  The minimum and maximum range within which the employee count value falls.
 */
@property (nonatomic, strong) NSString *employeeRange;

/**
 *  The annual revenue of a company.
 */
@property (nonatomic, strong) NSString *revenue;

/**
 *  Primary Industry Code.
 */
@property (nonatomic, strong) NSString *industry1;

/**
 *  Secondary Industry Code.
 */
@property (nonatomic, strong) NSString *industry2;

/**
 *  Tertiary Industry Code.
 */
@property (nonatomic, strong) NSString *industry3;

/**
 *  Primary Sub-Industry Code.
 */
@property (nonatomic, strong) NSString *subIndustry1;

/**
 *  Secondary Sub-Industry Code.
 */
@property (nonatomic, strong) NSString *subIndustry2;

/**
 *  Tertiary Sub-Industry Code.
 */
@property (nonatomic, strong) NSString *subIndustry3;

/**
 *  The Standard Industrial Classification System Code for a company.
 */
@property (nonatomic, strong) NSString *sicCode;

/**
 *  Address Line 1.
 */
@property (nonatomic, strong) NSString *address;

/**
 *  City name.
 */
@property (nonatomic, strong) NSString *city;

/**
 *  State name.
 */
@property (nonatomic, strong) NSString *state;

/**
 *  Zip/Postal Code.
 */
@property (nonatomic, strong) NSString *zip;

/**
 *  Country name.
 */
@property (nonatomic, strong) NSString *country;

/**
 *  The number of contacts for a company.
 */
@property (nonatomic, strong) NSNumber *activeContacts;

/**
 *  A LinkedIn Profile URL.
 */
@property (nonatomic, strong) NSURL *linkInJigsaw;

/**
 *  Creation date.
 */
@property (nonatomic, strong) NSDate *createdOn;

@end
