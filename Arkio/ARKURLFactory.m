//
//  ARKURLFactory.m
//  Arkio
//
//  Created by Ray Scott on 25/11/2013.
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

#import "ARKURLFactory.h"

#import "ARKContact.h"
#import "NSObject+ARKFoundation.h"

static ARKURLFactory *sharedInstance;
static NSString *ARKDateFormat = @"yyyy-MM-dd HH:mm:ss";

@interface ARKURLFactory ()

// creates a parameterized string from the auth credentials
- (NSString *)credentialsAsParameterString;

// trims the end of the string and then replaces spaces with commas
- (NSString *)delimitWords:(NSString *)string;

// converts a ARKContact to a dictionary representation
- (NSDictionary *)dictionaryForContact:(ARKContact *)contact;

@end

@implementation ARKURLFactory

#pragma mark - Designated Object Initializers

- (instancetype)initWithSession:(ARKSession *)session
{
    self = [super init];
    if (self) {
        self.session = session;
    }
    return self;
}

#pragma mark - Constructing API Request URLs
#pragma mark - User / Authentication Request URLs

- (NSURL *)userAuthURL
{
    return [self userInfoURL];
}

- (NSURL *)userInfoURL
{
    NSMutableString *urlString = [NSMutableString stringWithCapacity:10];
    
	[urlString setString:[self.session.server.endpoint absoluteString]];
	[urlString appendString:@"user.json?token="];
	[urlString appendString:self.session.APIDeveloperToken];
	[urlString appendString:[self credentialsAsParameterString]];
    
	return [NSURL URLWithString:urlString];
}


#pragma mark - Contact Request URLs

- (NSURL *)contactURLWithID:(long)contactID
{
    NSMutableString *urlString = [NSMutableString stringWithCapacity:10];
    
	[urlString setString:[self.session.server.endpoint absoluteString]];
	[urlString appendFormat:@"contacts/%ld.json?token=", contactID];
	[urlString appendString:self.session.APIDeveloperToken];
    [urlString appendString:[self credentialsAsParameterString]];
	[urlString appendString:@"&purchaseFlag=true"];
	
	return [NSURL URLWithString:urlString];
}


- (NSURL *)contactSearchURLWithString:(NSString *)string
                               offset:(int)offset
                                 size:(int)size
{
	NSString *firstname = @"";
	NSString *lastname = @"";
	BOOL emailSearch = NO;
    
	// decide which split rule to use based on existance of at least one comma
	NSRange comma = [string rangeOfString:@","];
	
	// if comma found, use text either side as first and last name comma delimited params
	if (comma.location != NSNotFound) {
		
		firstname = [self delimitWords:[string substringToIndex:comma.location]];
		lastname = [self delimitWords:[string substringFromIndex:(comma.location + comma.length)]];
	}
	else {
		
		// otherwise assign the first name as such and the rest as the last name
		// this is all based on the first space as a field delimiter
		// we then have to comma delimit the last names if necessary
		NSRange spaceRange = [string rangeOfString:@" "];
		
		// if we have at least 2 words
		// split at first space, assign to first name
		if (spaceRange.location != NSNotFound) {
			firstname = [string substringToIndex:spaceRange.location];
			lastname = [self delimitWords:[string substringFromIndex:(spaceRange.location + spaceRange.length)]];
		}
		else {
			// test for an email address
			NSRange atRange = [string rangeOfString:@"@"];
			if (atRange.location != NSNotFound) {
				emailSearch = YES;
			}
			else {
				// set the first name only
				firstname = string;
			}
		}
	}
	
	
	// build URL string for search
	NSMutableString *urlString = [NSMutableString stringWithCapacity:10];
	[urlString setString:[self.session.server.endpoint absoluteString]];
	[urlString appendString:@"searchContact.json?token="];
	[urlString appendString:self.session.APIDeveloperToken];
	
	// append either email or first/last params
	if (emailSearch) {
		[urlString appendFormat:@"&email=%@", string];
	}
	else {
		[urlString appendFormat:@"&firstname=%@", firstname];
		[urlString appendFormat:@"&lastname=%@", lastname];
	}
    
	[urlString appendString:[NSString stringWithFormat:@"&offset=%i&pageSize=%i", offset, size]];
    
	return [NSURL URLWithString:urlString];
}

