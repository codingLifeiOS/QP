//
//  QPVoiceBroadcast.h
//  QuickPay
//
//  Created by Nie on 2016/12/5.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface QPVoiceBroadcast : NSObject
{
    NSMutableDictionary* soundSet;  //声音设置
    NSString* path;  //配置文件路径
}
@property(nonatomic,assign)float rate;   //语速
@property(nonatomic,assign)float volume; //音量
@property(nonatomic,assign)float pitchMultiplier;  //音调
@property(nonatomic,assign)BOOL autoPlay;  //自动播放

+(QPVoiceBroadcast*)soundPlayerInstance;

-(void)play:(NSString*)text;

-(void)setDefault;

-(void)writeSoundSet;

@end
