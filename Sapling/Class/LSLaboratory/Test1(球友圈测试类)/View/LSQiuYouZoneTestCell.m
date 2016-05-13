//
//  LSQiuYouZoneTestCell.m
//  Sapling
//
//  Created by sport on 16/5/12.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSQiuYouZoneTestCell.h"

#import "LSQiuYouZoneModel.h"
#import "LSZonePhotoContainerView.h"
#import "LSZoneCellCommentView.h"

const CGFloat LScontentLabelFontSize = 15;
CGFloat LSmaxContentLabelHeight = 0; // 根据具体font而定

@interface LSQiuYouZoneTestCell()<LSZoneCellCommentViewDelegate>

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIImageView * iconImage;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIButton * moreButton;
@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, strong) LSZonePhotoContainerView * photoContainerView;
@property (nonatomic, strong) LSZoneCellCommentView * commentView;

@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UIButton * operationButton;
@property (nonatomic, strong) UIView * line;

@end
@implementation LSQiuYouZoneTestCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = BASE_VC_COLOR;
        [self setupView];

    }
    
    return self;
}
- (void)setupView{
    /** 底色*/
    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    /** 头像*/
    _iconImage = [[UIImageView alloc]init];
    _iconImage.clipsToBounds = YES;
    _iconImage.layer.cornerRadius = 25;
    
    /** 姓名*/
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    
    /** 时间*/
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    
    /** 内容*/
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:13];
   
    
    //最大内容显示高度
    if (LSmaxContentLabelHeight == 0) {
        /** 初始化时默认最大内容展示高度如果为0时,设置为3行文本的高度*/
        LSmaxContentLabelHeight = _contentLabel.font.lineHeight * 3;
    }
    
    //全文button
    _moreButton = [UIButton new];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:TimeLineCellHighlightedColor forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //操作button
    _operationButton = [UIButton new];
    [_operationButton setTitle:@"==" forState:UIControlStateNormal];
    [_operationButton setTitleColor:BASE_GREEN_COLOR forState:UIControlStateNormal];
    [_operationButton addTarget:self action:@selector(operationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _operationButton.titleLabel.font = [UIFont systemFontOfSize:14];

  
    //相册
    _photoContainerView = [[LSZonePhotoContainerView alloc]init];
    
    //评论容器
    _commentView = [LSZoneCellCommentView new];
    _commentView.delegate = self;

    //地址
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.font = [UIFont systemFontOfSize:12];
    /** 注意:添加到的父视图*/
    
    /** 取出cell的内容view*/
    UIView * contentView = self.contentView;

    [contentView addSubview:_bgView];
    
    NSArray * views = @[_iconImage,
                        _nameLabel,
                        _timeLabel,
                        _contentLabel,
                        _moreButton,
                        _photoContainerView,
                        _commentView,
                        _addressLabel,
                        _operationButton];
    [_bgView sd_addSubviews:views];

    _bgView.sd_layout
    .leftSpaceToView(contentView,0)
    .topSpaceToView(contentView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(190);
    
    _iconImage.sd_layout
    .leftSpaceToView(_bgView,20)
    .topSpaceToView(_bgView,10)
    .widthIs(50)
    .heightIs(50);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconImage,10)
    .topSpaceToView(_bgView,15)
    .widthIs(SCREEN_WIDTH - 20 - 50 - 10)
    .heightIs(12);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_iconImage,10)
    .topSpaceToView(_nameLabel,10)
    .widthIs(SCREEN_WIDTH - 20 - 50 - 10)
    .heightIs(10);
    
    
    _contentLabel.sd_layout
    .leftSpaceToView(_bgView,20)
    .topSpaceToView(_iconImage, 10)
    .rightSpaceToView(_bgView, 20)
    .autoHeightRatio(0);//Label传0文字高度自适应
    
    /** morebutton的高度在setmodel里面设置*/
    _moreButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(30);
    
    /** 图片容器*/
    _photoContainerView.sd_layout
    .leftEqualToView(_contentLabel);
    
    /** 评论容器*/
    _commentView.sd_layout
    .leftEqualToView(_photoContainerView)
    .rightSpaceToView(_bgView,10)
    .topSpaceToView(_photoContainerView,10);
    
    /** 地址*/
    _addressLabel.sd_layout
    .leftEqualToView(_photoContainerView)
    .rightSpaceToView(_bgView,10)
    .topSpaceToView(_commentView,10)
    .autoHeightRatio(0);
    
    /** 操作*/
    _operationButton.sd_layout
    .topSpaceToView(_bgView,10)
    .rightSpaceToView(_bgView,10)
    .heightIs(14)
    .widthIs(40);
    
    
}
- (void)setModel:(LSQiuYouZoneModel *)model{
    _model = model;
    /** 头像数组*/
    NSMutableArray * iconImages = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < 5; i ++ ) {
        CGFloat r = arc4random_uniform(255);
        CGFloat g  = arc4random_uniform(255);
        CGFloat b = arc4random_uniform(255);
        UIImage * image = [UIImage imageWithColor:QYQCOLOR(r, g, b)];
        [iconImages addObject:image];
    }
    int b = arc4random_uniform(5);
    _iconImage.image = iconImages[b];
    _nameLabel.text = model.name;
    _timeLabel.text = @"10分钟前";
    _contentLabel.text = model.contentStr;
    _addressLabel.text = @"天安门西.中山公园";
    
    
    /** 图片数组*/
    _photoContainerView.picPathStringsArray = model.picNamesArray;

    /* 评论设置*/
    _commentView.frame = CGRectZero;
    [_commentView setupWithLikeItemsArray:model.likeItemsArray commentItemsArray:model.commentItemsArray];
    
    /** 如果模型中shouldShowMoreButton(只读属性)为真*/
    if (model.shouldShowMoreButton) {
        /** 如果文字高度超过60*/
        /** 设置高度为20*/
        _moreButton.sd_layout.heightIs(20);
        /** 显示*/
        _moreButton.hidden = NO;
        if (model.isOpening) {
            /** 如果需要展开(文本的最大高度?)*/
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            /** 展示所有内容设置*/
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            /** 收起回位*/
            _contentLabel.sd_layout.maxHeightIs(LSmaxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        /** 隐藏*/
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }

    
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    /** 相册容器*/
    _photoContainerView.sd_layout.topSpaceToView(_moreButton, picContainerTopMargin);
    
    /** 评论容器*/
    _commentView.sd_layout.topSpaceToView(_photoContainerView,10);
    
    //评论不存在 点赞不存在
    if (!model.commentItemsArray.count && !model.likeItemsArray.count) {
        _commentView.fixedWidth = @0; // 如果没有评论或者点赞，设置commentview的固定宽度为0（设置了fixedWith的控件将不再在自动布局过程中调整宽度）
        _commentView.fixedHeight = @0; // 如果没有评论或者点赞，设置commentview的固定高度为0（设置了fixedHeight的控件将不再在自动布局过程中调整高度）
        _commentView.sd_layout.topSpaceToView(_photoContainerView, 0);
    } else {
        _commentView.fixedHeight = nil; // 取消固定宽度约束
        _commentView.fixedWidth = nil; // 取消固定高度约束
        _commentView.sd_layout.topSpaceToView(_photoContainerView, 10);
    }
    
    /** */
    [_bgView setupAutoHeightWithBottomView:_addressLabel  bottomMargin:15];
    /** 设置Cell的高度自适应，也可用于设置普通view内容高度自适应 */
    [self setupAutoHeightWithBottomView:_bgView bottomMargin:15];

}
#pragma mark - private actions

- (void)moreButtonClicked
{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }

}
- (void)operationButtonClicked{
    if (self.operationButtonClickedBlock) {
        self.operationButtonClickedBlock(self.indexPath);
    }

}
#pragma mark - LSZoneCellCommentViewDelegate

- (void)replaySomeOneWith:(NSString *)str{
   
    if (self.replaySomeBodyBlock) {
        
        self.replaySomeBodyBlock(self.indexPath,str);
    }

}
@end
