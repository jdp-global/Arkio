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
#import "ARKCompanyStatistics.h"
#import "ARKCompanyStatistic.h"

static NSString * const kJigsawSecureHost = @"https://www.jigsaw.com";

// API Errors
static NSString * const kARKErrorCodeAPIKey = @"errorCode";
static NSString * const kARKErrorMessageAPIKey = @"errorMsg";
static NSString * const kARKHTTPStatusCodeAPIKey = @"httpStatusCode";
static NSString * const kARKStackTraceAPIKey = @"stackTrace";

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
	return [self pointBalanceWithDictionary:dictionary key:kARKPointsKey error:error];
}

- (NSInteger)pointBalanceWithDictionary:(NSDictionary *)dictionary
                                    key:(NSString *)key
                                  error:(ARKError * __autoreleasing *)error
{
    if (!dictionary) {
        *error = [ARKError errorWithCode:ARKInvalidArgumentError message:@"Dictionary argument is nil."];
        return -1;
    }
    
    NSNumber *points = dictionary[key];
    if (!points) {
        *error = [ARKError errorWithCode:ARKValueNotFoundError message:@"No points value returned."];
        return -1;
    }
	return [points longValue];
    
}


#pragma mark - Contact Serialization

- (NSSet *)contactsWithDictionary:(NSDictionary *)dictionary error:(ARKError *__autoreleasing *)error
{
    if (!dictionary) {
        *error = [ARKError errorWithCode:ARKInvalidArgumentError message:@"Dictionary argument is nil."];
        return nil;
    }
    
	NSArray *contactDicts = dictionary[kARKContactsAPIKey];
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
    if (!dictionary) {
        *error = [ARKError errorWithCode:ARKInvalidArgumentError message:@"Dictionary argument is nil."];
        return nil;
    }
    
    ARKContactSearchResult *result = [[ARKContactSearchResult alloc] init];
    
    NSNumber *totalHits = dictionary[kARKTotalHitsAPIKey];
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
    if (!dictionary) {
        *error = [ARKError errorWithCode:ARKInvalidArgumentError message:@"Dictionary argument is nil."];
        return nil;
    }
    
	NSArray *companyDicts = dictionary[kARKCompaniesAPIKey];
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
    if (!dictionary) {
        *error = [ARKError errorWithCode:ARKInvalidArgumentError message:@"Dictionary argument is nil."];
        return nil;
    }

    // company ID
    NSNumber *companyID = dictionary[kARKIDAPIKey];
    if (!companyID) {
        *error = [ARKError errorWithCode:ARKValueNotFoundError message:@"companyID is missing."];
        return nil;
    }
    
    ARKCompanyStatistics *stats = [[ARKCompanyStatistics alloc] initWithCompanyID:[companyID longValue]];
    
    // URL
    NSString *urlString = dictionary[kARKURLAPIKey];
    if (urlString && urlString.length > 0) {
        NSURL *url = [NSURL URLWithString:urlString];
        [stats setUrl:url];
    }
    
    // total contacts
    NSNumber *total = dictionary[kARKTotalCountAPIKey];
    if (total) {
        [stats setCount:[total longValue]];
    }

    // department and level breakdowns
    [stats setDepartments:[self group:ARKStatisticGroupDepartment statistics:dictionary[kARKDeparmentsAPIKey]]];
    [stats setLevels:[self group:ARKStatisticGroupLevel statistics:dictionary[kARKLevelsAPIKey]]];
    
    return stats;
}

- (ARKCompanySearchResult *)companySearchResultWithDictionary:(NSDictionary *)dictionary
                                                        error:(ARKError *__autoreleasing *)error
{
    if (!dictionary) {
        *error = [ARKError errorWithCode:ARKInvalidArgumentError message:@"Dictionary argument is nil."];
        return nil;
    }
    
    ARKCompanySearchResult *result = [[ARKCompanySearchResult alloc] init];
    
    NSNumber *totalHits = dictionary[kARKTotalHitsAPIKey];
    if (totalHits) {
        [result setTotalHits:[totalHits longValue]];
    }
    
    NSSet *companies = [self companiesWithDictionary:dictionary error:error];
    [result setCompanies:companies];
    
    return result;
}



#pragma mark - Error Handling
- (NSInteger)errorCodeWithDictionary:(NSDictionary *)dictionary
                               error:(ARKError * __autoreleasing *)error
{
    if (!dictionary) return ARKUnknownError;
    
    NSInteger code = ARKUnknownError;
    NSString *codeString = (NSString *)dictionary[kARKErrorCodeAPIKey];

    if (codeString) {
        code = [codeString intValue];
    }
    
    return code;
}

- (ARKError *)errorWithDictionary:(NSDictionary *)dictionary
                            error:(ARKError * __autoreleasing *)error
{
    if (!dictionary) {
        *error = [ARKError errorWithCode:ARKInvalidArgumentError
                                 message:@"Dictionary argument is nil."];
        return nil;
    }
    
    // bail if we don't find a Data.com error code string
    NSString *errorCode = dictionary[kARKErrorCodeAPIKey];
    if (!errorCode) {
        return nil;
    }
    
    // pull out the HTTP Status Code
    NSInteger statusCode = ARKUnknownError;
    NSString *statusCodeString = (NSString *)[dictionary objectForKey:kARKHTTPStatusCodeAPIKey];
    statusCode = !statusCodeString ? : [statusCodeString intValue];

    ARKError *arkError = [ARKError errorWithCode:errorCode
                                  httpStatusCode:statusCode
                                         message:dictionary[kARKErrorMessageAPIKey]
                                      stackTrace:dictionary[kARKStackTraceAPIKey]];
    return arkError;
}


