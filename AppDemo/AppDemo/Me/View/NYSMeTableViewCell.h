//
//  NYSMeTableViewCell.h
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NYSMeModel;

@interface NYSMeTableViewCell : UITableViewCell
/** 通过tableView创建cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NYSMeModel *meCellModel;
@end
