//
//  NYSForgetPasswordViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSForgetPasswordViewController.h"

@interface NYSForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UIButton *close;
@property (weak, nonatomic) IBOutlet UIView *getCodeView;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
- (IBAction)getCodeButtonClicked:(id)sender;
- (IBAction)closeBtnClicked:(id)sender;
- (IBAction)resetButtonClicked:(id)sender;

@end

@implementation NYSForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.close.layer.cornerRadius = 15;
    self.getCodeView.layer.cornerRadius = 7;
}

- (IBAction)getCodeButtonClicked:(id)sender {
}

- (IBAction)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)resetButtonClicked:(id)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
