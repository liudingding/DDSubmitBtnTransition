//
//  AnimatedTransition.m
//  sumbitButton
//
//  Created by kongxc on 15/11/12.
//  Copyright © 2015年 kongxc. All rights reserved.
//

#import "AnimatedTransition.h"

@interface AnimatedTransition ()

@property (nonatomic , assign)NSTimeInterval duration;
@property (nonatomic , assign)CGFloat startAngle;
@end


@implementation AnimatedTransition

- (instancetype)initWithDuration:(NSTimeInterval) duration startAngle:(CGFloat)startAngle
{
    self = [super init];
    if (self) {
     
        self.duration = duration;
        self.startAngle = startAngle;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *contView = [transitionContext containerView];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    toView.alpha = self.startAngle;
    fromView.alpha = 0.8;
    
    
    [contView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
       
        toView.alpha = 1.0;
        fromView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            fromView.alpha = 1.0;
            [transitionContext completeTransition:YES];
        }
        
    }];
    
}
@end
