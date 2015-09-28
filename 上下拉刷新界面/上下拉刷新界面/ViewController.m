//
//  ViewController.m
//  上下拉刷新界面
//
//  Created by fairy on 15/9/26.
//  Copyright (c) 2015年 fairy. All rights reserved.
//

#import "ViewController.h"
#import "WLFooterView.h"
#import "WLHeaderView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,WLFooterViewDelegate>
@property (nonatomic,weak)WLFooterView *footerView;
@property (nonatomic,weak)WLHeaderView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WLFooterView * footerView = [WLFooterView footerView];
    
    [self.tableView addSubview:footerView];
    _footerView =footerView;
    
    //    footerView.scrollView = self.tableView;
    _footerView.delegate = self;
    
    [_footerView setTitle:@"拖拽加载更多" forState:WLFooterViewStatusBeginDrag];
    [_footerView setTitle:@"松开加载更多" forState:WLFooterViewStatusDragging];
    [_footerView setTitle:@"正在加载中" forState:WLFooterViewStatusLoading];
    
    WLHeaderView *headerView = [WLHeaderView headerView];
    [self.tableView addSubview:headerView];
    _headerView =headerView;
    [_headerView setTitle:@"下拉刷新" forState:WLHeaderViewStatusBeginDrag];
    _tableView.showsVerticalScrollIndicator = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *Cell = [[UITableViewCell alloc]init];
    
    return Cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)footerViewStatus:(WLFooterView *)footerView status:(WLFooterViewStatus)status
{
    NSLog(@"开始网络请求");
    [self performSelector:@selector(sendRequst) withObject:nil afterDelay:5];
}

- (void)sendRequst
{
    NSLog(@"网络请求结束");
    [self.footerView stopAnimation];
}
- (void)headerViewStatus:(WLHeaderView *)footerView status:(WLHeaderViewStatus)status
{
    NSLog(@"开始刷新");
    [self performSelector:@selector(sendRequst) withObject:nil afterDelay:5];
}

@end
