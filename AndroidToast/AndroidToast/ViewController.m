//
//  ViewController.m
//  AndroidToast
//
//  Created by MyMac on 15/9/22.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "ViewController.h"
#import "Toast.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic,strong) UIButton *showBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.showBtn];
    
}

- (void)showClick{
//    Toast *toast = [Toast toastWithText:@"代颜网代颜网代颜网代颜网代颜网代颜];
    Toast *toast = [Toast toastWithText:@"代颜网代颜网代颜网代颜网代颜网代颜" backgroundColor:[UIColor blueColor] alpha:0.3f];
    [toast showInView:self.view showType:ToastShowTop];
    
}

- (UIButton *)showBtn{
    if (!_showBtn) {
        _showBtn = [[UIButton alloc] init];
        [_showBtn setTitle:@"show" forState:UIControlStateNormal];
        _showBtn.backgroundColor = [UIColor blueColor];
        [_showBtn addTarget:self action:@selector(showClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@30);
    }];
    
}


@end
