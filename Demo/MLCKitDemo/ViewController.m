//
//  ViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSArray *titles;//
@property (nonatomic,strong) UITableView *tableView;//

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页列表";
    [self tableView];
}
#pragma mark - Getter
- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"UIView、UIControl的手势事件", @"NSString Category", @"批量连接视图", @"直接调用系统方法操作约束", @"工具类MLCDeviceUtility", @"工具类MLCOpenUtility", @"定位相关", @"相册/相机相关", @"文档相关", @"颜色相关", @"字体相关", @"查看本地沙盒文件", @"使用MLCProxy去除循环引用", @"归档、反归档", @"json使用", @"圆角处理", @"弹出UIAlertController", @"显示白色菊花loading", @"扫描二维码"];
    }
    return _titles;
}
- (UITableView *)tableView {
    if (! _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        //        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
//        _tableView.backgroundColor = [UIColor purpleColor];
        _tableView.estimatedRowHeight = 44.0f;
        //        _tableView.rowHeight = UITableViewAutomaticDimension;
        //        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
//            if (@available(iOS 11.0, *)) {
//                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
//            } else {
//                make.top.equalTo(self.mas_topLayoutGuideBottom);
//            }
        }];
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    static NSArray *vcClassNames = nil;
    if (!vcClassNames) {
        vcClassNames = @[@"LCViewGestureViewController", @"LCStringCategoryViewController", @"LCCombineViewsViewController", @"LCUseConstraintPurelyViewController", @"LCDeviceUtilityViewController", @"LCOpenUtilityViewController", @"LCLocationManagerViewController", @"LCPhotosViewController", @"LCDocumentViewController", @"LCColorViewController", @"LCFontViewController", @"LCSeeLocalFileViewController", @"LCUseProxyViewController", @"MengUseArchiverViewController", @"LCJsonViewController", @"LCHandleCornerViewController", @"LCShowAlertViewController", @"LCShowLoadingViewController", @"LCUseScanQRCodeViewController"];
    }
    Class class = NSClassFromString(vcClassNames[indexPath.row]);
    UIViewController *vc = [[class alloc]init];
    if (!vc) {
        return;
    }
    vc.title = vcClassNames[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
//        cell.contentView.backgroundColor = [UIColor cyanColor];
    }
    cell.textLabel.text = self.titles[indexPath.row];//
    
    return cell;
}

@end
