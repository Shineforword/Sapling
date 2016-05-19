//
//  LSPotographyCell.m
//  Sapling
//
//  Created by sport on 16/5/18.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSPotographyCell.h"
@interface LSPotographyCell ()

@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, strong) UIView * grayView;
@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * favour;

@end
@implementation LSPotographyCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
    
        [self setupView];
    }
    return self;
}
- (void)setupView{
    /** 图片*/
    _imageView = [[UIImageView alloc]init];
    _imageView.backgroundColor = [UIColor greenColor];
    
    
    /** 灰背景*/
    _grayView = [[UIView alloc]init];
    _grayView.backgroundColor = QYQHEXCOLOR_ALPHA(0x000000, 0.5);
    
    [self addSubview:_imageView];
    [self addSubview:_grayView];

    _imageView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    _grayView.sd_layout
    .bottomSpaceToView(self,0)
    .widthIs(self.frame.size.width)
    .heightIs(20);
    
    /** 名字*/
    _name = [[UILabel alloc]init];
    _name.font = [UIFont systemFontOfSize:11];
    _name.textColor = QYQHEXCOLOR(0xffffff);
    
    /** 赞*/
    _favour = [[UILabel alloc]init];
    _favour.textAlignment = NSTextAlignmentRight;
    _favour.font = [UIFont systemFontOfSize:11];
    _favour.textColor = QYQHEXCOLOR(0xffffff);
    
    [_grayView addSubview:_name];
    [_grayView addSubview:_favour];
    
    _name.sd_layout
    .topSpaceToView(_grayView,5)
    .leftSpaceToView(_grayView,4)
    .widthIs(self.frame.size.width)
    .heightIs(11);
    
    _favour.sd_layout
    .topSpaceToView(_grayView,5)
    .rightSpaceToView(_grayView,4)
    .widthIs(self.frame.size.width)
    .heightIs(11);


    



}
- (void)setImage:(UIImage *)image{
    _image = image;
    _imageView.image = image;
    _name.text = @"光前";
    _favour.text  = @"111";
}
@end
