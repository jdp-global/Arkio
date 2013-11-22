//
//  ARKUserCredentials.m
//  Arkio
//
//  Created by Ray Scott on 22/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKUserCredentials.h"

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


@end
