//
//  LeadScrollView.m
//  ScanCode
//
//  Created by caoxu on 16/6/23.
//  Copyright © 2016年 cloudssky. All rights reserved.
//

#import "LeadScrollView.h"

#import "GuideView.h"

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//页数
#define PAGENUMBER 5
@interface LeadScrollView ()
{
    GuideView * guideView;
}
@end
@implementation LeadScrollView

-(instancetype)init {
    if (self = [super init]) {
        //设置整页滑动
        self.pagingEnabled = YES;
        //取消弹性
        self.bounces = NO;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
//        self.userInteractionEnabled = YES;
        [self createScrollView];
    }
    return self;
}

- (void)createScrollView {
    UIWindow * window = [[UIApplication sharedApplication] delegate].window;
    self.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
    self.contentSize = CGSizeMake(CGRectGetWidth(window.frame)*PAGENUMBER, CGRectGetHeight(window.frame));
    
    for (int i = 0; i < PAGENUMBER; i ++) {
        [self addSubview:[self addSubviewImage:[NSString stringWithFormat:@"loading%d",i+1] rect:CGRectMake(CGRectGetWidth(window.frame) *i, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame))]];
    }
    for (int i = 0; i < PAGENUMBER-1; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*CGRectGetWidth(window.frame)+(CGRectGetWidth(window.frame)-54)/2, CGRectGetHeight(window.frame)-80, 54, 54);
        button.tag = i+1;
        [button setImage:[[UIImage imageNamed:@"loading_btn_n"] stretchableImageWithLeftCapWidth:20 topCapHeight:20] forState:UIControlStateNormal];
        [button setImage:[[UIImage imageNamed:@"loading_btn_s"]stretchableImageWithLeftCapWidth:20 topCapHeight:20] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    [self showButton:window];
    
    guideView = [[GuideView alloc]initWithFrame:CGRectMake(0, 0, 90, 20)];
    guideView.dotColorCurrentPage = [UIColor redColor];
    guideView.center = CGPointMake(CGRectGetWidth(window.frame)/2, CGRectGetHeight(window.frame) -20);
    guideView.numberOfPages  = PAGENUMBER;
    [self addSubview:guideView];

}
- (void) buttonClick:(UIButton *)btn {
    [self setContentOffset:CGPointMake(btn.tag * SCREEN_WIDTH, 0) animated:YES];
}
- (UIImageView *)addSubviewImage:(NSString *)imageName rect:(CGRect )rect {
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255. blue:arc4random()%255/255. alpha:1.0];
    imageView.frame = rect;
    return imageView;
}
- (void)showButton:(UIWindow *)window {
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetWidth(window.frame)*(PAGENUMBER-1)+105,CGRectGetHeight(window.frame)-70, CGRectGetWidth(window.frame) -100*2,67/2);
    //    [button setBackgroundImage:[UIImage imageNamed:@"helpBtn.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hiddenScroller:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"loading_btn_x_n"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"loading_btn_x_s"] forState:UIControlStateHighlighted];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [self addSubview:button];
}

-(void)hiddenScroller:(id)sender
{
    
    
    
    [UIView animateWithDuration:2.0
                     animations:^{
                         self.hidden = YES;
                         guideView.hidden = YES;
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
}
#pragma mark --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    NSLog(@"%@---%@",NSStringFromCGPoint(offset),NSStringFromCGRect(bounds));
    [guideView setCurrentPage:offset.x /bounds.size.width];
    
}
@end
