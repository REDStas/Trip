//
//  API.m
//  Trip
//
//  Created by Станислав Редреев on 28.02.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "API.h"

@implementation API

static API* sharedInstance = nil;

+ (API *)sharedAPI
{
    @synchronized([API class])
    {
        if (!sharedInstance)
            sharedInstance = [[API alloc] init];
        
        return sharedInstance;
    }
    return nil;
    
//    static id sharedInstance = nil;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[self alloc] init];
//    });
//    return sharedInstance;
}

+ (id)alloc
{
    @synchronized([API class])
    {
        NSAssert(sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
        sharedInstance = [super alloc];
        return sharedInstance;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        NSURL *url = [NSURL URLWithString:@"http://trip.hol.es"];
        httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        // массив с обязательными параметрами добавляем его в каждом методе в params
        //staticJSONParameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                //@"9DX7qlkeBKLgOd25dYSowSzhNE9ary8E", @"security",
                                //nil];
    }
    return self;
}

- (void)singUpwWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       email, @"email",
                                       password, @"password",
                                       nil];
    [parameters addEntriesFromDictionary:staticJSONParameters];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api/login.php" parameters:parameters];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        successJSON(JSON);
        NSLog(@"API clientTheme - %@", JSON);
    } failure:^(NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id JSON ) {
        failureJSON(error);
        NSLog(@"API-ERROR clientTheme - %@", error);
    }];
    [operation start];
}

@end
