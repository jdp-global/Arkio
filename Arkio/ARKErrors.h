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
    ARKValidationError          = 4         // invalid data encountered
};

