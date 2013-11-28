//
//  NSURL+ARKNetworking.m
//  Arkio
//
//  Created by Ray Scott on 27/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "NSURL+ARKNetworking.h"

#import "NSString+ARKNetworking.h"

@implementation NSURL (ARKNetworking)

- (NSDictionary *)queryDictionary
{
    return [[self query] dictionaryFromQueryComponents];
}

@end
