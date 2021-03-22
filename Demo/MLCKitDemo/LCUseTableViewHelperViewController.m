//
//  LCUseTableViewHelperViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2021/3/19.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "LCUseTableViewHelperViewController.h"
#import "MLCTableViewHelper.h"

@interface LCUseTableViewHelperViewController ()

@end

@implementation LCUseTableViewHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self useTableViewHelper];
}
#pragma mark -
- (void)useTableViewHelper {
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    MLCTableViewHelper *helper = [[MLCTableViewHelper alloc] initWithTableView:tableView];
    {
        MLCTableViewSection *section = [[MLCTableViewSection alloc]init];
        
        
        
        [helper.sections addObject:section];
    }
    
    [tableView reloadData];
}

@end
