//
//  NetworkManager.m
//  StoreGuru
//
//  Created by Viktória Sipos on 10/05/16.
//  Copyright © 2016 Viki. All rights reserved.
//


#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "PropertyUtil.h"
#import "MyConstants.h"
#import "NSObject+GetDictionary.h"
#import "AccessTokenManager.h"
#import "JSONParser.h"

@interface NetworkManager()

@property UIViewController* callingViewController;

@end

static NSString* const baseURL= @"http://glrunner1.fuximo.hu:8000/";
static NSString* const loginUrl = @"login";
static NSString* const logoutUrl = @"logout";
static NSString* const categoryUrl = @"category/";
static NSString* const categoryByIdUrl = @"category/%@";
static NSString* const poiByIdUrl = @"poi/%@";
static NSString* const regiserUrl = @"register";
static NSString* const addFavUrl = @"favorite/add/%@";
static NSString* const removeFavUrl = @"favorite/remove/%@";
static NSString* const favoritesUrl = @"favorites";
static NSString* const searchUrl = @"searchPoi";
static NSString* const categoryDetailsUrl = @"categorydetails/%@";

@implementation NetworkManager


#pragma mark - Specific methods

-(void)login:(User*)user successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [self sendPostRequestWithMethodName:loginUrl andJSON:[user getDictionary] andToken:nil successBlock:^(id result) {
        [AccessTokenManager saveAccessToken:result[@"sessionID"]];
        successBlock(result);
    } errorBlock:^(ErrorMessage *error) {
        errorBlock(error);
    }];
}

-(void)registerUser:(User*)user successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [self sendPostRequestWithMethodName:regiserUrl andJSON:[user getDictionary] andToken:nil successBlock:^(id result) {
        [AccessTokenManager saveAccessToken:result[@"sessionId"]];
        successBlock(result);
    } errorBlock:^(ErrorMessage *error) {
        errorBlock(error);
    }];
}


-(void)logoutWithSuccessBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [self sendGetRequestWithMethodName:logoutUrl andToken:[AccessTokenManager getAccessToken] andParameters:nil successBlock:^(id result) {
        [AccessTokenManager saveAccessToken:@""];
        successBlock(result);
    } errorBlock:^(ErrorMessage *error) {
        errorBlock(error);
    }];
}

