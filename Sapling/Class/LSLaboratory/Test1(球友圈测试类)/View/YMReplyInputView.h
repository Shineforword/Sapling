//
//  HXReplyInputView.h
//  Hongxiu
//
//  Created by 阿虎 on 14-8-18.
//  Copyright (c) 2014年 FeeTan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RePlayInputViewDelegate <NSObject>

/** 回复回调*/
- (void)YMReplyInputWithReply:(NSString *)replyText appendIndexPath:(NSIndexPath * )inputIndexPath andName:(NSString *)name;
/** 销毁*/
- (void)destoryInputView;

@end

@interface YMReplyInputView : UIView<UITextViewDelegate>
{
    CGFloat topGap;
    CGFloat keyboardAnimationDuration;
    UIViewAnimationCurve keyboardAnimationCurve;
    CGFloat keyboardHeight;
    int inputHeight;
    int inputHeightWithShadow;
    BOOL autoResizeOnKeyboardVisibilityChanged;
    UIView *tapView;
}

@property (strong, nonatomic) UIImageView* inputBackgroundView;
@property (strong, nonatomic) UITextField *textViewBackgroundView;
@property (strong, nonatomic) UIButton* sendButton;
@property (strong, nonatomic) UITextView* textView;
@property (strong, nonatomic) UILabel* lblPlaceholder;

@property (readwrite, nonatomic) CGFloat keyboardHeight;

@property (assign, nonatomic) NSInteger replyTag;
@property (assign, nonatomic) BOOL autoResizeOnKeyboardVisibilityChanged;

@property (assign, nonatomic) id<RePlayInputViewDelegate>delegate;

/** 被回复人姓名*/
@property (nonatomic, strong) NSString * replayName;
/** */
@property (nonatomic, strong) NSIndexPath * indexPath;
/** 初始化方法*/
- (id) initWithFrame:(CGRect)frame andAboveView:(UIView *)bgView;

/** text的get方法*/
- (NSString*)text;

/** text的set方法*/
- (void)setText:(NSString*)text;

/** 占位字符*/
- (void)setPlaceholder:(NSString*)text;

/** 显示评论视图*/
- (void)showCommentView;

/** 销毁*/
- (void)disappear;


@end
