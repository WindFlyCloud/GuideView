//
//  GuideView.h
//  ScanCode
//
//  Created by caoxu on 16/6/23.
//  Copyright © 2016年 cloudssky. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GuideViewDelegate;

@interface GuideView : UIView

{
@private
    NSInteger   _currentPage;
    NSInteger   _numberOfPages;
    UIColor     *dotColorCurrentPage;
    UIColor     *dotColorOtherPage;
    NSObject<GuideViewDelegate> *delegate;
}
/**
 currentPage:设置当前的page
 numberOfPages:设置总的pages
 */
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger numberOfPages;

/**
 dotColorCurrentPage:设置当前点的颜色
 dotColorOtherPage:设置其他点的颜色
 */
@property (nonatomic, retain) UIColor *dotColorCurrentPage;
@property (nonatomic, retain) UIColor *dotColorOtherPage;

/**
 delegate:代理，可选的。
 当user设置的时候，点击小点的时候，会产生回调
 */
@property (nonatomic, strong) NSObject<GuideViewDelegate> *delegate;

@end

@protocol GuideViewDelegate <NSObject>
@optional
- (void)guideViewPageDidChange:(GuideView *)guideView;

@end

