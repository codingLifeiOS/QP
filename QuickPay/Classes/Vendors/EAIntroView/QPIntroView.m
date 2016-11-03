//
//  QPIntroView.m
//  QuickPay
//
//  Created by Nie on 16/9/23.
//  Copyright © 2016年 Nie All rights reserved.
//

#import "QPIntroView.h"
#import "EAIntroView.h"

@interface QPIntroView () <EAIntroDelegate> {
    EAIntroView *_introPage;
    QPIntroView *_QPIntroView;
}

@end

@implementation QPIntroView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return self;
}

- (void)showFreshGuideInView:(UIView*)view
{
    _QPIntroView = [self init];
    
    NSMutableArray *introViewArray = [NSMutableArray array];
    
    for (int i = 0; i < 4; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"intro_bg_0%d_%.0f",i + 1,SCREEN_HEIGHT * 2];
        UIView *view = [self pageViewWithImageView:imageName];
        if (3 == i) {
            [self addSkipButtonInView:view];
        }
        EAIntroPage *page = [self introPageWithView:view];
        [introViewArray addObject:page];
    }
    
    
    _introPage = [[EAIntroView alloc] initWithFrame:view.frame andPages:introViewArray];
    _introPage.backgroundColor = [UIColor whiteColor];
    _introPage.swipeToExit = YES;
    _introPage.skipButton.hidden = YES;
    _introPage.easeOutCrossDisolves= YES;
    _introPage.hideOffscreenPages = YES;
    _introPage.scrollView.backgroundColor = [UIColor clearColor];
    [_introPage setDelegate:self];
    
    
    _introPage.pageControl.hidden = NO;
    _introPage.pageControl.currentPageIndicatorTintColor = UIColorFromHex(0xffb155);
    _introPage.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:176/255.0 blue:94/255.0 alpha:0.4];
    _introPage.pageControl.numberOfPages = 3;
    
    _introPage.pageControl.top = SCREEN_HEIGHT - 50;
    _introPage.pageControl.centerX = view.centerX;
    
    [_introPage showInView:view animateDuration:0];
    
    
}

#pragma mark - EAIntroDelegate
- (void)intro:(EAIntroView *)introView pageEndScrolling:(EAIntroPage *)page withIndex:(NSUInteger)pageIndex
{
    introView.pageControl.currentPage = pageIndex;
    if (pageIndex == 3) {
        introView.pageControl.hidden = YES;
    }else{
        introView.pageControl.hidden = NO;
    }
}

#pragma mark - private methods
- (UIView *)pageViewWithImageView:(NSString *)imageName {
    UIView *view = [[UIView alloc]initWithFrame:self.frame];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.frame];
    [imageView setImage:[UIImage imageNamed:imageName]];
    [view addSubview:imageView];
    return view;
}

- (EAIntroPage *)introPageWithView:(UIView *)view {
    EAIntroPage *page = [EAIntroPage page];
    page.customView = view;
    return page;
}

- (void)addSkipButtonInView:(UIView *)view {
    int margin = 60;
    int x = (SCREEN_WIDTH - 318/2) /2;
    int y = SCREEN_HEIGHT - margin - 34;
    UIButton *skipButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 318/2, 47)];
    [skipButton setAutoresizingMask: UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    [skipButton setBackgroundColor:view.backgroundColor];
    [skipButton.layer setMasksToBounds:YES];
    [skipButton.layer setCornerRadius:16.0f];
    skipButton.layer.borderColor = UIColorFromHex(0xffb155).CGColor;
    skipButton.layer.borderWidth = 1.0f;
    [skipButton setTitle:@"立即体验" forState:UIControlStateNormal];
    [skipButton setTitleColor:UIColorFromHex(0xffb155) forState:UIControlStateNormal];
    skipButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];

    [view addSubview:skipButton];
    
    [skipButton bk_addEventHandler:^(id sender) {
        [_introPage hideWithFadeOutDuration:0.3];
    } forControlEvents:UIControlEventTouchUpInside];
}

@end
