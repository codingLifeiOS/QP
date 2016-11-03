//
//  UITableView+RightIndex.m
//  QuickPay
//
//  Created by 周卫斌 on 15/8/6.
//  Copyright (c) 2015年 Nie. All rights reserved.
//

#import "UITableView+RightIndex.h"
#define kRIGHEIGHTSCALE  (([UIScreen mainScreen].bounds.size.height) / 667.0)

@implementation UITableView (RightIndex)

- (void)creatRightIndexBy:(NSMutableArray *)sectionHeadArr View:(UIView *)view
{
    [[NSUserDefaults standardUserDefaults] setObject:sectionHeadArr forKey:kRightIndex];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSInteger count = sectionHeadArr.count;
    UIPanGestureRecognizer *ges = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageView:)];
    UITapGestureRecognizer *ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageView:)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    float radius = 30 / 2.0;
    imageView.backgroundColor = UIColorFromHex(0xfdfdfd);
    imageView.alpha = 0.8;
    imageView.userInteractionEnabled = YES;
    imageView.layer.cornerRadius = radius;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 0.5;
    imageView.layer.borderColor = [UIColorFromHex(0x47d9bf) CGColor];
    
    imageView.tag = 10086;
    imageView.userInteractionEnabled = YES;
    imageView.frame = CGRectMake(SCREEN_WIDTH - 40, 0, 30, count * 20 * kRIGHEIGHTSCALE + 10);
    imageView.center = CGPointMake(imageView.center.x, self.center.y);
    [imageView addGestureRecognizer:ges];
    [imageView addGestureRecognizer:ges1];
    [view addSubview:imageView];
    for (int i = 0 ; i < count; i++) {
        UILabel *button = [[UILabel alloc] init];
        button.backgroundColor = [UIColor clearColor];
        button.tag = 100 + i;
        button.frame =CGRectMake(5, 5 + 20 * i * kRIGHEIGHTSCALE, 20 * kRIGHEIGHTSCALE, 15);
        button.textAlignment = NSTextAlignmentCenter;
        button.text = [sectionHeadArr objectAtIndex:i];
        button.font= [UIFont systemFontOfSize:12];
        button.textColor = UIColorFromHex(0x555555);
        [imageView addSubview:button];
        
    }
}

- (void)handleImageView:(UIGestureRecognizer *)gesture
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *sectionHeadKey = (NSArray *)[defaults objectForKey:kRightIndex];
    
    static NSInteger currentIndex = -1;
    UIImageView *imageView = (UIImageView *)gesture.view;
    UIView *subview = imageView.superview;
    UIImageView *smallImage = (UIImageView *)[subview viewWithTag:12345];
    if (gesture.state == UIGestureRecognizerStateEnded){
        [smallImage performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
    }
    
    CGPoint point = [gesture locationInView:imageView];
    NSInteger tag = (point.y - 5) / (20 * kRIGHEIGHTSCALE);
    if (tag > sectionHeadKey.count - 1 || tag < 0) {
        return;
    }
    if (currentIndex == tag) {
        return;
    } else {
        UILabel *button = (UILabel *)[imageView viewWithTag:100 + currentIndex];
        UILabel *button1 = (UILabel *)[imageView viewWithTag:100 + tag];
        button1.textColor = UIColorFromHex(0x3fddd4);
        button.textColor = UIColorFromHex(0x555555);
        currentIndex = tag;
    }
    
    UILabel *button = (UILabel *)[imageView viewWithTag:100 + tag];
    NSString *title = [sectionHeadKey objectAtIndex:tag];
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    if (!smallImage) {
      UIImageView *imagesubview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wuba_mis_fangchan_xzlxr_02"]];
        imagesubview.tag = 12345;
        imagesubview.frame = CGRectMake(SCREEN_WIDTH - 40 - 78, button.frame.origin.y + imageView.frame.origin.y - 15, 52, 44);
        [subview addSubview:imagesubview];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, 20, 20)];
        label.text = title;
        label.textColor = UIColorFromHex(0x3fddd4);
        label.tag = 10011;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        [imagesubview addSubview:label];
        
    } else {
        [UIView animateWithDuration:0.1 animations:^{
            UILabel *label = (UILabel *)[smallImage viewWithTag:10011];
            UIImageView *imagesubview = (UIImageView *)[subview viewWithTag:12345];
            imagesubview.frame = CGRectMake(SCREEN_WIDTH - 40 - 78, button.frame.origin.y + imageView.frame.origin.y - 15, 52, 44);
            label.text = title;
        }];
        
    }
    
    UIImageView *smallImage1 = (UIImageView *)[subview viewWithTag:12345];

    if ([gesture isMemberOfClass:[UITapGestureRecognizer class]]){
        [smallImage1 performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
    }
    
}

@end
