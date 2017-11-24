//
//  PoiListViewController.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "PoiListViewController.h"
#import "POICell.h"
#import "POIDetailViewController.h"

@interface PoiListViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PoiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadTableView{
    [self.tableView reloadData];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pois.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    POICell *cell = [tableView dequeueReusableCellWithIdentifier:@"poiCell"];
    Poi* p = self.pois[indexPath.row];
    cell.nameLabel.text = p.name;
    if (p.distance.integerValue>2000) {
        cell.distanceLabel.text=[NSString stringWithFormat:@"%0.1f km",p.distance.doubleValue/1000];
    }
    else{
        cell.distanceLabel.text=[NSString stringWithFormat:@"%li m",(long)p.distance.integerValue];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    Poi* p = self.pois[indexPath.row];
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    POIDetailViewController* VC = [sb instantiateViewControllerWithIdentifier:@"poiDetailVC"];
    VC.poi = p;
    [self.navigationController pushViewController:VC animated:true];
}

@end
