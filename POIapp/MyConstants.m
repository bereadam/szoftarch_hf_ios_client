//
//  MediMapResources.m
//  MediMap
//
//  Created by Viktória Sipos on 02/09/16.
//  Copyright © 2016 Viki. All rights reserved.
//

#import "MyConstants.h"

@implementation MyConstants

+ (MyConstants *)shared
{
    static MyConstants *shared;
    
    @synchronized(self)
    {
        if (!shared)
        shared= [[MyConstants alloc] init];

        
        return shared;
    }
}

@end
