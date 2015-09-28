//
//  WLHeaderView.h
//  上下拉刷新界面
//
//  Created by fairy on 15/9/27.
//  Copyright (c) 2015年 fairy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLHeaderView ;

enum WLHeaderViewStatus
{
    WLHeaderViewStatusBeginDrag,
    
};
typedef enum WLHeaderViewStatus WLHeaderViewStatus;
@protocol WLHeaderViewDelegate <NSObject>

-(void)headerViewStatus:(WLHeaderView *)headerView status:(WLHeaderViewStatus)status;

@end
@interface WLHeaderView : UIView
@property(nonatomic,weak)id<WLHeaderViewDelegate> delegate;
@property(nonatomic,assign)WLHeaderViewStatus status;
-(void)stopAnimation;
+(id)headerView;
-(void)setTitle:(NSString *)title forState:(WLHeaderViewStatus)status;
@end
