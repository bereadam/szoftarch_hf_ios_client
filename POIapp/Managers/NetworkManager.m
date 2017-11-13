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

@interface NetworkManager()

@property UIViewController* callingViewController;

@end

static NSString* const baseURL= @"http://46.101.62.53/rest/";
static NSString* const loginUrl = @"public/user/login";


@implementation NetworkManager


#pragma mark - Specific methods

#pragma mark - Login,reg


#pragma mark - General methods
-(void)sendGetRequestWithMethodName:(NSString*)methodName andToken:(NSString*)token andParameters:(NSDictionary*)parameters successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    [[[AFHTTPResponseSerializer serializer] acceptableContentTypes] setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json",@"text/html",@"image/jpg", nil]];
    
    NSString* url = [NSString stringWithFormat:@"%@%@",baseURL,methodName];
    NSString* encodedUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:encodedUrl parameters:parameters error:nil];
    if (token) {
        [request setValue:token forHTTPHeaderField:@"X-S4H-AUTH-TOKEN"];
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


-(void)sendPostRequestWithMethodName:(NSString*)methodName andJSON: (NSDictionary*) json andBasicAuth:(NSDictionary*) authInfo andToken:(NSString*)token successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    [[[AFHTTPResponseSerializer serializer] acceptableContentTypes] setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json",@"text/html", nil]];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@",baseURL,methodName] parameters:json error:nil];
    
    NSLog(@"request url: %@",request.URL);
    
    if (authInfo) {
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", authInfo[@"email"], authInfo[@"password"]];
        NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
        NSString *authValue = [authData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    }
    if (token) {
        [request setValue:token forHTTPHeaderField:@"X-S4H-AUTH-TOKEN"];
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












