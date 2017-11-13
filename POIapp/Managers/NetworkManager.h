//
//  NetworkManager.h
//  StoreGuru
//
//  Created by Viktória Sipos on 10/05/16.
//  Copyright © 2016 Viki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorMessage.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface NetworkManager : NSObject


@end
