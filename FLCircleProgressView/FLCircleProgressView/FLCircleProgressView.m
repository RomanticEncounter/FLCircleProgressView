//
//  FLCircleProgressView.m
//  FLCircleProgressView
//
//  Created by RomanticEncounter on 2019/6/14.
//  Copyright © 2019 FJL. All rights reserved.
//

#import "FLCircleProgressView.h"
//category
#import "NSString+FLTextSize.h"
#import "UIView+FLFrame.h"

@interface FLCircleProgressView ()

@property (nonatomic, strong) CAShapeLayer *circleBackgroundLayer;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) CATextLayer *contentTextLayer;

@property (nonatomic, assign) CGFloat cornerRadius;

@end

@implementation FLCircleProgressView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _trackColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        _lineWidth = 10.0;
        _progressColor = [UIColor grayColor];
        _progressLineCap = kCALineCapRound;
        _contentTextColor = [UIColor lightGrayColor];
        _contentTextFont = [UIFont systemFontOfSize:13];
        _contentText = @"10人";
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cornerRadius = 0.0;
    self.cornerRadius = MIN(self.fl_width, self.fl_height) * 0.5 - self.lineWidth * 0.5;
//    if (CGRectGetHeight(self.frame) > CGRectGetWidth(self.frame)) {
//        self.cornerRadius = CGRectGetWidth(self.frame) * 0.5 - self.lineWidth;
//    } else {
//        self.cornerRadius = CGRectGetHeight(self.frame) * 0.5 - self.lineWidth;
//    }
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    [super drawLayer:layer inContext:ctx];
    [self fl_drawCircleBackgroundLayer];
    [self fl_drawProgressLayer];
    [self fl_drawContentTextLayer];
}

- (void)fl_drawCircleBackgroundLayer {
    //从 π/2 开始绘制一个圆形导轨
    CGPoint center = CGPointMake(self.fl_width * 0.5, self.fl_height * 0.5);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 2 endAngle:2 * M_PI + M_PI / 2 clockwise:YES];
    self.circleBackgroundLayer.path = circlePath.CGPath;
    
    [self.layer addSublayer:self.circleBackgroundLayer];
}

- (void)fl_drawProgressLayer {
    //从 π/2 开始绘制一个进度
    CGPoint center = CGPointMake(self.fl_width * 0.5, self.fl_height * 0.5);
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 2 endAngle:2 * M_PI + M_PI / 2 clockwise:YES];
    
    self.progressLayer.path = progressPath.CGPath;
    self.progressLayer.strokeStart = 0.0;
    self.progressLayer.strokeEnd = self.progress;
    
    [self.circleBackgroundLayer addSublayer:self.progressLayer];
}

- (void)fl_drawContentTextLayer {
    //文字大小
    CGSize textSize = [self.contentText fl_sizeForFont:self.contentTextFont];
    CGPoint center = CGPointMake(self.fl_width * 0.5, self.fl_height * 0.5);
    //增加对文字最大宽度的约束
    CGFloat textWidth = MIN(textSize.width, self.fl_width - 2 * self.lineWidth);
    CGRect textFrame = CGRectMake(center.x - textWidth * 0.5, center.y - textSize.height * 0.5, textWidth, textSize.height);
    self.contentTextLayer.frame = textFrame;
    //    self.contentTextLayer.string = self.contentText;
    [self.layer addSublayer:self.contentTextLayer];
}


#pragma mark - Setter

- (void)setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    self.circleBackgroundLayer.strokeColor = trackColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.circleBackgroundLayer.lineWidth = lineWidth;
    self.progressLayer.lineWidth = lineWidth;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.progressLayer.strokeEnd = progress;
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgressLineCap:(CAShapeLayerLineCap)progressLineCap {
    _progressLineCap = progressLineCap;
    self.progressLayer.lineCap = progressLineCap;
}

- (void)setContentText:(NSString *)contentText {
    _contentText = contentText;
    //重新计算文字大小
    CGSize textSize = [contentText fl_sizeForFont:self.contentTextFont];
    CGPoint center = CGPointMake(self.fl_width * 0.5, self.fl_height * 0.5);
    CGFloat textWidth = MIN(textSize.width, self.fl_width - 2 * self.lineWidth);
    CGRect textFrame = CGRectMake(center.x - textWidth * 0.5, center.y - textSize.height * 0.5, textWidth, textSize.height);
    self.contentTextLayer.frame = textFrame;
    self.contentTextLayer.string = contentText;
}

- (void)setContentTextFont:(UIFont *)contentTextFont {
    _contentTextFont = contentTextFont;
    self.contentTextLayer.fontSize = contentTextFont.pointSize;
}

- (void)setContentTextColor:(UIColor *)contentTextColor {
    _contentTextColor = contentTextColor;
    self.contentTextLayer.foregroundColor = contentTextColor.CGColor;
}



#pragma mark - lazy load.

- (CAShapeLayer *)circleBackgroundLayer {
    if (!_circleBackgroundLayer) {
        _circleBackgroundLayer = [CAShapeLayer layer];
        _circleBackgroundLayer.lineWidth = self.lineWidth;
        _circleBackgroundLayer.strokeColor = self.trackColor.CGColor;
        _circleBackgroundLayer.fillColor = [UIColor clearColor].CGColor;
        _circleBackgroundLayer.lineCap = kCALineCapButt;
    }
    return _circleBackgroundLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.lineWidth = self.lineWidth;
        _progressLayer.strokeColor = self.progressColor.CGColor;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineCap = self.progressLineCap;
    }
    return _progressLayer;
}

- (CATextLayer *)contentTextLayer {
    if (!_contentTextLayer) {
        //初始化一个CATextLayer
        _contentTextLayer = [CATextLayer layer];
        //设置文字大小
        _contentTextLayer.fontSize = self.contentTextFont.pointSize;
        //设置文字颜色
        _contentTextLayer.foregroundColor = self.contentTextColor.CGColor;
        //设置对齐方式
        _contentTextLayer.alignmentMode = kCAAlignmentCenter;
        //设置分辨率
        _contentTextLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _contentTextLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
