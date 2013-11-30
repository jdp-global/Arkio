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
#import "ARKCompanyStatistics.h"
#import "ARKCompanyStatistic.h"

static NSString * const kJigsawSecureHost = @"https://www.jigsaw.com";

static NSString * const kARKDefaultAPIErrorCodeKey = @"errorCode";
static NSString * const kARKDefaultAPIErrorMessageKey = @"errorMsg";
static NSString * const kARKContactsAPIKey = @"contacts";
static NSString * const kARKCompaniesAPIKey = @"companies";
static NSString * const kARKIDAPIKey = @"id";
static NSString * const kARKURLAPIKey = @"url";
static NSString * const kARKCountAPIKey = @"count";
static NSString * const kARKTotalCountAPIKey = @"totalCount";
static NSString * const kARKTotalHitsAPIKey = @"totalHits";
static NSString * const kARKLevelsAPIKey = @"levels";
static NSString * const kARKDeparmentsAPIKey = @"departments";

static NSDateFormatter *ARKAPIDateFormatter;
static NSURL *ARKAPIJigsawBaseURL;

@interface ARKSerialization ()

- (ARKContact *)contactWithDictionary:(NSDictionary *)dict;
- (ARKCompany *)companyWithDictionary:(NSDictionary *)dict;

// builds a set of ARKCompanyStatistic objects from a JSON object (array) for a given group type
- (NSSet *)group:(ARKStatisticGroupType)type statistics:(NSArray *)statistics;

@end

@implementation ARKSerialization

#pragma mark - Class Initialization
+ (void)initialize
{
    ARKAPIDateFormatter = [[NSDateFormatter alloc] init];
    [ARKAPIDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    
    ARKAPIJigsawBaseURL = [NSURL URLWithString:kJigsawSecureHost];
}

#pragma mark - User Account

- (NSInteger)pointBalanceWithDictionary:(NSDictionary *)dictionary error:(ARKError * __autoreleasing *)error
{
    if (dictionary == nil) {
        *error = [ARKError errorWithCode:ARKInvalidArgumentsError message:@"Dictionary argument is nil."];
        return -1;
    }

    NSNumber *points = [dictionary objectForKey:kARKPointsKey];
    if (!points) {
        *error = [ARKError errorWithCode:ARKValueNoFoundError message:@"No points value returned."];
        return -1;
    }
	return [points longValue];

}

#pragma mark - Contact Serialization

- (NSSet *)contactsWithDictionary:(NSDictionary *)dictionary error:(ARKError *__autoreleasing *)error
{
    if (dictionary == nil) {
        *error = [ARKError errorWithCode:ARKInvalidArgumentsError message:@"Dictionary argument is nil."];
        return nil;
    }
    
	NSArray *contactDicts = [dictionary objectForKey:kARKContactsAPIKey];
	NSMutableSet *contacts = [[NSMutableSet alloc] initWithCapacity:1];
	
	for (NSDictionary *dict in contactDicts) {
		
		ARKContact *contact = [self contactWithDictionary:dict];
		[contacts addObject:contact];
        contact = nil;
	}

	return contacts;
}

- (ARKContactSearchResult *)contactSearchResultWithDictionary:(NSDictionary *)dictionary
                                                        error:(ARKError * __autoreleasing *)error
{
    ARKContactSearchResult *result = [[ARKContactSearchResult alloc] init];
    
    NSNumber *totalHits = [dictionary objectForKey:kARKTotalHitsAPIKey];
    if (totalHits) {
        [result setTotalHits:[totalHits longValue]];
    }
    
    NSSet *contacts = [self contactsWithDictionary:dictionary error:error];
    [result setContacts:contacts];
    
    return result;
}

#pragma mark - Company Serialization

- (NSSet *)companiesWithDictionary:(NSDictionary *)dictionary
                             error:(ARKError * __autoreleasing *)error
{
    if (dictionary == nil) {
        *error = [ARKError errorWithCode:ARKInvalidArgumentsError message:@"Dictionary argument is nil."];
        return nil;
    }
    
	NSArray *companyDicts = [dictionary objectForKey:kARKCompaniesAPIKey];
    NSMutableSet *companies = [[NSMutableSet alloc] initWithCapacity:1];
	
	for (NSDictionary *dict in companyDicts) {
		
		ARKCompany *company = [self companyWithDictionary:dict];
		[companies addObject:company];
		company = nil;
	}
    
	return (NSSet *)companies;
}

- (ARKCompanyStatistics *)companyStatisticsWithDictionary:(NSDictionary *)dictionary
                                                    error:(ARKError * __autoreleasing *)error
{
    if (dictionary == nil) {
        *error = [ARKError errorWithCode:ARKInvalidArgumentsError message:@"Dictionary argument is nil."];
        return nil;
    }

    // company ID
    NSNumber *companyID = [dictionary objectForKey:kARKIDAPIKey];
#warning TODO test for nil to return with error
    
    ARKCompanyStatistics *stats = [[ARKCompanyStatistics alloc] initWithCompanyID:[companyID longValue]];
    
    // URL
    NSString *urlString = [dictionary objectForKey:kARKURLAPIKey];
    if (urlString && urlString.length > 0) {
        NSURL *url = [NSURL URLWithString:urlString];
        [stats setUrl:url];
    }
    
    // total contacts
    NSNumber *total = [dictionary objectForKey:kARKTotalCountAPIKey];
    if (total) {
        [stats setCount:[total longValue]];
    }

    // department and level breakdowns
    [stats setDepartments:[self group:ARKStatisticGroupDepartment statistics:[dictionary objectForKey:kARKDeparmentsAPIKey]]];
    [stats setLevels:[self group:ARKStatisticGroupLevel statistics:[dictionary objectForKey:kARKLevelsAPIKey]]];
    
    return stats;
}

- (ARKCompanySearchResult *)companySearchResultWithDictionary:(NSDictionary *)dictionary
                                                        error:(ARKError *__autoreleasing *)error
{
    ARKCompanySearchResult *result = [[ARKCompanySearchResult alloc] init];
    
    NSNumber *totalHits = [dictionary objectForKey:kARKTotalHitsAPIKey];
    if (totalHits) {
        [result setTotalHits:[totalHits longValue]];
    }
    
    NSSet *companies = [self companiesWithDictionary:dictionary error:error];
    [result setCompanies:companies];
    
    return result;
}



#pragma mark - Error Handling

- (NSInteger)errorCodeWithData:(NSData *)data error:(ARKError * __autoreleasing *)error
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
    
    NSString *codeString = (NSString *)[dict objectForKey:kARKDefaultAPIErrorCodeKey];

    if (codeString) {
        code = [codeString intValue];
    }
    
    return code;
}

