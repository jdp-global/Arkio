//
//  ARKEntity.h
//  Arkio
//
//  Created by Ray Scott on 26/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import <Foundation/Foundation.h>

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