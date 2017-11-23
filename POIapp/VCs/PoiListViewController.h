//
//  PoiListViewController.h
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "ParentViewController.h"
#import "Poi.h"

@interface PoiListViewController : ParentViewController

@property NSArray<Poi*>* pois;
-(void)reloadTableView;
@property BOOL search;

@end
