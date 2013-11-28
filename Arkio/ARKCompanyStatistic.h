//
//  ARKCompanyStatistic.h
//  Arkio
//
//  Created by Ray Scott on 28/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Represents a type of statistical grouping of company data.
 */
typedef NS_ENUM(NSInteger, ARKStatisticGroupType)
{
    /**
     *  A company department.
     */
    ARKStatisticGroupDepartment,
    
    /**
     *  An employee level.
     */
    ARKStatisticGroupLevel
};

/**
 *  Typically represents an aggregate value of a statistical grouping.
 */
@interface ARKCompanyStatistic : NSObject

/**
 * The group type of this statistic.
 */
@property ARKStatisticGroupType group;

/**
 *  The name associated with this statistic.
 */
@property (nonatomic, strong) NSString *name;

/**
 *  The aggregate value of this statistic.
 */
@property long count;

/**
 *  The URL for the web page where this data is viewable.
 */
@property (nonatomic, strong) NSURL *url;

#pragma mark - Creating and Initializing a Company Statistic

///----------------------------------------------------
/// @name Creating and Initializing a Company Statistic
///----------------------------------------------------

/**
 *  Creates and initializes a statistic object for the given group type.
 *
 *  @param type The type of statistical grouping.
 *
 *  @return A statistical group object.
 */
- (instancetype)initWithGroupType:(ARKStatisticGroupType)type;

@end
