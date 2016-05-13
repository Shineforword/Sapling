//
//  LSAddFriendTableViewCell.h
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^acceptBlock)(EMsgMessage *message);
typedef void(^rejectBlock)(EMsgMessage *message);

@interface LSAddFriendTableViewCell : UITableViewCell
@property (nonatomic,weak)UIImageView * iconImageView;
@property (nonatomic,weak)UILabel * nickNameLabel;
@property (nonatomic,weak)UILabel * detailLabel;
@property (nonatomic,strong)ZXUser * kUser;
@property (nonatomic,weak)UIButton * acceptButton;
@property (nonatomic,weak)UIButton * rejectButton;
@property (nonatomic,strong)EMsgMessage * kMessage;
@property (nonatomic,strong)acceptBlock kAcceptBlock;
@property (nonatomic,strong)rejectBlock kRejectBlock;

@end