-(void)getCategoriesWithSuccessBlock:(void (^)(NSArray<Category*>* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [self sendGetRequestWithMethodName:categoryUrl andToken:[AccessTokenManager getAccessToken] andParameters:nil successBlock:^(id result) {
        JSONParser* p = [JSONParser new];
        NSArray<Category*>* c = [p parseCategories:result];
        successBlock(c);
    } errorBlock:^(ErrorMessage *error) {
        errorBlock(error);
    }];
}

-(void)getCategory:(NSNumber*)ID successBlock:(void (^)(Category* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [self sendGetRequestWithMethodName:[NSString stringWithFormat:categoryByIdUrl,ID] andToken:[AccessTokenManager getAccessToken] andParameters:nil successBlock:^(id result) {
        JSONParser* p = [JSONParser new];
        Category* c = [p parseCategory:result];
        successBlock(c);
    } errorBlock:^(ErrorMessage *error) {
        errorBlock(error);
    }];
}

-(void)getDetailedCategory:(NSNumber*)ID successBlock:(void (^)(Category* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [self sendGetRequestWithMethodName:[NSString stringWithFormat:categoryDetailsUrl,ID] andToken:[AccessTokenManager getAccessToken] andParameters:nil successBlock:^(id result) {
        JSONParser* p = [JSONParser new];
        Category* c = [p parseCategory:result];
        successBlock(c);
    } errorBlock:^(ErrorMessage *error) {
        errorBlock(error);
    }];
}

-(void)getPoi:(NSNumber*)ID successBlock:(void (^)(Poi* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [self sendGetRequestWithMethodName:[NSString stringWithFormat:poiByIdUrl,ID] andToken:[AccessTokenManager getAccessToken] andParameters:nil successBlock:^(id result) {
        JSONParser* p = [JSONParser new];
        Poi* c = [p parsePoi:result];
        successBlock(c);
    } errorBlock:^(ErrorMessage *error) {
        errorBlock(error);
    }];
}

-(void)addPoiToFavorite:(NSNumber*)ID successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [self sendGetRequestWithMethodName:[NSString stringWithFormat:addFavUrl,ID] andToken:[AccessTokenManager getAccessToken] andParameters:nil successBlock:^(id result) {
        successBlock(result);
    } errorBlock:^(ErrorMessage *error) {
        errorBlock(error);
    }];
}

-(void)removePoiFromFavorite:(NSNumber*)ID successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [self sendGetRequestWithMethodName:[NSString stringWithFormat:removeFavUrl,ID] andToken:[AccessTokenManager getAccessToken] andParameters:nil successBlock:^(id result) {
        successBlock(result);
    } errorBlock:^(ErrorMessage *error) {
        errorBlock(error);
    }];
}

-(void)getFavoritesWithSuccessBlock:(void (^)(NSArray<Poi*>* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [self sendGetRequestWithMethodName:favoritesUrl andToken:[AccessTokenManager getAccessToken] andParameters:nil successBlock:^(id result) {
        JSONParser* p = [JSONParser new];
        NSArray<Poi*>* c = [p parsePois:result[@"favorites"]];
        successBlock(c);
    } errorBlock:^(ErrorMessage *error) {
        errorBlock(error);
    }];
}

-(void)searchPoi:(NSString*)text successBlock:(void (^)(NSArray<Poi*>* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [self sendPostRequestWithMethodName:searchUrl andJSON:@{@"Text":text} andToken:[AccessTokenManager getAccessToken] successBlock:^(id result) {
        JSONParser* p = [JSONParser new];
        NSArray<Poi*>* c = [p parsePois:result];
        successBlock(c);
    } errorBlock:^(ErrorMessage *error) {
        errorBlock(error);
    }];
}

#pragma mark - General methods
-(void)sendGetRequestWithMethodName:(NSString*)methodName andToken:(NSString*)token andParameters:(NSDictionary*)parameters successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    [[[AFHTTPResponseSerializer serializer] acceptableContentTypes] setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json",@"text/html",@"image/jpg", nil]];
    if (token) {
        [[AFHTTPRequestSerializer serializer] setValue:[NSString stringWithFormat:@"Token %@",token] forHTTPHeaderField:@"authorization"];
    }



    NSString* url = [NSString stringWithFormat:@"%@%@",baseURL,methodName];
    NSString* encodedUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];


    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:encodedUrl parameters:parameters error:nil];
    if (token) {
        [request setValue:[NSString stringWithFormat:@"Token %@",token] forHTTPHeaderField:@"Authorization"];
    }

     NSLog(@"request url: %@",request.URL);

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                ErrorMessage* message = (ErrorMessage*)[PropertyUtil createObject:[ErrorMessage class] fromDictionary:responseObject];

                errorBlock(message);
            }
            else{
                errorBlock(nil);
            }
            NSLog(@"error occured for request %@\n: %@",request.URL, responseObject );

        } else {
           NSLog(@"response: %@ responseobject: %@", response, responseObject);
            successBlock(responseObject);
        }
    }];
    [dataTask resume];

}


-(void)sendPostRequestWithMethodName:(NSString*)methodName andJSON: (NSDictionary*) json andToken:(NSString*)token successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    [[[AFHTTPResponseSerializer serializer] acceptableContentTypes] setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json",@"text/html", nil]];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@",baseURL,methodName] parameters:json error:nil];
    
    NSLog(@"request url: %@",request.URL);
    
    if (token) {
        [request setValue:[NSString stringWithFormat:@"Token %@",token] forHTTPHeaderField:@"Authorization"];
    }
    
    if (json) {
        NSError *err;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&err];
        NSLog(@"pritty printed json:%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    }
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                ErrorMessage* message = (ErrorMessage*)[PropertyUtil createObject:[ErrorMessage class] fromDictionary:responseObject];
                errorBlock(message);
            }
            else{
                errorBlock(nil);
            }
            NSLog(@"error occured for request %@\n: %@",request.URL, responseObject );
        } else {
            NSLog(@"response: %@ responseobject: %@", response, responseObject);
            
            successBlock(responseObject);
        }
    }];
    [dataTask resume];
    
}


@end












