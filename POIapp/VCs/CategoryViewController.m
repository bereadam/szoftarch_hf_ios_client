//
//  CategoryViewController.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..@""
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryCell.h"
#import "MainViewController.h"
#import "NetworkManager.h"
#import "PoiListViewController.h"
#import "PoiDistanceManager.h"

@interface CategoryViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray<Category*>* categories;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.category) {
        [self getCategories];
    }
    else{
        self.categories = self.category.subCategories;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
    Category* cat = self.categories [indexPath.row];
    cell.nameLabel.text = cat.name;
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
    Category* cat = self.categories [indexPath.row];
    [self getCategoryById:cat.id];
    
}

#pragma mark - Networking

-(void)getCategories{
    [[NetworkManager new] getCategoriesWithSuccessBlock:^(NSArray<Category *> *result) {
        self.categories = result;
        [self.tableView reloadData];
    } errorBlock:^(ErrorMessage *error) {
        
    }];
}

-(void)getCategoryById:(NSNumber*)ID{
    [[NetworkManager new] getDetailedCategory:ID successBlock:^(Category *result) {
        if(result.subCategories.count){
            UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            CategoryViewController* VC = [sb instantiateViewControllerWithIdentifier:@"categoryVC"];
            VC.category = result;
            [self.navigationController pushViewController:VC animated:true];
        }
        else{
            UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            PoiListViewController* VC = [sb instantiateViewControllerWithIdentifier:@"poiListVC"];
            VC.pois = [[PoiDistanceManager new] calculateDistancAndSortPois:result.pois currentLocation:((ParentViewController*)self.navigationController.parentViewController).currentLocation];
            VC.search = false;
            [self.navigationController pushViewController:VC animated:true];
        }
        
        [((MainViewController*)self.navigationController.parentViewController) setBackActive:true];
    } errorBlock:^(ErrorMessage *error) {
        
    }];
}

@end
