//
//  LSZoneLabelClassifyView.m
//  Sapling
//
//  Created by sport on 16/5/19.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSZoneLabelClassifyView.h"

@interface LSZoneLabelClassifyView ()

@property (nonatomic, strong)UIButton * recordBtn;

@property (nonatomic, strong)NSMutableArray * buttonsArray;

@end

@implementation LSZoneLabelClassifyView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){

        [self setup];
    }
    
    return self;
}
- (void)setup{
    
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:tagBtn];
        
        tagBtn.clipsToBounds = YES;
        tagBtn.layer.cornerRadius = 8;
        tagBtn.layer.borderWidth = 0.7;
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        tagBtn.layer.borderColor = BASE_9_COLOR.CGColor;
        [tagBtn setTitleColor:BASE_9_COLOR forState:UIControlStateNormal];

        [temp addObject:tagBtn];
    }
    
    /** 预制图片数组*/
    self.buttonsArray = [temp copy];
}

- (void)setLabelArray:(NSArray *)labelArray{

    _recordBtn = nil;
    _labelArray = labelArray;
    
    for (long i = _labelArray.count; i < self.buttonsArray.count; i++) {
        UIButton * button = [self.buttonsArray objectAtIndex:i];
        button.hidden = YES;
    }
    //没有标签的
    if (_labelArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    [_labelArray enumerateObjectsUsingBlock:^(NSString *  str , NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat selectBtnY = 0;
        CGFloat maxItemWidth = self.frame.size.width - 20;
        CGSize buttonSize = [str sizeWithFont:[UIFont systemFontOfSize:10]
                                                   maxSize:CGSizeMake(maxItemWidth, MAXFLOAT)];
        UIButton *tagBtn = self.buttonsArray[idx];
        if (_recordBtn) {
           
            if ((CGRectGetMaxX(_recordBtn.frame) + buttonSize.width + 10) > maxItemWidth) {
                
                selectBtnY = selectBtnY + 16 +  5;
                tagBtn.sd_layout
                .topSpaceToView(self,selectBtnY)
                .leftSpaceToView(self,0)
                .widthIs(buttonSize.width)
                .heightIs(16);
                
            }else{
                
                tagBtn.sd_layout
                .topSpaceToView(self,selectBtnY)
                .leftSpaceToView(_recordBtn,10)
                .widthIs(buttonSize.width + 10)
                .heightIs(16);
            }
        
        }else{
            
            tagBtn.sd_layout
            .topSpaceToView(self,selectBtnY)
            .widthIs(buttonSize.width + 10)
            .heightIs(16);

        }
        [tagBtn setTitle:str forState:UIControlStateNormal];
        _recordBtn = tagBtn ;
        
    }];
    
    [self setupAutoHeightWithBottomView:_recordBtn bottomMargin:0];    
}

@end
