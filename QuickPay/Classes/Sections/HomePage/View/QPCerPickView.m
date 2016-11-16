//
//  QPCerPickView.m
//  QuickPay
//
//  Created by Nie on 2016/11/16.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPCerPickView.h"
@interface QPCerPickView ()<UIPickerViewDataSource,UIPickerViewDelegate> {
    UIView *itemView;
    NSInteger selectIndex;
}
@end
@implementation QPCerPickView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubview:[self customtabarView]];
        self.picView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-44)];
        _picView.delegate = self;
        _picView.dataSource = self;
        [self addSubview:_picView];
        selectIndex = 0;
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArr.count;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    if (view) {
        UILabel *label = (UILabel *)view;
        [label setHighlighted:NO];
        label.text = [self.dataArr objectAtIndex:row];
        return label;
    } else {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(pickerView.frame), 22)];
        lable.backgroundColor = [UIColor clearColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor =UIColorFromHex(0x9f9f9f);
        lable.highlightedTextColor = UIColorFromHex(0x323232);
        lable.text = [self.dataArr objectAtIndex:row];
        lable.tag = 10;
        [lable setHighlighted:NO];
        return lable;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    UILabel *view = (UILabel *)[pickerView viewForRow:row forComponent:component];
    [view setHighlighted:YES];
    selectIndex = row;
}


-(UIView *)customtabarView {
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 44)];
    itemView.userInteractionEnabled = YES;
    itemView.layer.shadowColor = [UIColor blackColor].CGColor;
    UIView *lineUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), .5)];
    lineUp.backgroundColor = UIColorFromHex(0xe1e1e1);
    [itemView addSubview:lineUp];
    
    
    for (int i = 0; i < 2; i++) {
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemBtn addTarget:self action:@selector(clikIndex:) forControlEvents:UIControlEventTouchUpInside];
        //        [itemBtn setImage:[UIImage imageNamed:@"58_shuaidan_no"] forState:UIControlStateNormal];
        [itemBtn setTitle:@"取消" forState:UIControlStateNormal];
        [itemBtn setTitleColor: UIColorFromHex(0x3d9add) forState:UIControlStateNormal];
        itemBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        if (i == 1) {
            //            [itemBtn setImage:[UIImage imageNamed:@"58_shuaidan_ok"] forState:UIControlStateNormal];
            [itemBtn setTitle:@"确定" forState:UIControlStateNormal];
            [itemBtn setTitleColor: UIColorFromHex(0x3d9add) forState:UIControlStateNormal];
            itemBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];             itemBtn.frame = CGRectMake(CGRectGetWidth(itemView.frame)-40-10,12, 40, 20);
            
        } else {
            itemBtn.frame = CGRectMake(10,8, 60, 30);
        }
        
        itemBtn.tag = 100+i;
        itemBtn.userInteractionEnabled = YES;
        //        itemBtn.backgroundColor=[UIColor grayColor];
        [itemView addSubview:itemBtn];
        
    }
    
    UIView *lineDown = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(itemView.frame)-.5, CGRectGetWidth(self.frame), .5)];
    lineDown.backgroundColor = UIColorFromHex(0xe1e1e1);
    [itemView addSubview:lineDown];
    return itemView;
}

-(void)clikIndex:(UIButton *)sender {
    ClickType type = sender.tag;
    if ([self.delegate respondsToSelector:@selector(clickType:andClikString:)]) {
        [self.delegate clickType:type andClikString:selectIndex];
    }
}

@end
