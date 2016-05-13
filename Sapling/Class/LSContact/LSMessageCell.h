//
//  LSMessageCell.h
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSBaseTableViewCell.h"

@interface LSMessageCell : UITableViewCell
@property (nonatomic,weak)UIImageView * iconImageView;
@property (nonatomic,weak)UILabel * nickNameLabel;
@property (nonatomic,weak)UIButton * sexButton;
@property (nonatomic,weak)UILabel * detailLabel;
@property (nonatomic,weak)UILabel * timeLabel;
@property (nonatomic,weak)UILabel * unreadLabel;
@property (nonatomic,assign)BOOL isFriendList;

/**
 *  传入一条消息的字典或者模型
 */
@property (nonatomic,strong)EMsgMessage * message;

- (void)setIsFriendList:(BOOL)isFriendList;

@end
