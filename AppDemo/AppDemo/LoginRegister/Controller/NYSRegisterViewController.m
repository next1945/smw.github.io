//
//  NYSRegisterViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSRegisterViewController.h"

@interface NYSRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *close;
@property (weak, nonatomic) IBOutlet UIView *getCodeView;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
- (IBAction)closeBtnClicked:(id)sender;
- (IBAction)getCodeButtonClicked:(id)sender;
- (IBAction)registerButtonClicked:(id)sender;

@end

@implementation NYSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.close.layer.cornerRadius = 15;
    self.getCodeView.layer.cornerRadius = 7;
}

- (IBAction)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)getCodeButtonClicked:(id)sender {
}

- (IBAction)registerButtonClicked:(id)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
