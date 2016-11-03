//
//  QPActionSheet.h
//  QuickPay
//
//  Created by Nie on 15/8/10.
//  Copyright (c) 2015年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QPActionSheet : UIView

- (instancetype)initWithTitle:(NSString *)title delegate:(id/**<>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles otherButtonKeys:(NSArray *)otherButtonKeys;

- (void)show;

@property (nonatomic, weak) id/**<>*/ delegate;

@property (nonatomic, strong ,readonly) NSArray *titlesArray;
@property (nonatomic, strong ,readonly) NSArray *keysArray;

@property (nonatomic, copy ,readonly) NSString *actionSheetTitle;
@property (nonatomic, copy ,readonly) NSString *cancelButtonTitle;

@property (nonatomic, strong) id customInfo;

@end

@protocol QPActionSheetDelegate <NSObject>

- (void)QPActionSheet:(QPActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex clickedButtonTitle:(NSString *)title clickedButtonKey:(NSString *)key;

@end
