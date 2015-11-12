//
//  sumbitButtom.h
//  sumbitButton
//
//  Created by kongxc on 15/10/19.
//  Copyright © 2015年 kongxc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DDSubmitButtonClicked)();

@interface DDSubmitButton : UIView

@property (nonatomic , strong)DDSubmitButtonClicked buttonClicked;
- (instancetype)initWithFrame:(CGRect)frame completion:(DDSubmitButtonClicked)buttonClicked;
@end
