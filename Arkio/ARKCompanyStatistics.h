//
//  ARKCompanyStatistics.h
//  Arkio
//
//  Created by Ray Scott on 28/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Contains statistics regarding employee counts broken down by department and level.
 */
@interface ARKCompanyStatistics : NSObject

/**
 *  The unquie identifier for the company.
 */
@property long companyID;

/**
 *  The URL of the web page to view these statistics.
 */
@property (nonatomic, strong) NSURL *url;

/**
 *  Total number of contacts for the company.
 */
@property long count;

/**
 *  Company statistics by department.
 */
@property (nonatomic, strong) NSSet *departments;

/**
 *  Company statistics by employee level.
 */
@property (nonatomic, strong) NSSet *levels;

#pragma mark - Creating and Initializing Company Statistics

///---------------------------------------------------
/// @name Creating and Initializing Company Statistics
///---------------------------------------------------

/**
 *  Creates and initializes a statistic collection for the given company ID.
 *
 *  @param companyID The unique identifier for the company.
 *
 *  @return An object encapsulating count statistics for a company.
 */
- (instancetype)initWithCompanyID:(long)companyID;

@end
