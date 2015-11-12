//
//  sumbitButtom.m
//  sumbitButton
//
//  Created by kongxc on 15/10/19.
//  Copyright © 2015年 kongxc. All rights reserved.
//

#import "DDSubmitButtom.h"

@interface DDSubmitButton ()

@property (nonatomic , assign)CGFloat progressBarHeight;
@property (nonatomic , assign)CGFloat progressBarweight;
@property (nonatomic , strong)CAShapeLayer *checkLayer;
@property (nonatomic , strong)CAShapeLayer *spinerLayer;
@end

@implementation DDSubmitButton
{
    BOOL isAnimation;
    CGRect originFrame;
}
#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame completion:(DDSubmitButtonClicked)buttonClicked
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self doSomething];
        self.buttonClicked = buttonClicked;
    }
    return self;
}
- (void)doSomething
{
    self.progressBarHeight = self.frame.size.height;
    self.progressBarweight = self.frame.size.width;
    self.layer.cornerRadius = self.progressBarHeight/2;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tap];
}
- (void)tapped:(UITapGestureRecognizer *)tap
{
    originFrame = self.frame;
    
    if (isAnimation ) {
        return;
    }
    
    for (CALayer *layer in self.layer.sublayers) {
        
        [layer removeFromSuperlayer];
    }
    
    isAnimation = YES;
    
    self.layer.cornerRadius = self.progressBarHeight/2;
    CABasicAnimation *widthAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    widthAnimation.duration = 0.5f;
    widthAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    widthAnimation.fromValue =  @(originFrame.size.height/2);
    
    widthAnimation.delegate = self;
    [self.layer addAnimation:widthAnimation forKey:@"widthAnimation"];
    
}
- (void)animationDidStart:(CAAnimation *)anim
{
    if ([anim isEqual:[self.layer animationForKey:@"widthAnimation"]]) {
        
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.bounds = CGRectMake(0, 0, originFrame.size.height, originFrame.size.height);
      
        } completion:^(BOOL finished) {
            
            [self.layer removeAllAnimations];
            [self spinerAnimation];
        }];
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isEqual:[self.layer animationForKey:@"spinerAnimation"]]) {
        
        [self.layer removeAllAnimations];
        self.spinerLayer.hidden = YES;
        [self scaleAnimation];
        
    }else if ([anim isEqual:[self.layer animationForKey:@"checkAnimation"]]){
        
        isAnimation = NO;
    }else if ([anim isEqual:[self.layer animationForKey:@"scaleAnimation"]]){
        self.buttonClicked();
    }
}
- (void)spinerAnimation
{
    CAShapeLayer *spinerLayer = [CAShapeLayer layer];
    self.spinerLayer = spinerLayer;
    
    CGFloat radius = self.progressBarHeight/3;
    CGPoint center = CGPointMake(self.progressBarHeight/2, self.progressBarHeight/2);
    CGFloat stangAngle = 0 - M_2_PI;
    CGFloat endAngle = M_PI * 2 - M_PI_2;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:stangAngle endAngle:endAngle clockwise:YES];
    spinerLayer.path = path.CGPath;
    spinerLayer.fillColor = [UIColor clearColor].CGColor;
    spinerLayer.strokeColor = [UIColor whiteColor].CGColor;
    spinerLayer.lineWidth = 1.0;
    spinerLayer.strokeEnd = 0.3;
    spinerLayer.lineCap = kCALineCapRound;
    spinerLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:spinerLayer];
    [path closePath];
    
    CABasicAnimation *spinerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    spinerAnimation.fromValue = @(0);
    spinerAnimation.toValue = @(M_PI * 2);
    spinerAnimation.duration = 0.4;
    spinerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    spinerAnimation.repeatCount = 4;
    spinerAnimation.fillMode = kCAFillModeForwards;
    spinerAnimation.removedOnCompletion = NO;
    spinerAnimation.delegate = self;
    
    [self.layer addAnimation:spinerAnimation forKey:@"spinerAnimation"];
    
    
}
- (void)scaleAnimation
{
    CABasicAnimation* scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(1);
    scaleAnimation.toValue =@(26);
    scaleAnimation.timingFunction =  [CAMediaTimingFunction functionWithControlPoints:0.95 :0.02 :1 :0.05];
    scaleAnimation.duration = 0.3f;
    scaleAnimation.delegate = self;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
   
}
- (void)progressAnimation
{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    self.checkLayer = layer;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGRect rectCirle = CGRectInset(self.bounds, self.frame.size.width * 0.15, self.frame.size.height * 0.15);
    [path moveToPoint:CGPointMake(rectCirle.origin.x + rectCirle.size.width *0.1, rectCirle.origin.y + rectCirle.size.height *0.5)];
    
    [path addLineToPoint:CGPointMake(rectCirle.origin.x + rectCirle.size.width * 0.35, rectCirle.origin.y + rectCirle.size.height *0.8)];
    [path addLineToPoint:CGPointMake(rectCirle.origin.x + rectCirle.size.width *0.86, rectCirle.origin.y + rectCirle.size.height * 0.2)];

    
    layer.path = path.CGPath;
    
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 5.0f;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:layer];
     [path closePath];
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 1.0f;
    checkAnimation.fromValue = @(0.0);
    checkAnimation.toValue = @(1.0);
    checkAnimation.delegate = self;
    [layer addAnimation:checkAnimation forKey:@"checkAnimation"];
    
}
@end
