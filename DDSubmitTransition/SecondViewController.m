//
//  SecondViewController.m
//  sumbitButton
//
//  Created by kongxc on 15/11/12.
//  Copyright © 2015年 kongxc. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

- (void)viewDidLoad {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    imageView.image = [UIImage imageNamed:@"fengjing"];
    [self.view addSubview:imageView];
    
}
@end
