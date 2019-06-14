# FLCircleProgressView
A simple annulus progress widget.

一个简单的环形进度组件。

> 用UIBezierPath + CAShaperLayer绘制

![实际效果](https://upload-images.jianshu.io/upload_images/2871024-b2eda4ad9dacec56.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/240)

## 如何使用

```objc
	FLCircleProgressView *circleProgressView = [[FLCircleProgressView alloc] init];
    circleProgressView.frame = CGRectMake(CGRectGetWidth(self.view.frame) * 0.5 - 100.0, CGRectGetHeight(self.view.frame) * 0.5 - 100.0, 200.0, 200.0);
    //设置背景颜色
    circleProgressView.backgroundColor = [UIColor whiteColor];
    //设置进度条颜色
    circleProgressView.progressColor = [UIColor orangeColor];
    //设置字体大小
    circleProgressView.contentTextFont = [UIFont systemFontOfSize:18.0];
    //设置文字
    circleProgressView.contentText = @"-----------80.00℃-----------";
    //设置进度[0, 1]
    circleProgressView.progress = 0.8;
    [self.view addSubview:circleProgressView];
```

## 重新赋值

```obj
	//可直接赋值，有动画效果
	self.circleProgressView.progress = 0.5;
    self.circleProgressView.contentText = @"Test";
```
