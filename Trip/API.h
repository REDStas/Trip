//
//  API.h
//  Trip
//
//  Created by Станислав Редреев on 28.02.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

@interface API : NSObject
{
    AFHTTPClient *httpClient;
    NSDictionary *staticJSONParameters;
}

+ (API *)sharedAPI;

- (void)singUpWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON;

@end
