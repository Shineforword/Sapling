//
//  LSZoneCellCommentView.m
//  Sapling
//
//  Created by sport on 16/5/13.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSZoneCellCommentView.h"

#import "MLLinkLabel.h"
#import "LSQiuYouZoneModel.h"


@interface LSZoneCellCommentView () <MLLinkLabelDelegate>

/** 赞数组*/
@property (nonatomic, strong) NSArray *likeItemsArray;
/** 评论*/
@property (nonatomic, strong) NSArray *commentItemsArray;

/** 大背景*/
@property (nonatomic, strong) UIImageView *bgImageView;
/** 赞图片*/
@property (nonatomic, strong) UIImageView *likeImageView;

/** 赞标签*/
@property (nonatomic, strong) UILabel *likeLabel;
/** 赞底线*/
@property (nonatomic, strong) UIView *likeLableBottomLine;
/** 评论标签数组*/
@property (nonatomic, strong) NSMutableArray *commentLabelsArray;


@end

@implementation LSZoneCellCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    _bgImageView = [UIImageView new];
    /** 瓦片平铺拉伸图片:第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。*/
    UIImage *bgImage = [[UIImage imageNamed:@"LikeCmtBg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];
    _bgImageView.image = bgImage;
    _bgImageView.backgroundColor = BASE_VC_COLOR;
    [self addSubview:_bgImageView];
    
    _likeLabel = [UILabel new];
    _likeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_likeLabel];
    
    _likeImageView = [[UIImageView alloc]init];
    _likeImageView.image = [UIImage imageWithColor:[UIColor redColor]];
    _likeImageView.clipsToBounds = YES;
    _likeImageView.layer.cornerRadius = 5;
    [self addSubview:_likeImageView];
    
    _likeLableBottomLine = [UIView new];
    _likeLableBottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_likeLableBottomLine];
    /** 快速设置子视图与父视图的上下左右的距离*/
    _bgImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
}
- (void)setCommentItemsArray:(NSArray *)commentItemsArray
{
    /** 评论条数*/
    _commentItemsArray = commentItemsArray;
    
    /** 原评论条数*/
    long originalLabelsCount = self.commentLabelsArray.count;
    
    /** 需要添加的条目*/
    long needsToAddCount = commentItemsArray.count > originalLabelsCount ? (commentItemsArray.count - originalLabelsCount) : 0;
    
    /** 展示的条目*/
    for (int i = 0; i < needsToAddCount; i++) {
        MLLinkLabel *label = [MLLinkLabel new];
        label.linkTextAttributes = @{NSForegroundColorAttributeName : BASE_GREEN_COLOR};
        label.font = [UIFont systemFontOfSize:14];
        label.delegate = self;
        [self addSubview:label];
        /** 评论标签的数组*/
        [self.commentLabelsArray addObject:label];
    }
    
    /** 遍历评论数组*/
    for (int i = 0; i < commentItemsArray.count; i++) {
        LSZoneCommentItemModel * model = commentItemsArray[i];
        MLLinkLabel *label = self.commentLabelsArray[i];
        /** 设置评论标签的内容特性*/
        label.attributedText = [self generateAttributedStringWithCommentItemModel:model];
    }
}
- (NSMutableArray *)commentLabelsArray
{
    if (!_commentLabelsArray) {
        _commentLabelsArray = [NSMutableArray new];
    }
    return _commentLabelsArray;
}
/** 初始化*/
- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray
{
    self.likeItemsArray = likeItemsArray;
    self.commentItemsArray = commentItemsArray;
    
    /** 清空之前的自动布局设置*/
    [_likeImageView sd_clearAutoLayoutSettings];
    
    [_likeLabel sd_clearAutoLayoutSettings];
    
    _likeLabel.frame = CGRectZero;
    _likeImageView.frame = CGRectZero;

    /** 遍历清空评论条目*/
    if (self.commentLabelsArray.count) {
        [self.commentLabelsArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
            [label sd_clearAutoLayoutSettings];
            label.frame = CGRectZero;
        }];
    }
    
    CGFloat margin = 5;
    
    if (likeItemsArray.count) {
        
        _likeImageView.sd_layout
        .leftSpaceToView(self,10)
        .topSpaceToView(self,margin)
        .widthIs(10)
        .heightIs(10);
        
        _likeLabel.sd_layout
        .leftSpaceToView(_likeImageView, margin)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, margin)
        .autoHeightRatio(0);
        _likeLabel.isAttributedContent = YES;
    }
    
    UIView *lastTopView = _likeLabel;
    NSMutableArray * nameArray = [[ NSMutableArray alloc]init];
    [_likeItemsArray enumerateObjectsUsingBlock:^(LSZoneLikeItemModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [nameArray  addObject:model.userName];
    }];
    _likeLabel.text = [nameArray componentsJoinedByString:@","];
    
    for (int i = 0; i < self.commentItemsArray.count; i++) {
        UILabel *label = (UILabel *)self.commentLabelsArray[i];
        CGFloat topMargin = i == 0 ? 10 : 5;
        label.sd_layout
        .leftSpaceToView(self, 8)
        .rightSpaceToView(self, 5)
        .topSpaceToView(lastTopView, topMargin)
        .autoHeightRatio(0);
        
        label.isAttributedContent = YES;
        lastTopView = label;
    }
    
    [self setupAutoHeightWithBottomView:lastTopView bottomMargin:6];
    
}

#pragma mark - private actions

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(LSZoneCommentItemModel *)model
{
    NSString *text = model.firstUserName;
    
    if (model.secondUserName.length) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.secondUserName]];
    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.commentString]];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = [UIColor blueColor];
    
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.firstUserId}
                       range:[text rangeOfString:model.firstUserName]];
    if (model.secondUserName) {
        [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.secondUserId}
                           range:[text rangeOfString:model.secondUserName]];
    }
    return attString;
}



#pragma mark - MLLinkLabelDelegate

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    NSLog(@"%@", link.linkValue);
    /** 回复or删除 */
    if ([self.delegate respondsToSelector:@selector(replaySomeOneWith:)]) {
        [self.delegate replaySomeOneWith:linkText];
    }
    
}

@end
