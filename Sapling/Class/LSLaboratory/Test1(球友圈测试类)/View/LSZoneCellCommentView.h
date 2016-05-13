//
//  LSZoneCellCommentView.h
//  Sapling
//
//  Created by sport on 16/5/13.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSZoneCellCommentView : UIView
/**
 *第一个数组:喜欢数组
 *第二个数组:评论数组
 */
- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray;
@end
