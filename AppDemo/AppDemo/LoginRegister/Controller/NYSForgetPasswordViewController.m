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
- (IBAction)closeBtnClicked:(id)sender;

@end

@implementation NYSForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.close.layer.cornerRadius = 15;
}

- (IBAction)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