- (NSURL *)contactSearchURLWithCompanyName:(NSString *)companyName
                                 firstLast:(NSString *)firstLast
                                     level:(ARKContactLevel)level
                                    offset:(int)offset
                                      size:(int)size
{
    NSMutableString *urlString = [NSMutableString stringWithCapacity:10];
	[urlString setString:[self.session.server.endpoint absoluteString]];
	[urlString appendString:@"searchContact.json?token="];
	[urlString appendString:self.session.APIDeveloperToken];
	[urlString appendFormat:@"&companyName=%@", companyName];
	[urlString appendString:[NSString stringWithFormat:@"&offset=%i&pageSize=%i", offset, size]];
	
	// synthesize level
	NSString *levelString = @"";
    
    switch (level) {
        case ARKContactLevelC:
            levelString = @"c-level";
            break;
            
        case ARKContactLevelVP:
            levelString = @"VP";
            break;
            
        case ARKContactLevelDirector:
            levelString = @"Director";
            break;
            
        case ARKContactLevelManager:
            levelString = @"Manager";
            break;
            
        default:
            break;
    }
    
	if (![levelString isEqualToString:@""]) {
		[urlString appendFormat:@"&levels=%@", levelString];
	}
	
    BOOL emailSearch = NO;
	NSString *emailString = @"";
	
	// first & last name
	if (![firstLast isEqualToString:@" "]) {
		
		NSString *firstname = @"";
		NSString *lastname = @"";
		
		// trim spaces from either end or we may be left with that "search all" space the user didn't clear
		firstLast = [firstLast stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		// decide which split rule to use based on existance of at least one comma
		NSRange range = [firstLast rangeOfString:@","];
		
		// if comma found, use text either side as first and last name comma delimited params
		if (range.location != NSNotFound) {
			
			firstname = [self delimitWords:[firstLast substringToIndex:range.location]];
			lastname = [self delimitWords:[firstLast substringFromIndex:(range.location + range.length)]];
		}
		else {
			// otherwise assign the first name as such and the rest as the last name
			// this is all based on the first space as a field delimiter
			// we then have to comma delimit the last names if necessary
			NSRange spaceRange = [firstLast rangeOfString:@" "];
			
			// if we have at least 2 words
			// split at first space, assign to first name
			if (spaceRange.location != NSNotFound) {
				firstname = [firstLast substringToIndex:spaceRange.location];
				lastname = [self delimitWords:[firstLast substringFromIndex:(spaceRange.location + spaceRange.length)]];
			}
			else {
				// treat as an email address
				emailSearch = YES;
				NSRange atRange = [firstLast rangeOfString:@"@"];
                
				// we have the entire email address
				if (atRange.location != NSNotFound) {
					emailString = firstLast;
				}
				else {
					// we only have the email account name so append the domain name
					NSRange wwwRange =  [companyName rangeOfString:@"www."];
					if (wwwRange.location != NSNotFound) {
						NSString *domainName = [companyName substringFromIndex:(wwwRange.location + wwwRange.length)];
						emailString = [NSString stringWithFormat:@"%@@%@", firstLast, domainName];
					}
					else {
						emailString = [NSString stringWithFormat:@"%@@%@", firstLast, companyName];
					}
				}
				
			}
		}
		
		// append either email or first/last params
		if (emailSearch) {
			[urlString appendFormat:@"&email=%@", emailString];
		}
		else {
			[urlString appendFormat:@"&firstname=%@", firstname];
			[urlString appendFormat:@"&lastname=%@", lastname];
		}
    }
	
	return [NSURL URLWithString:urlString];
}


#pragma mark - Company Request URLs
- (NSURL *)companyStatisticsURLWithID:(long)companyId
{
    NSMutableString *urlString = [NSMutableString stringWithCapacity:10];

    [urlString setString:[self.session.server.endpoint absoluteString]];
	[urlString appendFormat:@"companyContactCount/%ld.json?token=", companyId];
	[urlString appendString:self.session.APIDeveloperToken];
    
    return [NSURL URLWithString:urlString];
}


- (NSURL *)companySearchURLWithString:(NSString *)string
                               offset:(int)offset
                                 size:(int)size
                             detailed:(BOOL)detailed
{
	NSMutableString *urlString = [NSMutableString stringWithCapacity:10];
    
	[urlString setString:[self.session.server.endpoint absoluteString]];
	[urlString appendString:@"searchCompany.json?token="];
	[urlString appendString:self.session.APIDeveloperToken];
    
    // trim and replace spaces with commas
    NSString *parameterizedString = [string stringByReplacingOccurrencesOfString:@" " withString:@","];
	[urlString appendString:@"&name="];
    [urlString appendString:parameterizedString];
    
	[urlString appendString:[NSString stringWithFormat:@"&offset=%i&pageSize=%i", offset, size]];
	
    if (detailed) {
        [urlString appendString:@"&showDetail=true"];
    }
    
	return [NSURL URLWithString:urlString];
}


#pragma mark - Class Extentions

- (NSString *)credentialsAsParameterString
{
    return [NSString stringWithFormat:@"&username=%@&password=%@",
            self.session.user.credentials.username,
            self.session.user.credentials.password];
}

- (NSString *)delimitWords:(NSString *)string {
	
	NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *delimitedString = [trimmedString stringByReplacingOccurrencesOfString:@" " withString:@","];
	
	return delimitedString;
}

- (NSDictionary *)dictionaryForContact:(ARKContact *)contact
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    // mandatory fields
    [dict setObject:contact.email forKey:@"email"];
    [dict setObject:contact.firstName forKey:@"firstName"];
    [dict setObject:contact.lastName forKey:@"lastName"];
    [dict setObject:contact.title forKey:@"title"];
    
    // optional fields
    if (contact.phone)      { [dict setObject:contact.phone forKey:@"phone"]; }
    if (contact.address)    { [dict setObject:contact.address forKey:@"address"]; }
    if (contact.zip)        { [dict setObject:contact.zip forKey:@"zip"]; }
    if (contact.country)    { [dict setObject:contact.country forKey:@"country"]; }
    if (contact.city)       { [dict setObject:contact.city forKey:@"city"]; }
    if (contact.state)      { [dict setObject:contact.state forKey:@"state"]; }
    
    return dict;
}

#pragma mark - NSObject Overrides

-(NSString *)description
{
    return [self autoDescription];
}

@end
