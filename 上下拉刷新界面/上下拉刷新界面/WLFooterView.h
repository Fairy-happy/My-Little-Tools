//
//  WLFooterView.h
//  上下拉刷新界面
//
//  Created by fairy on 15/9/26.
//  Copyright (c) 2015年 fairy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLFooterView;

enum WLFooterViewStatus
{
    WLFooterViewStatusBeginDrag,
    WLFooterViewStatusDragging,
    WLFooterViewStatusLoading,
};
typedef enum WLFooterViewStatus WLFooterViewStatus;
@protocol WLFooterViewDelegate <NSObject>

-(void)footerViewStatus:(WLFooterView *)footerView status:(WLFooterViewStatus)status;

@end
@interface WLFooterView : UIView
@property(nonatomic,weak)id<WLFooterViewDelegate> delegate;
@property(nonatomic,assign)WLFooterViewStatus status;
-(void)stopAnimation;
+(id)footerView;
-(void)setTitle:(NSString *)title forState:(WLFooterViewStatus)status;
@end
