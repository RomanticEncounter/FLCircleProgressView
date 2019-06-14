//
//  FLCircleProgressView.h
//  FLCircleProgressView
//
//  Created by RomanticEncounter on 2019/6/14.
//  Copyright © 2019 FJL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLCircleProgressView : UIView

/**
 导轨背景色
 */
@property (nonatomic, strong) UIColor *trackColor;

/**
 线条宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 进度条颜色
 */
@property (nonatomic, strong) UIColor *progressColor;

/**
 进度条类型
 */
@property (nonatomic, copy) CAShapeLayerLineCap progressLineCap;

/**
 进度
 */
@property (nonatomic, assign) CGFloat progress;

/**
 内容
 */
@property (nonatomic, strong) NSString *contentText;

/**
 文字颜色
 */
@property (nonatomic, strong) UIColor *contentTextColor;

/**
 字体大小
 */
@property (nonatomic, strong) UIFont *contentTextFont;

@end

NS_ASSUME_NONNULL_END
