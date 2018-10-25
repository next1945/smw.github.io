//
//  NYSMeTableViewCell.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSMeTableViewCell.h"
#import "NYSMeModel.h"

static NSString *ID = @"ME_CELL";

@interface NYSMeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@end

@implementation NYSMeTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NYSMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NYSMeTableViewCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

- (void)setMeCellModel:(NYSMeModel *)meCellModel
{
    _meCellModel = meCellModel;
    
    self.iconView.image = [UIImage imageNamed:meCellModel.icon];
    self.titleView.text = meCellModel.title;
}

- (void)setFrame:(CGRect)frame{
    CGRect f = frame;
    f.origin.x = 10;
    f.size.width = frame.size.width - 20;
    [super setFrame:f];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}
@end
