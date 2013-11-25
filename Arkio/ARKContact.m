//
//  ARKContact.m
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

#import "ARKContact.h"

@implementation ARKContact


#pragma mark - Designated Object Initializers

- (instancetype)init {
	
    self = [super init];
	if (self){

		self.contactId = [NSNumber numberWithInt:0];
		self.companyId = [NSNumber numberWithInt:0];
		self.title = @"";
		self.companyName = @"";
		self.updatedDate = nil;
		self.graveyardStatus = NO;
		self.firstName = @"";
		self.lastName = @"";
		self.address = @"";
		self.city = @"";
		self.state = @"";
		self.country = @"";
		self.zip = @"";
		self.contactUrl = [[NSURL alloc] init];
		self.areaCode = @"";
		self.phone = @"";
		self.email = @"";
		self.owned = NO;
		self.ownedType = @"";
		
	}
	return self;
}

#warning add a description method
@end
