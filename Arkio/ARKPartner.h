//
//  ARKPartner.h
//  Arkio
//
//  Created by Ray Scott on 02/12/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKEntity.h"

/**
 *  The `ARKPartner` class represents a single partner organization.
 */
@interface ARKPartner : ARKEntity


/**
 *  The Data.com API Developer Token to send with each partner request.
 */
@property (nonatomic, strong) NSString *APIDeveloperToken;

/**
 *  The number of Data.com points this partner has accumulated.
 */
@property long points;

#pragma mark - Designated Object Initializers

///-----------------------------------------
///  @name Creating and Intializing Partners
///-----------------------------------------

- initWithAPIDeveloperToken:(NSString *)token;

@end
