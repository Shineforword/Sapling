//
//  LSQiuYouZoneModel.m
//  Sapling
//
//  Created by sport on 16/5/12.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSQiuYouZoneModel.h"


extern const CGFloat LScontentLabelFontSize;

extern CGFloat LSmaxContentLabelHeight;

@implementation LSQiuYouZoneModel

{
    CGFloat _lastContentWidth;
}
/** ???!*/
@synthesize contentStr = _contentStr;

- (void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}

/** 重写contentStr的get方法,目的:设置是否展示收起/全文button*/
- (NSString *)contentStr
{
    CGFloat contentW = SCREEN_WIDTH - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_contentStr boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:LScontentLabelFontSize]} context:nil];
        /** extern修饰的内容:源码全局变量?*/
        /** 文本高度 > 最大文本展示内容的高度(cell中取得的3行文本高度?),需要显示"全文"或者"收起"的按钮*/
        /** _shouldShowMoreButton属性设置为readOnly的意义所在*/
        if (textRect.size.height > LSmaxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return _contentStr;
}


@end
