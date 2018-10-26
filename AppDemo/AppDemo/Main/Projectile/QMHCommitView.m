//
//  QMHCommitSuccessView.m
//  安居公社
//
//  Created by 倪刚 on 2018/4/28.
//  Copyright © 2018年 QingMai. All rights reserved.
//

#import "QMHCommitView.h"

@interface QMHCommitView ()
@property (weak, nonatomic) IBOutlet UIView *popUPView;
@property (weak, nonatomic) IBOutlet UILabel *popTitle;
@property (weak, nonatomic) IBOutlet UILabel *popMessages;
@property (weak, nonatomic) IBOutlet UILabel *sucessTitle;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;

- (IBAction)closeButton:(id)sender;

@end

@implementation QMHCommitView
- (void)awakeFromNib {
    [super awakeFromNib];
    // 灰色遮罩
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.popUPView.layer.cornerRadius = 15.f;
    self.popUPView.clipsToBounds = YES;
}

- (void)setTitleString:(NSString *)popTitle SubtitleString:(NSString *)subtitle popMessagesString:(NSString *)msg statusImageNamed:(NSString *)statusImage {
    self.statusImage.image = [UIImage imageNamed:statusImage];
    self.popTitle.text = popTitle;
    self.sucessTitle.text = subtitle;
    self.popMessages.text = msg;
}

- (IBAction)closeButton:(id)sender {
    [self removeFromSuperview];
}
@end
