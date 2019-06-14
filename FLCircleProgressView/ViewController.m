//
//  ViewController.m
//  FLCircleProgressView
//
//  Created by RomanticEncounter on 2019/6/14.
//  Copyright © 2019 FJL. All rights reserved.
//

#import "ViewController.h"
#import "FLCircleProgressView.h"

@interface ViewController ()
@property (nonatomic, strong) FLCircleProgressView *circleProgressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FLCircleProgressView *circleProgressView = [[FLCircleProgressView alloc] init];
    circleProgressView.frame = CGRectMake(CGRectGetWidth(self.view.frame) * 0.5 - 100.0, CGRectGetHeight(self.view.frame) * 0.5 - 100.0, 200.0, 200.0);
    circleProgressView.backgroundColor = [UIColor whiteColor];
    circleProgressView.progressColor = [UIColor orangeColor];
    circleProgressView.contentTextFont = [UIFont systemFontOfSize:18.0];
    circleProgressView.contentText = @"80℉";
    circleProgressView.progress = 0.8;
    [self.view addSubview:circleProgressView];
    
    self.circleProgressView = circleProgressView;
    
    UIButton *changeValueButton = [UIButton buttonWithType:UIButtonTypeSystem];
    changeValueButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) * 0.5 - 150.0, CGRectGetHeight(self.view.frame) * 0.5 - 150.0, 300.0, 30.0);
    [changeValueButton setTitle:@"Random Change Progress Value" forState:UIControlStateNormal];
    [changeValueButton addTarget:self action:@selector(changeValueButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeValueButton];
}

- (void)changeValueButton:(UIButton *)sender {
    float randomVlaue = (float)(arc4random() % 100) / 100.0;
    self.circleProgressView.progress = randomVlaue;
    self.circleProgressView.contentText = [NSString stringWithFormat:@"%.2f℉",randomVlaue * 100];
}


@end
