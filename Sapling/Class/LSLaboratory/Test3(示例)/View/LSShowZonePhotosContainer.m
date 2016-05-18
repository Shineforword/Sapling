//
//  LSShowZonePhotosContainer.m
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSShowZonePhotosContainer.h"
#import "SDPhotoBrowser.h"
@interface LSShowZonePhotosContainer()<SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArray;

@end
@implementation LSShowZonePhotosContainer
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    /** 预制图片数组*/
    self.imageViewsArray = [temp copy];
}
- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{
    //实际图片数组
    _picPathStringsArray = picPathStringsArray;
    //没有相对应图片的隐藏
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    //没有一张图片的
    if (_picPathStringsArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemH = 125;
    if (_picPathStringsArray.count == 1) {
        
        itemH = 150;
    }
    //设置图片
    if ((_picPathStringsArray.count < 5 || _picPathStringsArray.count ==  6) && _picPathStringsArray.count != 0  ) {
        //计算图片的宽高
        CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
        //每一行图片的张数
        long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
        //设置留白
        CGFloat margin = 10;
        
        [_picPathStringsArray enumerateObjectsUsingBlock:^(UIImage *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //九宫格
            long columnIndex = idx % perRowItemCount;
            long rowIndex = idx / perRowItemCount;
            
            UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
            imageView.hidden = NO;
            imageView.image = obj;
            
            imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
        }];
        
        CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
        
        int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
        CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
        
        self.width = w;
        self.height = h;
        
        /** 设置固定高度保证高度不在自动布局过程中再做调整  */
        self.fixedHeight = @(h);
        /** 设置固定宽度保证宽度不在自动布局过程中再做调整  */
        self.fixedWidth = @(w);
        
    }else if (_picPathStringsArray.count == 5){
        
        //计算图片的宽高
      __block CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
        //每一行图片的张数
      __block  long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
        CGFloat margin = 10;
        
        [_picPathStringsArray enumerateObjectsUsingBlock:^(UIImage *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            /** 5张图片特殊排法*/
            if(idx < 2){
                perRowItemCount = 2;
                itemW = (SCREEN_WIDTH - 10 * 3)/2;
                
            }else{
                perRowItemCount = 3;
                itemW = (SCREEN_WIDTH - 10 * 4)/3;
            }
            
            long columnIndex = idx % perRowItemCount;
            long rowIndex = idx / perRowItemCount;
            
            if (idx  ==  2) {
                rowIndex = 1;
                columnIndex = 0;
            }
            if (idx  ==  3) {
                rowIndex = 1;
                columnIndex = 1;
            }
            if (idx  ==  4) {
                rowIndex = 1;
                columnIndex = 2;
            }
            UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
            imageView.hidden = NO;
            imageView.image = obj;
            imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
        }];
        
        CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
        int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
        CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
        
        self.width = w;
        self.height = h;
        /** 设置固定高度保证高度不在自动布局过程中再做调整  */
        self.fixedHeight = @(h);
        /** 设置固定宽度保证宽度不在自动布局过程中再做调整  */
        self.fixedWidth = @(w);
    }
}
/** 当图片少于5张或为6张,单张图片的宽度*/
- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    CGFloat margin = 10;
    if (array.count < 4) {
        
        return (SCREEN_WIDTH - margin*(array.count+1))/array.count;
        
    }else if (array.count == 6){
        
        return (SCREEN_WIDTH - margin*4)/3;
        
    }else{
        
        return (SCREEN_WIDTH - margin*3)/2;

    }
    
}
/** 当图片少于5张或为6张,计算每一行图片的张数*/
- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 4) {
        
        return array.count;

    }else if(array.count == 6){
        
        return 3;
        
    }else{
        return 2;
    }
}

#pragma mark - private actions
/** 相册浏览器*/
- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];
}
#pragma mark - SDPhotoBrowserDelegate

/** 获取质量图片的代理
 - (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
 {
 NSString *imageName = self.picPathStringsArray[index];
 NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
 return url;
 }
 */

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

@end
