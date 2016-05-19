//
//  LSShowZoneCell.m
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSShowZoneCell.h"
#import "LSShowZoneModel.h"

#import "LSShowZonePhotosContainer.h"
#import "LSZoneLabelClassifyView.h"
#import "LSZoneFavCommentShareView.h"

const CGFloat  LSShowZoneCellContentLabelFontSize = 15;
CGFloat  LSMaxContentLabelHeight = 0; // 根据具体font而定

@interface LSShowZoneCell()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIImageView * iconImage;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIButton * moreButton;
@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, strong) LSShowZonePhotosContainer * photoContainerView;
@property (nonatomic, strong) LSZoneLabelClassifyView * labelClassifyView;
@property (nonatomic, strong) LSZoneFavCommentShareView * favCommentShareView;



@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UIButton * operationButton;

@end
@implementation LSShowZoneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BASE_VC_COLOR;
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
    _iconImage.layer.cornerRadius = 5;
    
    /** 姓名*/
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = QYQHEXCOLOR(0x00c7c8);
    _nameLabel.font = [UIFont systemFontOfSize:13];
    
    /** 时间*/
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = BASE_9_COLOR;
    _timeLabel.font = [UIFont systemFontOfSize:10];
    
    /** 内容*/
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.textColor = BASE_6_COLOR;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    
    //地址
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.textColor = QYQHEXCOLOR(0x00c7c8);
    _addressLabel.font = [UIFont systemFontOfSize:10];

    //最大内容显示高度
    if (LSMaxContentLabelHeight == 0) {
        /** 初始化时默认最大内容展示高度如果为0时,设置为3行文本的高度*/
        LSMaxContentLabelHeight = _contentLabel.font.lineHeight * 3;
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

    /** 相册容器*/
    _photoContainerView = [[LSShowZonePhotosContainer alloc]init];
    
    /** 标签容器*/
    
    _labelClassifyView = [[LSZoneLabelClassifyView alloc]init];
    
    /** favCommentShare*/
    _favCommentShareView = [[LSZoneFavCommentShareView alloc]init];
    
    /** 取出cell的内容view*/
    UIView * contentView = self.contentView;
    
    [contentView addSubview:_bgView];
    
    NSArray * views = @[
                        _iconImage,
                        _nameLabel,
                        _timeLabel,
                        _contentLabel,
                        _moreButton,
                        _addressLabel,
                        _operationButton,
                        _photoContainerView,
                        _labelClassifyView,
                        _favCommentShareView,
                        ];
    [_bgView sd_addSubviews:views];
    
    CGFloat margin = 10;
    
    _bgView.sd_layout
    .leftSpaceToView(contentView,0)
    .topSpaceToView(contentView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(190);
    
    _iconImage.sd_layout
    .leftSpaceToView(_bgView,margin)
    .topSpaceToView(_bgView,margin + 3)
    .widthIs(32)
    .heightIs(32);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconImage,margin - 1)
    .topSpaceToView(_bgView,16)
    .widthIs(SCREEN_WIDTH - 20 - 50 - 10)
    .heightIs(13);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_iconImage,margin)
    .topSpaceToView(_nameLabel,5)
    .widthIs(SCREEN_WIDTH - 20 - 50 - 10)
    .heightIs(10);
    
    
    _contentLabel.sd_layout
    .leftSpaceToView(_bgView,margin)
    .topSpaceToView(_iconImage, margin + 2)
    .rightSpaceToView(_bgView, margin)
    .autoHeightRatio(0);//Label传0文字高度自适应
    
    /** morebutton的高度在setmodel里面设置*/
    _moreButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(30);
    
    /** 图片容器*/
    _photoContainerView.sd_layout
    .leftEqualToView(_contentLabel);
    
    /** 地址*/
    _addressLabel.sd_layout
    .topSpaceToView(_photoContainerView,margin + 2)
    .leftSpaceToView(_bgView,margin)
    .heightIs(20)
    .widthIs(SCREEN_WIDTH - margin);
    
    /** 标签容器*/
    _labelClassifyView.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_addressLabel,10)
    .widthIs(SCREEN_WIDTH - 20);
    
    /** favCommentShare*/
    _favCommentShareView.sd_layout
    .leftSpaceToView(_bgView,0)
    .topSpaceToView(_labelClassifyView,10)
    .widthIs(SCREEN_WIDTH)
    .heightIs(31);
    
    
}
-(void)setModel:(LSShowZoneModel *)model{
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
    _timeLabel.text = model.time;
    _contentLabel.text = model.contentStr;
    _addressLabel.text = model.address;
    _photoContainerView.picPathStringsArray = model.photosArray;
    /** 标签容器*/
    _labelClassifyView.labelArray = model.labels;

    /** fav*/
    _favCommentShareView.titleArray = @[@"22",@"33",@"44"];
    
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
            _contentLabel.sd_layout.maxHeightIs(LSMaxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        /** 隐藏*/
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    
    CGFloat picContainerTopMargin = 0;
    if (model.photosArray.count) {
        picContainerTopMargin = 10;
    }
    /** 相册容器*/
    _photoContainerView.sd_layout.topSpaceToView(_moreButton, picContainerTopMargin);
    
    /** */
    [_bgView setupAutoHeightWithBottomView:_favCommentShareView  bottomMargin:15];
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

@end
