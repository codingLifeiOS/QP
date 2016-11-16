//
//  QPCerPickView.h
//  QuickPay
//
//  Created by Nie on 2016/11/16.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ClickType){
    isCancel = 100,//点击取消
    isClick,//点击确定
};
@protocol QPCerPickViewDelegate;
@interface QPCerPickView : UIView
@property(nonatomic,assign)id<QPCerPickViewDelegate>delegate;
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)UIPickerView *picView;
@end
@protocol QPCerPickViewDelegate <NSObject>

-(void)clickType:(ClickType)type andClikString:(NSInteger )index;

@end
