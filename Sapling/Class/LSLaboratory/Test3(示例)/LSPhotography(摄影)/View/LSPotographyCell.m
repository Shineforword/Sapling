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

@end
@implementation LSPotographyCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
    
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor greenColor];
        [self addSubview:_imageView];
        
        _imageView.sd_layout
        .spaceToSuperView(UIEdgeInsetsMake(5, 5, 5, 5));
    }
    return self;
}
- (void)setImage:(UIImage *)image{
    _image = image;
    _imageView.image = image;
}
@end
