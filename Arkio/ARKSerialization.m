//
//  ARKSerialization.m
//  Arkio
//
//  Created by Ray Scott on 25/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

#import "ARKSerialization.h"

#import "ARKEntity.h"
#import "ARKContact.h"
#import "ARKCompany.h"
#import "ARKError.h"
#import "ARKErrors.h"


static NSString *ARKDefaultAPIErrorCodeKey = @"errorCode";
static NSString *ARKDefaultAPIErrorMessageKey = @"errorMsg";
static NSString *ARKContactsAPIKey = @"contacts";
static NSString *ARKCompaniesAPIKey = @"companies";

static NSDateFormatter *ARKAPIDateFormatter;

@interface ARKSerialization ()

- (ARKContact *)contactWithDictionary:(NSDictionary *)dict;
- (ARKCompany *)companyWithDictionary:(NSDictionary *)dict;

@end

@implementation ARKSerialization

#pragma mark - Class Initialization
+ (void)initialize
{
    ARKAPIDateFormatter = [[NSDateFormatter alloc] init];
    [ARKAPIDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
}

#pragma mark - User Account

- (NSInteger)pointBalanceWithData:(NSData *)data error:(NSError **)error
{
    if (data == nil) return 0;
    
    id obj = [NSJSONSerialization JSONObjectWithData:data
                                             options:0
                                               error:(NSError *__autoreleasing *)&error];
    // return on error
    if (obj == nil) return ARKUnknownError;

    NSDictionary *dict = nil;
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        dict = obj;
    }
    else {
        dict = [obj objectAtIndex:0];
    }

    NSNumber *points = [dict objectForKey:kARKPointsKey];
    
	return [points longValue];
}

#pragma mark - Contact Serialization

- (NSArray *)contactsWithData:(NSData *)data error:(NSError **)error
{
    if (data == nil) return nil;
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:(NSError *__autoreleasing *)&error];
    // return on error
    if (dict == nil) return nil;

	NSArray *contactDicts = [dict objectForKey:ARKContactsAPIKey];
	NSMutableArray *contacts = [[NSMutableArray alloc] initWithCapacity:1];
	
	for (NSDictionary *dict in contactDicts) {
		
		ARKContact *contact = [self contactWithDictionary:dict];
		[contacts addObject:contact];
        contact = nil;
	}

	return contacts;
}


#pragma mark - Company Serialization

- (NSArray *)companiesWithData:(NSData *)data error:(NSError **)error
{
    if (data == nil) return nil;

    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:(NSError *__autoreleasing *)&error];
    // return on error
    if (dict == nil) return nil;

	NSArray *companyDicts = [dict objectForKey:ARKCompaniesAPIKey];
    NSMutableArray *companies = [[NSMutableArray alloc] initWithCapacity:1];
	
	for (NSDictionary *dict in companyDicts) {
		
		ARKCompany *company = [self companyWithDictionary:dict];
		[companies addObject:company];
		company = nil;
	}
    
	return companies;
}

#pragma mark - Error Handling

- (NSInteger)errorCodeWithData:(NSData *)data error:(NSError **)error
{
    if (data == nil) return 0;
    
    NSInteger code = ARKUnknownError;
    
    id obj = [NSJSONSerialization JSONObjectWithData:data
                                             options:0
                                               error:(NSError *__autoreleasing *)&error];
    // return on error
    if (obj == nil) return ARKUnknownError;
    
    NSDictionary *dict = nil;
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        dict = obj;
    }
    else {
        dict = [obj objectAtIndex:0];
    }
    
    NSString *codeString = (NSString *)[dict objectForKey:ARKDefaultAPIErrorCodeKey];

    if (codeString) {
        code = [codeString intValue];
    }
    
    return code;
}

- (NSError *)errorWithData:(NSData *)data key:(NSString *)key error:(NSError **)error;
{
    if (key == nil || data == nil) return nil;

    id obj = [NSJSONSerialization JSONObjectWithData:data
                                             options:0
                                               error:(NSError *__autoreleasing *)&error];
    // return on error
    if (obj == nil) return nil;

    NSDictionary *dict = nil;
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        dict = obj;
    }
    else {
        dict = [obj objectAtIndex:0];
    }

    // pull out the error code
    NSInteger code = ARKUnknownError;
    NSString *codeString = (NSString *)[dict objectForKey:ARKDefaultAPIErrorCodeKey];
    
    if (codeString) {
        code = [codeString intValue];
    }
    
    // pull out the error message
    NSString *message = [dict objectForKey:key];
    
    if (!message) {
        message = ARKAnUnknownErrorOccurredMessageKey;
    }
    
    ARKError *arkError = [ARKError errorWithCode:code message:message];
    
    
    return arkError;
}