#pragma mark - Class Extentions
- (ARKContact *)contactWithDictionary:(NSDictionary *)dict
{
    ARKContact *contact  = [[ARKContact alloc] init];

	[contact setContactId:(long)[dict[kARKContactIDKey] longLongValue]];
	[contact setCompanyId:(long)[dict[kARKCompanyIDKey]longLongValue]];
	[contact setTitle:dict[kARKTitleKey]];
	[contact setCompanyName:dict[kARKCompanyNameKey]];
	
	NSString *dateString = dict[kARKUpdatedDateKey];
	NSDate *updatedDate = [ARKAPIDateFormatter dateFromString:dateString];
	[contact setUpdatedDate:updatedDate];
	
	[contact setFirstName:dict[kARKFirstNameKey]];
	[contact setLastName:dict[kARKLastNameKey]];
	[contact setAddress:dict[kARKAddressKey]];
	[contact setCity:dict[kARKCityKey]];
	[contact setState:dict[kARKStateKey]];
	[contact setCountry:dict[kARKCountryKey]];
	[contact setZip:dict[kARKZipKey]];
    
    if (dict[kARKContactURLKey] && [(NSString *)dict[kARKContactURLKey] length] > 0) {
        [contact setContactUrl:[NSURL URLWithString:dict[kARKContactURLKey]]];
    }

    [contact setAreaCode:dict[kARKAreaCodeKey]];
	[contact setPhone:dict[kARKPhoneKey]];
	[contact setEmail:dict[kARKEmailKey]];
	[contact setOwned:[dict[kARKOwnedKey] boolValue]];
	[contact setOwnedType:dict[kARKOwnedTypeKey]];
    
    if (dict[kARKseoContactURLKey] && [(NSString *)dict[kARKseoContactURLKey] length] > 0) {
        [contact setSeoContactURL:[NSURL URLWithString:dict[kARKseoContactURLKey]]];
    }

    
    [contact setContactSales:(long)[dict[kARKContactSalesKey]longLongValue]];
	
	return contact;
}

- (ARKCompany *)companyWithDictionary:(NSDictionary *)dict
{
    ARKCompany *company = [[ARKCompany alloc] init];
	[company setCompanyID:[dict[kARKCompanyIDKey] longValue]];
	[company setName:dict[kARKNameKey]];
	[company setPhone:dict[kARKPhoneKey]];
    
    if (dict[kARKWebsiteKey] && [(NSString *)dict[kARKWebsiteKey] length] > 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",dict[kARKWebsiteKey]]];
        [company setWebsite:url];
    }
    
    [company setStockSymbol:dict[kARKStockSymbolKey]];
	[company setStockExchange:dict[kARKStockExchangeKey]];
	[company setOwnership:dict[kARKOwnershipKey]];
	[company setFortuneRank:(long)[dict[kARKFortuneRankKey] longLongValue]];
	[company setEmployeeCount:(long)[dict[kARKEmployeeCountKey] longLongValue]];
	[company setEmployeeRange:dict[kARKEmployeeRangeKey]];
	[company setRevenue:dict[kARKRevenueRangeKey]];
	[company setIndustry1:dict[kARKIndustry1Key]];
	[company setIndustry2:dict[kARKIndustry2Key]];
	[company setIndustry3:dict[kARKIndustry3Key]];
	[company setSubIndustry1:dict[kARKSubIndustry1Key]];
	[company setSubIndustry2:dict[kARKSubIndustry2Key]];
	[company setSubIndustry3:dict[kARKSubIndustry3Key]];
	[company setSicCode:dict[kARKSICCodeKey]];
	[company setAddress:dict[kARKAddressKey]];
	[company setCity:dict[kARKCityKey]];
	[company setState:dict[kARKStateKey]];
	[company setZip:dict[kARKZipKey]];
	[company setCountry:dict[kARKCountryKey]];
	[company setActiveContacts:(long)[dict[kARKActiveContactsKey] longLongValue]];
    
    if (dict[kARKLinkInJigsawKey] && [(NSString *)dict[kARKLinkInJigsawKey] length] > 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",dict[kARKWebsiteKey]]];
        [company setLinkInJigsaw:url];
    }
	
	NSString *dateString = dict[kARKUpdatedDateKey];
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
        [stat setName:dict[kARKNameKey]];

        // contact count
        NSNumber *count = dict[kARKCountAPIKey];
        if (count) {
            [stat setCount:[count longValue]];
        }

        // url
        NSString *path = dict[kARKURLAPIKey];
        if (path) {
            [stat setUrl:[NSURL URLWithString:path relativeToURL:ARKAPIJigsawBaseURL]];
        }
        
        [groups addObject:stat];
    }
    
    return groups;
}
@end
