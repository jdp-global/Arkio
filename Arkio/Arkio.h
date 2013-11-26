//
//  Arkio.h
//  Arkio
//
//  Created by Ray Scott on 22/11/2013.
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

#import <Foundation/Foundation.h>

// Networking
#import "ARKSession.h"
#import "ARKServer.h"

// Model
#import "ARKUser.h"
#import "ARKUserCredentials.h"
#import "ARKContact.h"

// Error Handling
#import "ARKErrors.h"
#import "ARKError.h"

/**
 *  A lite-weight representation of the service's entity types.
 */
typedef NS_ENUM(NSInteger, ARKEntityType) {
    
    /**
     *  A Data.com Contact entity.
     */
    ARKContactType,
    
    /**
     *  A Data.com Company entity.
     */
    ARKCompanyType
};

/**
 *  The various `ARKEntityType` properties.
 */
typedef NS_ENUM(NSInteger, ARKPropertyType) {
    
// Company Properties
    
    /**
     *  The unique identifier of a company.
     */
    ARKCompanyIdProperty,
    
    /**
     *  The name of a company.
     */
    ARKNameProperty,
    
    /**
     *  The phone number of a company.
     */
    ARKPhoneProperty,
    
    /**
     *  The URL of a company's website.
     */
    ARKWebsiteProperty,
    
    /**
     *  The stock symbol for a publically traded company.
     */
    ARKStockSymbolProperty,
    
    /**
     *  Indicates whether a public company's shares are traded on the stock exchange.
     */
    ARKStockExchangeProperty,
    
    /**
     *  The user ownership type of a company.
     */
    ARKOwnershipProperty,
    
    /**
     *  The Fortune 500 rank of a company.
     */
    ARKFortuneRankProperty,
    
    /**
     *  The number of people currently employed by a company.
     */
    ARKEmployeeCountProperty,
    
    /**
     *  The minimum and maximum range within which the employee count value falls.
     */
    ARKEmployeeRangeProperty,
    
    /**
     *  The annual revenue of a company.
     */
    ARKRevenueProperty,
    
    /**
     *  Primary Industry Code.
     */
    ARKIndustry1Property,
    
    /**
     *  Secondary Industry Code.
     */
    ARKIndustry2Property,
    
    /**
     *  Tertiary Industry Code.
     */
    ARKIndustry3Property,
    
    /**
     *  Primary Sub-Industry Code.
     */
    ARKSubIndustry1Property,
    
    /**
     *  Secondary Sub-Industry Code.
     */
    ARKSubIndustry2Property,
    
    /**
     *  Tertiary Sub-Industry Code.
     */
    ARKSubIndustry3Property,
    
    /**
     *  The Standard Industrial Classification System Code for a company.
     */
    ARKSicCodeProperty,
    
    /**
     *  Address Line 1.
     */
    ARKAddressProperty,
    
    /**
     * City name.
     */
    ARKCityProperty,
    
    /**
     *  State name.
     */
    ARKStateProperty,
    
    /**
     *  Zip/Postal Code.
     */
    ARKZipProperty,
    
    /**
     *  Country name.
     */
    ARKCountryProperty,
    
    /**
     *  The number of contacts for a company.
     */
    ARKActiveContactsProperty,
    
    /**
     *  A LinkedIn Profile URL.
     */
    ARKLinkInJigsawProperty,
    
    
// Contact Properties
    
    /**
     *  The unique identifier for a contact.
     */
    ARKContactIdProperty,
    
    /**
     *  The job title for a contact.
     */
    ARKTitleProperty,
    
    /**
     *  The name of a company.
     */
    ARKCompanyNameProperty,
    
    /**
     *  A record modification timestamp.
     */
    ARKUpdatedDateProperty,
    
    /**
     *  The graveyard status.
     */
    ARKGraveyardStatusProperty,
    
    /**
     *  The first name of a contact.
     */
    ARKFirstNameProperty,
    
    /**
     *  The last name of a contact.
     */
    ARKLastNameProperty,
    
    /**
     *  The URL for a contact on Data.com.
     */
    ARKContactUrlProperty,
    
    /**
     *  The area code associated with an address.
     */
    ARKAreaCodeProperty,
    
    /**
     *  An e-mail address.
     */
    ARKEmailProperty,
    
    /**
     *  The ownership indicator.
     */
    ARKOwnedProperty,
    
    /**
     *  The ownership type indicator.
     */
    ARKOwnedTypeProperty
};

/**
 *  The level within a company the contact has reached
 */
typedef NS_ENUM(NSInteger, ARKContactLevel) {
    
    /**
     *  Represents an aggregation of all contact levels.
     */
    ARKContactLevelAll,
    
    /**
     *  Vice-President level.
     */
    ARKContactLevelVP,
    
    /**
     *  Chief (Cxx) level.
     */
    ARKContactLevelC,
    
    /**
     *  Director level.
     */
    ARKContactLevelDirector,
    
    /**
     *  Manager level.
     */
    ARKContactLevelManager
};

/**
 *  The type of fact that can be challanged for a contact.
 */
typedef NS_ENUM(NSInteger, ARKFactType) {
    /**
     *  Email address.
     */
    ARKEmailFact,
    /**
     *  Phone number.
     */
    ARKPhoneNumberFact
};

/**
 *  Welcome to the Arkio library documentation.
 *
 *  Arkio is an Objective-C client library for the Data.com API service.
 */
@interface Arkio : NSObject

/**
 *  Converts an `ARKFactType` to a string representation.
 *
 *  @param type The `ARKFactType` to convert.
 *
 *  @return A string representing the `ARKFactType` given.
 */
+ (NSString *)stringForFactType:(ARKFactType)type;

@end