- (NSError *)errorWithData:(NSData *)data error:(NSError **)error
{
    return [self errorWithData:data key:ARKDefaultAPIErrorMessageKey error:(NSError *__autoreleasing *)&error];
}


#pragma mark - Class Extentions
- (ARKContact *)contactWithDictionary:(NSDictionary *)dict
{
    ARKContact *contact  = [[ARKContact alloc] init];
	[contact setContactId:[NSNumber numberWithInt:[[dict objectForKey:kARKContactIDKey] intValue]]];
	[contact setCompanyId:[NSNumber numberWithInt:[[dict objectForKey:kARKCompanyIDKey]intValue]]];
	[contact setTitle:[dict objectForKey:kARKTitleKey]];
	[contact setCompanyName:[dict objectForKey:kARKCompanyNameKey]];
	
	NSString *dateString = [dict objectForKey:kARKUpdatedDateKey];
	NSDate *updatedDate = [ARKAPIDateFormatter dateFromString:dateString];
	[contact setUpdatedDate:updatedDate];
	
	[contact setFirstName:[dict objectForKey:kARKFirstNameKey]];
	[contact setLastName:[dict objectForKey:kARKLastNameKey]];
	[contact setAddress:[dict objectForKey:kARKAddressKey]];
	[contact setCity:[dict objectForKey:kARKCityKey]];
	[contact setState:[dict objectForKey:kARKStateKey]];
	[contact setCountry:[dict objectForKey:kARKCountryKey]];
	[contact setZip:[dict objectForKey:kARKZipKey]];
	[contact setContactUrl:[NSURL URLWithString:[dict objectForKey:kARKContactURLKey]]];
	[contact setAreaCode:[dict objectForKey:kARKAreaCodeKey]];
	[contact setPhone:[dict objectForKey:kARKPhoneKey]];
	[contact setEmail:[dict objectForKey:kARKEmailKey]];
	[contact setOwned:[[dict objectForKey:kARKOwnedKey] boolValue]];
	[contact setOwnedType:[dict objectForKey:kARKOwnedTypeKey]];
	
	return contact;
}

- (ARKCompany *)companyWithDictionary:(NSDictionary *)dict
{
    ARKCompany *company = [[ARKCompany alloc] init];
	[company setCompanyId:[NSNumber numberWithInt:[[dict objectForKey:kARKCompanyIDKey] intValue]]];
	[company setName:[dict objectForKey:kARKNameKey]];
	[company setPhone:[dict objectForKey:kARKPhoneKey]];
	[company setWebsite:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[dict objectForKey:kARKWebsiteKey]]]];
	[company setStockSymbol:[dict objectForKey:kARKStockSymbolKey]];
	[company setStockExchange:[dict objectForKey:kARKStockExchangeKey]];
	[company setOwnership:[dict objectForKey:kARKOwnershipKey]];
	[company setFortuneRank:[NSNumber numberWithInt:[[dict objectForKey:kARKFortuneRankKey] intValue]]];
	[company setEmployeeCount:[NSNumber numberWithInt:[[dict objectForKey:kARKEmployeeCountKey] intValue]]];
	[company setEmployeeRange:[dict objectForKey:kARKEmployeeRangeKey]];
	[company setRevenue:[dict objectForKey:kARKRevenueRangeKey]];
	[company setIndustry1:[dict objectForKey:kARKIndustry1Key]];
	[company setIndustry2:[dict objectForKey:kARKIndustry2Key]];
	[company setIndustry3:[dict objectForKey:kARKIndustry3Key]];
	[company setSubIndustry1:[dict objectForKey:kARKSubIndustry1Key]];
	[company setSubIndustry2:[dict objectForKey:kARKSubIndustry2Key]];
	[company setSubIndustry3:[dict objectForKey:kARKSubIndustry3Key]];
	[company setSicCode:[dict objectForKey:kARKSICCodeKey]];
	[company setAddress:[dict objectForKey:kARKAddressKey]];
	[company setCity:[dict objectForKey:kARKCityKey]];
	[company setState:[dict objectForKey:kARKStateKey]];
	[company setZip:[dict objectForKey:kARKZipKey]];
	[company setCountry:[dict objectForKey:kARKCountryKey]];
	[company setActiveContacts:[NSNumber numberWithInt:[[dict objectForKey:kARKActiveContactsKey] intValue]]];
	[company setLinkInJigsaw:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[dict objectForKey:kARKLinkInJigsawKey]]]];
	
	NSString *dateString = [dict objectForKey:kARKUpdatedDateKey];
	NSDate *createdDate = [ARKAPIDateFormatter dateFromString:dateString];
	[company setCreatedOn:createdDate];
	
	return company;
}

@end
