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

@implementation ARKCompany

- (instancetype)init {
	
    self = [super init];
	if (self) {
		
		self.companyId = [NSNumber numberWithInt:0];
		self.name = @"";
		self.phone = @"";
		self.website = [[NSURL alloc] init];
		self.stockSymbol = @"";
		self.stockExchange = @"";
		self.ownership = @"";
		self.fortuneRank = [NSNumber numberWithInt:0];
		self.employeeCount = [NSNumber numberWithInt:0];
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
		self.activeContacts = [NSNumber numberWithInt:0];
		self.linkInJigsaw = [[NSURL alloc] init];
		self.createdOn = nil;
		
	}
	return self;
}


- (NSString *)description {
	
#warning expand description
	NSMutableString *string = [NSMutableString stringWithCapacity:1];
	[string appendFormat:@"self.companyId = \'%i\'\n", [self.companyId intValue]];
	[string appendFormat:@"self.name = \'%@\'\n", self.name];
	[string appendFormat:@"self.phone = \'%@\'\n", self.phone];
	[string appendFormat:@"self.website = \'%@\'\n", self.website];
	[string appendFormat:@"self.stockSymbol = \'%@\'\n", self.stockSymbol];
	[string appendFormat:@"self.stockExchange = \'%@\'\n", self.stockExchange];
	[string appendFormat:@"self.ownership = \'%@\'\n", self.ownership];
	[string appendFormat:@"self.fortuneRank = \'%@\'\n", self.fortuneRank];
	[string appendFormat:@"self.employeeCount = \'%@\'\n", self.employeeCount];
	[string appendFormat:@"self.employeeRange = \'%@\'\n", self.employeeRange];
	[string appendFormat:@"self.revenue = \'%@\'\n", self.revenue];
		
	return (NSString *)string;
}

@end
