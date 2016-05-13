//
//  LSZoneCellCommentView.h
//  Sapling
//
//  Created by sport on 16/5/13.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSZoneCellCommentViewDelegate <NSObject>
- (void)replaySomeOneWith:(NSString *)str;
@end

@interface LSZoneCellCommentView : UIView


@property (nonatomic, weak) id<LSZoneCellCommentViewDelegate>delegate;
/**
 *第一个数组:赞数组
 *第二个数组:评论数组
 */
- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray;
@end
