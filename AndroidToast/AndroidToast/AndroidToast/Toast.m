//
//  Toast.m
//  仿AndroidToast
//
//  Created by MyMac on 15/9/14.
//  Copyright (c) 2015年 MyMac. All rights reserved.
//

#import "Toast.h"

static CFTimeInterval const kDefaultForwardAnimationDuration = 0.5;
static CFTimeInterval const kDefaultBackwardAnimationDuration = 0.5;
static CFTimeInterval const kDefaultWaitAnimationDuration = 1.0;

static CGFloat const kDefaultTopMargin = 50.0;
static CGFloat const kDefaultBottomMargin = 50.0;
static CGFloat const kDefalultTextInset = 10.0;

@implementation Toast

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.forwardAnimationDuration = kDefaultForwardAnimationDuration;
        self.backwardAnimationDuration = kDefaultBackwardAnimationDuration;
        self.textInsets = UIEdgeInsetsMake(kDefalultTextInset, kDefalultTextInset, kDefalultTextInset, kDefalultTextInset);
        self.maxWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 20.0;
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:14.0f];
    }
    return self;
}


+ (instancetype)toastWithText:(NSString *)text{
    Toast *toast = [[Toast alloc] initToastWithText:text];
    return toast;
}

- (instancetype)initToastWithText:(NSString *)text{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.text = text;
        [self sizeToFit];
    }
    return self;
}

#pragma mark - Show Methods
- (void)showInView:(UIView *)view{
    [self addAnimationGroup];
    
    CGPoint point = view.center;
    point.y = CGRectGetHeight(view.bounds) - kDefaultBottomMargin;
    self.center = point;
    [view addSubview:self];
}


- (void)showInView:(UIView *)view showType:(ToastShowType)type{
    [self addAnimationGroup];
    
    CGPoint point = view.center;
    switch (type) {
        case ToastShowTop:
            point.y = kDefaultTopMargin;
            break;
        case ToastShowBottom:
            point.y = CGRectGetHeight(view.bounds) - kDefaultBottomMargin;
            break;
            
        default:
            break;
    }
    self.center = point;
    [view addSubview:self];
    
}

#pragma mark - Animation
- (void)addAnimationGroup{
    
    CABasicAnimation *forwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forwardAnimation.duration = self.forwardAnimationDuration;
    forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.7f :0.6f :0.85f];
    forwardAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    forwardAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    CABasicAnimation *backwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    backwardAnimation.duration = self.backwardAnimationDuration;
    backwardAnimation.beginTime = forwardAnimation.duration + kDefaultWaitAnimationDuration;
    backwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.15f :0.5f :-0.7f];
    backwardAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    backwardAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[forwardAnimation,backwardAnimation];
    animationGroup.duration = forwardAnimation.duration + backwardAnimation.duration + kDefaultWaitAnimationDuration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.delegate = self;
    animationGroup.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:animationGroup forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self removeFromSuperview];
    }
}


#pragma mark - Text Configurate
- (void)sizeToFit{
    [super sizeToFit];
    
    CGRect frame = self.frame;
    CGFloat width = CGRectGetWidth(self.bounds) + self.textInsets.left + self.textInsets.right;
    frame.size.width = width > self.maxWidth ? self.maxWidth : width;
    frame.size.height = CGRectGetHeight(self.bounds) + self.textInsets.top + self.textInsets.bottom;
    self.frame = frame;
    
}

- (void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    bounds.size = [self.text boundingRectWithSize:CGSizeMake(self.maxWidth - self.textInsets.left - self.textInsets.right, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
    return bounds;
}


@end
