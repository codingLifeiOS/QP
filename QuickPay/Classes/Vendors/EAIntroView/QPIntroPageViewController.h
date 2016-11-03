//
//  WBIntroPageViewController.h
//  EnterpriseMicroBlog
//
//  Created by liyang on 14-3-26.
//  Copyright (c) 2014年 Enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXIntroPageViewControllerDelegate <NSObject>

@optional
- (void)introDidFinish;

@end

@interface QPIntroPageViewController : UIViewController

@property (nonatomic, weak) id<MXIntroPageViewControllerDelegate> delegate;

@end
