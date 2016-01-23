//
//  Toast.h
//  仿AndroidToast
//
//  Created by MyMac on 15/9/14.
//  Copyright (c) 2015年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ToastShowType) {
    ToastShowTop,
    ToastShowCenter,
    ToastShowBottom
};

@interface Toast : UILabel

@property (nonatomic,assign) CFTimeInterval forwardAnimationDuration;

@property (nonatomic,assign) CFTimeInterval backwardAnimationDuration;

@property (nonatomic,assign) UIEdgeInsets textInsets;

@property (nonatomic,assign) CGFloat maxWidth;


+ (instancetype)toastWithText:(NSString *)text backgroundColor:(UIColor *)backgroundColor alpha:(CGFloat)alpha;

//- (instancetype)initToastWithText:(NSString *)text backgroundColor:(UIColor *)backgroundColor alpha:(CGFloat)alpha;

//- (void)showInView:(UIView *)view; //toast显示在哪个View上面

//Default is ToastShowBottom
- (void)showInView:(UIView *)view showType:(ToastShowType)type;


@end
