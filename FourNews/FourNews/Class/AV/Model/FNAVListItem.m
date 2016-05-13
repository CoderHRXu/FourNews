//
//  FNAVListItem.m
//  Video练习
//
//  Created by haoran on 16/4/11.
//  Copyright © 2016年 xuhaoran. All rights reserved.
//

#import "FNAVListItem.h"
#define XHRMargin 10
@implementation FNAVListItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"descrip":@"description"};
}


-(CGFloat)cellHeight{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    _cellHeight = 2 * 10;
    
    // 标题文字高度
    CGSize size = CGSizeMake(FNScreenW - 2 * XHRMargin, MAXFLOAT);
    NSDictionary * attr = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
    _cellHeight += [self.title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height + 2 * XHRMargin;
    
    // 视频缩略图
    _cellHeight += 180 + 2 *XHRMargin + 40 + XHRMargin * 2;
    return  _cellHeight;
}


-(CGFloat)decriptionCellHeight{
    // 如果已经计算过，就直接返回
    if (_decriptionCellHeight) return _decriptionCellHeight;
    _decriptionCellHeight = 38;
    
    // 描述文字的高度
    CGSize size = CGSizeMake(FNScreenW - 2 *XHRMargin, MAXFLOAT );
    NSDictionary * attr = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    _decriptionCellHeight += [self.descrip boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height + 2 * XHRMargin;
    
    return _decriptionCellHeight;
    
}


@end
