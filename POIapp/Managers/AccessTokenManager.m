//
//  AccessTokenManager.m
//  ShareForHelp
//
//  Created by Viktória Sipos on 2017. 07. 17..
//  Copyright © 2017. MyItSolver. All rights reserved.
//

#import "AccessTokenManager.h"

@implementation AccessTokenManager

+(NSString*)getAccessToken{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
}

+(void)saveAccessToken:(NSString*)token{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"accessToken"];
}

@end
