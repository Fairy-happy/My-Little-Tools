//
//  WLFooterView.m
//  上下拉刷新界面
//
//  Created by fairy on 15/9/26.
//  Copyright (c) 2015年 fairy. All rights reserved.
//

#import "WLFooterView.h"

@interface WLFooterView ()
@property(nonatomic,assign)UIScrollView *scrollView;
@property(nonatomic,weak) UIButton *alertButtomView;
@property(nonatomic,weak) UIView *loadingView;

@end

@implementation WLFooterView
{
    NSString *_beginDragText;
    NSString *_draggingText;
    NSString *_loadingText;
}
-(void)setTitle:(NSString *)title forState:(WLFooterViewStatus)status
{
    switch (status) {
        case WLFooterViewStatusBeginDrag:
            _beginDragText = title;
            break;
            case WLFooterViewStatusDragging:
            _draggingText = title;
            break;
            case WLFooterViewStatusLoading:
            _loadingText = title;
            break;
        default:
            break;
    }
}
-(NSString *)titleWithStatus:(WLFooterViewStatus)status
{
    NSString *title = nil;
    switch (status) {
        case WLFooterViewStatusBeginDrag:
            title = _beginDragText?_beginDragText:@"拖拽";
            break;
        case WLFooterViewStatusDragging:
            title = _draggingText?_draggingText:@"松开";
            break;
        case WLFooterViewStatusLoading:
            title = _loadingText?_loadingText:@"加载";
            break;
        default:
            break;
    }
    return title;
}
-(void)stopAnimation
{
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self clear];
}
-(void)clear
{
    [self.alertButtomView removeFromSuperview];
    [self.loadingView removeFromSuperview];
    self.status = WLFooterViewStatusBeginDrag;
}
-(void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    
}
-(void)setScrollView:(UIScrollView *)scrollView
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.status ==WLFooterViewStatusLoading) return ;
    
    [self willMoveToSuperview:self.scrollView];
    if (self.scrollView.isDragging) {
        CGFloat maxY = _scrollView.contentSize.height-_scrollView.frame.size.height;
        CGFloat footerViewHeight = self.frame.size.height;
        if (_scrollView.contentOffset.y >= maxY &&_scrollView.contentOffset.y < maxY + footerViewHeight) {
            [self setStatus:WLFooterViewStatusBeginDrag];
        }
        else if (_scrollView.contentOffset.y >maxY + footerViewHeight)
        {
            [self setStatus:WLFooterViewStatusDragging];
        }
    }
    else
    {
        if (self.status == WLFooterViewStatusDragging) {
            [self setStatus:WLFooterViewStatusLoading];
            _scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
            [_delegate footerViewStatus:self status:WLFooterViewStatusLoading];
        }
    }
}
-(UIView *)loadingView
{
    if (_loadingView == nil) {
        UIView *loadingView = [UIView new];
        [self addSubview:loadingView];
        _loadingView = loadingView;
        loadingView.frame = self.bounds;
    
        UILabel *labelTitle =[UILabel new];
        [loadingView addSubview:labelTitle];
        labelTitle.text = [self titleWithStatus:WLFooterViewStatusLoading];
        labelTitle.frame = loadingView.bounds;
        labelTitle.textColor = [UIColor blackColor];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView addSubview: activity];
        activity.frame = CGRectMake(50, 20, 40, 40);
        [activity startAnimating];
    }
    return _loadingView;
}
-(UIButton *)alertButtomView
{
    if (_alertButtomView == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        btn.frame = self.bounds;
        _alertButtomView = btn;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    }
    return _alertButtomView;
}
+(id)footerView
{
    return [[self alloc]init];
}
-(void)setStatus:(WLFooterViewStatus)status
{
    _status = status;
    
    switch (status) {
            
        case WLFooterViewStatusBeginDrag:
            
            [self.alertButtomView setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
            break;
        case WLFooterViewStatusDragging:
            //            NSLog(@"松开读取更多");
            [self.alertButtomView setTitle:[self titleWithStatus:status]  forState:UIControlStateNormal];
            break;
        case WLFooterViewStatusLoading:
            self.alertButtomView.hidden = YES;
            self.loadingView;
            break;
            
        default:
            break;
    }
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    UITableView *tableView = (UITableView *)newSuperview;
    CGFloat selfX =0;
    CGFloat selfY =tableView.contentSize.height;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backgroundColor = [UIColor yellowColor];
}
-(void)didMoveToSuperview
{
    self.scrollView = self.superview;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
