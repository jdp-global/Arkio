//
//  ARKEntity.h
//  Arkio
//
//  Created by Ray Scott on 26/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 *  Model Entity 
 */
@interface ARKEntity : NSObject

@end

// common keys
extern NSString * const kARKAddressKey;
extern NSString * const kARKCityKey;
extern NSString * const kARKStateKey;
extern NSString * const kARKCountryKey;
extern NSString * const kARKZipKey;
extern NSString * const kARKPhoneKey;
extern NSString * const kARKUpdatedDateKey;

// contact keys
extern NSString * const kARKContactIDKey;
extern NSString * const kARKTitleKey;
extern NSString * const kARKCompanyNameKey;
extern NSString * const kARKFirstNameKey;
extern NSString * const kARKLastNameKey;
extern NSString * const kARKContactURLKey;
extern NSString * const kARKAreaCodeKey;
extern NSString * const kARKEmailKey;
extern NSString * const kARKOwnedKey;
extern NSString * const kARKOwnedTypeKey;

// company keys
extern NSString * const kARKCompanyIDKey;
extern NSString * const kARKNameKey;
extern NSString * const kARKWebsiteKey;
extern NSString * const kARKStockSymbolKey;
extern NSString * const kARKStockExchangeKey;
extern NSString * const kARKOwnershipKey;
extern NSString * const kARKFortuneRankKey;
extern NSString * const kARKEmployeeCountKey;
extern NSString * const kARKEmployeeRangeKey;
extern NSString * const kARKRevenueRangeKey;
extern NSString * const kARKIndustry1Key;
extern NSString * const kARKIndustry2Key;
extern NSString * const kARKIndustry3Key;
extern NSString * const kARKSubIndustry1Key;
extern NSString * const kARKSubIndustry2Key;
extern NSString * const kARKSubIndustry3Key;
extern NSString * const kARKSICCodeKey;
extern NSString * const kARKActiveContactsKey;
extern NSString * const kARKLinkInJigsawKey;
extern NSString * const kARKPointsKey;
extern NSString * const kARKPointBalanceKey;