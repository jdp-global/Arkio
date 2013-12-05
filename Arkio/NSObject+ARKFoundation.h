//
//  NSObject+ARKFoundation.h
//  Arkio
//
//  Created by Ray Scott on 05/12/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ARKFoundation)

/**
 *  Generates a property name-value list.
 *
 *  @return a string containing a description of the objects properties and values.
 */
- (NSString *) autoDescription;

/**
 *  Generates a property name-value list for the instance of the given class type.
 *
 *  @param classType The type of class we want a description of.
 *
 *  @return a string containing a description of the objects properties and values.
 */
- (NSString *) autoDescriptionForClassType:(Class)classType;

@end
