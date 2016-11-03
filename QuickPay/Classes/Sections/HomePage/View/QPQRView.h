//
//  QPQRView.h
//  QPQuickPay
//
//  Created by Nie on 16/6/28.
//  Copyright © 2016年 Nie. All rights reserved.//

#import <UIKit/UIKit.h>

@interface QPQRView : UIView

/**
 *  透明区域
 */
@property (nonatomic, assign) CGSize transparentArea;

- (void)startScan;
- (void)stopScan;

@end
