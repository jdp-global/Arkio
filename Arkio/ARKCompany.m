//
//  ARKCompany.m
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

#import "ARKCompany.h"

#import "NSObject+ARKFoundation.h"

@implementation ARKCompany

- (instancetype)init {
	
    self = [super init];
	if (self) {
		
		self.companyID = 0;
		self.name = @"";
		self.phone = @"";
		self.website = [[NSURL alloc] init];
		self.stockSymbol = @"";
		self.stockExchange = @"";
		self.ownership = @"";
		self.fortuneRank = 0;
		self.employeeCount = 0;
		self.employeeRange = @"";
		self.revenue = @"";
		self.industry1 = @"";
		self.industry2 = @"";
		self.industry3 = @"";
		self.subIndustry1 = @"";
		self.subIndustry2 = @"";
		self.subIndustry3 = @"";
		self.sicCode = @"";
		self.address = @"";
		self.city = @"";
		self.state = @"";
		self.zip = @"";
		self.country = @"";
		self.activeContacts = 0;
		self.linkInJigsaw = [[NSURL alloc] init];
		self.createdOn = nil;
		
	}
	return self;
}

#pragma mark - NSObject Overrides

- (NSString *)description {

    return [self autoDescription];
}

@end
