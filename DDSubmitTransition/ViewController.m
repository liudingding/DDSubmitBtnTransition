//
//  ViewController.m
//  sumbitButton
//
//  Created by kongxc on 15/10/19.
//  Copyright © 2015年 kongxc. All rights reserved.
//

#import "ViewController.h"
#import "DDSubmitButtom.h"
#import "AnimatedTransition.h"
#import "SecondViewController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DDSubmitButton *submitBtn = [[DDSubmitButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 250)/2, self.view.bounds.size.height - 200, 250,65) completion:^{
        
        SecondViewController*secondVC = [[SecondViewController alloc] init];
        secondVC.transitioningDelegate = self; //必须写
        [self presentViewController:secondVC animated:YES completion:nil];
        
    }];
    submitBtn.backgroundColor = [UIColor colorWithRed:245/255.0 green:38/255.0 blue:76/255.0 alpha:1];
    [self.view addSubview:submitBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[AnimatedTransition alloc] initWithDuration:0.5 startAngle:0.8];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return nil;
}
@end
