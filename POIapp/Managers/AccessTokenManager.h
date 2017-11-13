//
//  AccessTokenManager.h
//  ShareForHelp
//
//  Created by Viktória Sipos on 2017. 07. 17..
//  Copyright © 2017. MyItSolver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessTokenManager : NSObject

+(NSString*)getAccessToken;
+(void)saveAccessToken:(NSString*)token;

@end
