//
//  ARKErrors.h
//  Arkio
//
//  Created by Ray Scott on 26/11/2013.
//  Copyright (c) 2013 Alien Hitcher. All rights reserved.
//

/* NSError codes in ARKErrorDomain.
 */
enum {
    
    ARKUnknownError = -1,
    
    ARKJSONSerializationError   = 1,        // error has occurred in underlying JSON Serialization call
    ARKInvalidArgumentsError    = 2,        // method contract wasn't upheld
    ARKValueNoFoundError        = 3,        // expected value is missing
    ARKValidationError          = 4,         // invalid data encountered
    
    
    // Data.com API Error Codes
    // 400
    ARKDataDotComParameterError         = 400,  // bad request E.G missing or incorrect parameter
    ARKDataDotComForbiddenError         = 403,  // typical failure, E.G. authentication failure, or incorrect developer token
    ARKDataDotComNotFoundError          = 404,  // attempt to access non-existent data, E.G. contact not found for ID
    ARKDataDotComMethodNotAllowedError  = 405,  // E.G. on contact not owned.

    // 500
    ARKDataDotComInternalServerError    = 500,  // typically caused by a system or search error
    ARKDataDotComNotSupportedError      = 501,  // attempted to acceess an unimplemented feature
    ARKDataDotComNotAvailableError      = 503   // the service is unavailable
};

