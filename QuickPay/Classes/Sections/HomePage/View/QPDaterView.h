//
//  QPDaterView.h
//  QuickPay
//
//  Created by Nie on 2016/11/17.
//  Copyright © 2016年 Nie. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, QPDateViewType){
    QPDateViewTypeDate = 0,//年月日
    QPDateViewTypeTime ,//时分秒
};
@class QPDaterView;

@protocol QPDaterViewDelegate <NSObject>
- (void)daterViewDidClicked:(QPDaterView *)daterView;
- (void)daterViewDidCancel:(QPDaterView *)daterView;
@end

@interface QPDaterView : UIView

@property (nonatomic, assign) id<QPDaterViewDelegate> delegate;

@property (nonatomic) QPDateViewType dateViewType;//默认类型为日期
@property (nonatomic) NSString *dateString;
@property (nonatomic) NSString *timeString;
@property (nonatomic, readonly) int year;
@property (nonatomic, readonly) int month;
@property (nonatomic, readonly) int day;
@property (nonatomic, readonly) int hour;
@property (nonatomic, readonly) int miniute;
@property (nonatomic, readonly) int second;
- (void)showInView:(UIView *)aView animated:(BOOL)animated;

- (void)setSelectYear:(int)year month:(int)month day:(int)day animated:(BOOL)animated;
- (void)setSelectHour:(int)hour miniute:(int)miniute second:(int)second animated:(BOOL)animated;

@end

@interface UIView (Category)
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat w;
@property (nonatomic,assign) CGFloat h;
@end
