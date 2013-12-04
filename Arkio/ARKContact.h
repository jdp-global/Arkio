//
//  ARKContact.h
//  Arkio
//
//  Created by Ray Scott on 24/11/2013.
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

#import "ARKEntity.h"

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
     *  C-suite (Cxx) level.
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
 *  A Contact entity in the Data.com service.
 */
@interface ARKContact : ARKEntity


/**
 *  The unique identifier for this contact in Data.com
 */
@property (nonatomic) long contactId;

/**
 *  The unique identifier for the company this contact is employed by.
 */
@property (nonatomic) long companyId;

/**
 *  The job title of this contact.
 */
@property (nonatomic, strong) NSString *title;

/**
 *  The name of the company this contact is employed by.
 */
@property (nonatomic, strong) NSString *companyName;

/**
 *  The date on which this contact record was last updated.
 */
@property (nonatomic, strong) NSDate *updatedDate;

/**
 *  Indicates whether this contact has been buried in the graveyard or not.
 */
@property BOOL graveyardStatus;

/**
 *  The first name of this contact.
 */
@property (nonatomic, strong) NSString *firstName;

/**
 *  The last name of this contact.
 */
@property (nonatomic, strong) NSString *lastName;

/**
 *  Address line 1 for this contact.
 */
@property (nonatomic, strong) NSString *address;

/**
 *  The city this contact lives in.
 */
@property (nonatomic, strong) NSString *city;

/**
 *  The state/province this contact lives in.
 */
@property (nonatomic, strong) NSString *state;

/**
 *  The country this contact lives in.
 */
@property (nonatomic, strong) NSString *country;

/**
 *  The zip/post code for this contacts address.
 */
@property (nonatomic, strong) NSString *zip;

/**
 *  The URL for this contact's profile on Data.com.
 */
@property (nonatomic, strong) NSURL *contactUrl;

/**
 *  The area telephone phone code for this contact.
 */
@property (nonatomic, strong) NSString *areaCode;

/**
 *  The land-line telephone number for this contact.
 */
@property (nonatomic, strong) NSString *phone;

/**
 *  The e-mail address for this contact.
 */
@property (nonatomic, strong) NSString *email;

/**
 *  Indicates whether this contact is owned by the Data.com user of the API service.
 */
@property BOOL owned;

/**
 *  The type of ownership of this Contact record.
 *
 *  For example `USER`.
 */
@property (nonatomic, strong) NSString *ownedType;

@end
