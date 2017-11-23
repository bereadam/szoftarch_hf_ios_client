//
//  NetworkManager.h
//  StoreGuru
//
//  Created by Viktória Sipos on 10/05/16.
//  Copyright © 2016 Viki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorMessage.h"
#import "Category.h"
#import "User.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface NetworkManager : NSObject

-(void)login:(User*)user successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock;
-(void)registerUser:(User*)user successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock;
-(void)logoutWithSuccessBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock;
-(void)getCategoriesWithSuccessBlock:(void (^)(NSArray<Category*>* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock;
-(void)getCategory:(NSNumber*)ID successBlock:(void (^)(Category* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock;
-(void)getPoi:(NSNumber*)ID successBlock:(void (^)(Poi* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock;
-(void)addPoiToFavorite:(NSNumber*)ID successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock;
-(void)removePoiFromFavorite:(NSNumber*)ID successBlock:(void (^)(id result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock;
-(void)getFavoritesWithSuccessBlock:(void (^)(NSArray<Poi*>* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock;
-(void)searchPoi:(NSString*)text successBlock:(void (^)(NSArray<Poi*>* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock;
-(void)getDetailedCategory:(NSNumber*)ID successBlock:(void (^)(Category* result))successBlock errorBlock:(void (^)(ErrorMessage *error))errorBlock;
@end
