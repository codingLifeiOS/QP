//
//  UIImage+Extension.h
//  QuickPay
//
//  Created by Nie on 16/9/7.
//  Copyright © 2016年 Nie All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

#pragma mark - 根据颜色生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - 取图片某一像素的颜色
- (UIColor *)colorAtPixel:(CGPoint)point;

#pragma mark - 获得灰度图
- (UIImage *)convertToGrayImage;


#pragma mark - 纠正图片的方向
- (UIImage *)fixOrientation;

#pragma mark - 按给定的方向旋转图片
- (UIImage*)rotate:(UIImageOrientation)orient;

#pragma mark - 垂直翻转
- (UIImage *)flipVertical;

#pragma mark - 水平翻转
- (UIImage *)flipHorizontal;

#pragma mark - 将图片旋转degrees角度
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

#pragma mark - 将图片旋转radians弧度
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;


#pragma mark - 截取当前image对象rect区域内的图像
- (UIImage *)subImageWithRect:(CGRect)rect;

#pragma mark - 压缩图片至指定尺寸
- (UIImage *)rescaleImageToSize:(CGSize)size;

#pragma mark - 压缩图片至指定像素
- (UIImage *)rescaleImageToPX:(CGFloat )toPX;

#pragma mark - 在指定的size里面生成一个平铺的图片
- (UIImage *)getTiledImageWithSize:(CGSize)size;

#pragma mark - UIView转化为UIImage
+ (UIImage *)imageFromView:(UIView *)view;

#pragma mark - 将两个图片生成一张图片
+ (UIImage*)mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;


#pragma mark - 用一个Gif生成UIImage，传入一个GIFData
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)theData;

#pragma mark - 用一个Gif生成UIImage，传入一个GIF路径 
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)theURL;

#pragma mark 修复拍照照片旋转/倒转的问题
+(UIImage *)fixOrientation:(UIImage *)aImage;

+ (UIImage *)resizableImage:(UIImage *)sourceImage;

/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage *)image byScalingToSize:(CGSize)targetSize;

@end
