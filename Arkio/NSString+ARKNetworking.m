//
//  NSString+ARKNetworking.m
//  Arkio
//
//  Created by Ray Scott on 27/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "NSString+ARKNetworking.h"

@implementation NSString (ARKNetworking)

- (NSString *)stringByDecodingURLFormat
{
    NSString *result = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return result;
}

- (NSDictionary *)dictionaryFromQueryComponents
{
    NSMutableDictionary *queryComponents = [NSMutableDictionary dictionary];

    for(NSString *keyValuePairString in [self componentsSeparatedByString:@"&"]) {
        
        NSArray *keyValuePairArray = [keyValuePairString componentsSeparatedByString:@"="];
        
        // verify that there is at least one key, and at least one value.  Ignore extra = signs
        if ([keyValuePairArray count] < 2) continue;
        
        NSString *key = [[keyValuePairArray objectAtIndex:0] stringByDecodingURLFormat];
        NSString *value = [[keyValuePairArray objectAtIndex:1] stringByDecodingURLFormat];
        [queryComponents setObject:value forKey:key];
    }
    
    return queryComponents;
}

@end
