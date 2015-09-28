//
//  WLHeaderView.m
//  上下拉刷新界面
//
//  Created by fairy on 15/9/27.
//  Copyright (c) 2015年 fairy. All rights reserved.
//

#import "WLHeaderView.h"

@interface WLHeaderView()
@property(nonatomic,assign)UIScrollView *scrollView;
@property(nonatomic,weak) UIButton *alertButtomView;
@property(nonatomic,weak) UIView *loadingView;
@end

@implementation WLHeaderView
{
    NSString *_beginDragText;
    
}
-(void)setTitle:(NSString *)title forState:(WLHeaderViewStatus)status
{
    switch (status) {
        case WLHeaderViewStatusBeginDrag:
            _beginDragText = title;
            break;
                default:
            break;
    }
}
-(NSString *)titleWithStatus:(WLHeaderViewStatus)status
{
    NSString *title = nil;
    switch (status) {
        case WLHeaderViewStatusBeginDrag:
            title = _beginDragText?_beginDragText:@"刷新";
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
    self.status = WLHeaderViewStatusBeginDrag;
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
//    if (self.status ==WLFooterViewStatusLoading) return ;
    
    [self willMoveToSuperview:self.scrollView];
    if (self.scrollView.isDragging) {
        CGFloat maxY = 0;
       // CGFloat headerViewHeight = self.frame.size.height;
        if (_scrollView.contentOffset.y <= maxY ) {
            [self setStatus:WLHeaderViewStatusBeginDrag];
        }
       
    }
    
    
}
-(UIButton *)alertButtomView
{
    if (_alertButtomView == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        btn.frame = self.bounds;
        _alertButtomView = btn;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        
    }
    return _alertButtomView;
}
+(id)headerView
{
    return [[self alloc]init];
}
-(void)setStatus:(WLHeaderViewStatus)status
{
    _status = status;
    
    switch (status) {
            
        case WLHeaderViewStatusBeginDrag:
            
            [self.alertButtomView setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    UITableView *tableView = (UITableView *)newSuperview;
    CGFloat selfX =0;
    CGFloat selfY =-60;
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