- (NSError *)errorWithData:(NSData *)data key:(NSString *)key error:(ARKError * __autoreleasing *)error;
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
    NSString *codeString = (NSString *)[dict objectForKey:kARKDefaultAPIErrorCodeKey];
    
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

- (NSError *)errorWithData:(NSData *)data error:(ARKError * __autoreleasing *)error
{
    return [self errorWithData:data key:kARKDefaultAPIErrorMessageKey error:error];
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
	[company setCompanyID:[[dict objectForKey:kARKCompanyIDKey] longValue]];
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
	[company setLinkInJigsaw:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",
                                                   [dict objectForKey:kARKLinkInJigsawKey]]]];
	
	NSString *dateString = [dict objectForKey:kARKUpdatedDateKey];
	NSDate *createdDate = [ARKAPIDateFormatter dateFromString:dateString];
	[company setCreatedOn:createdDate];
	
	return company;
}

- (NSSet *)group:(ARKStatisticGroupType)type statistics:(NSArray *)statistics
{
    NSMutableSet *groups = [NSMutableSet setWithCapacity:[statistics count]];

    for (NSDictionary *dict in statistics) {

        ARKCompanyStatistic *stat = [[ARKCompanyStatistic alloc] initWithGroupType:type];
        
        // name
        [stat setName:[dict objectForKey:kARKNameKey]];

        // contact count
        NSNumber *count = [dict objectForKey:kARKCountAPIKey];
        if (count) {
            [stat setCount:[count longValue]];
        }

        // url
        NSString *path = [dict objectForKey:kARKURLAPIKey];
        if (path) {
            [stat setUrl:[NSURL URLWithString:path relativeToURL:ARKAPIJigsawBaseURL]];
        }
        
        [groups addObject:stat];
    }
    
    return groups;
}
@end
