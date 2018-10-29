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
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 半透明遮罩
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView * effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
//        effectView.alpha = 0.95;
        effectView.frame = frame;
        UIView *nib = [[[NSBundle mainBundle] loadNibNamed:@"QMHCommitView" owner:self options:nil] lastObject];
        nib.frame = frame;
        [effectView.contentView addSubview:nib];
        [self addSubview:effectView];
    }
    return self;
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
