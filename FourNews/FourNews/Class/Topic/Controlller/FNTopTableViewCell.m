//
//  FNTopTableViewCell.m
//  FourNews
//
//  Created by xuxisong on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopTableViewCell.h"
#import "FNTopicViewItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+XXSFN.h"
// 内扩展
@interface FNTopTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIView *viewV;


@end

@implementation FNTopTableViewCell

-(void)setItem:(FNTopicViewItem *)item
{
    _item = item;
    //设置我们的头像的icon
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:item.headpicurl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //设置这里面的图片的尺寸
        self.headerImage.image = [UIImage circleImageWithBorder:3 color:[UIColor whiteColor] image:image];
        
    }];
    [_contentImage sd_setImageWithURL:[NSURL URLWithString:item.picurl]];
    
    //设置自己的名称
    self.nameLable.text = item.name;
    self.contentLable.text = item.alias;
    self.titleLable.text = item.title;
    self.typeLable.text = item.classification;
    //判断这个个数
//    if (item.concernCount>10000.0) {
//        NSString *couns = [NSString stringWithFormat:@"%.1f万关注",item.concernCount/10000.0];
//         self.followLabel.text = couns;
//    }else
//    {
//    NSString *couns = [NSString stringWithFormat:@"%d关注",item.concernCount];
//        self.followLabel.text = couns;
//    }
    //
    self.followLabel.text = [self item:[item.concernCount intValue] name:@"%.1f万关注" name1:@"%d关注"];
    
    self.questionLabel.text=[self item:[item.concernCount intValue] name:@"%.1f万提问" name1:@"%d提问"];
    //是设置我们的按钮的样式
    
    self.viewV.layer.cornerRadius = 15;
    self.viewV.clipsToBounds = YES;

    

    
}
//设置每个cell的之间的高度-10
-(void)setFrame:(CGRect)frame
{
    frame.size.height -=10;
    
    [super setFrame:frame];

}
//抽取方法调用
-(NSString *)item:(NSInteger)count  name:(NSString *)name name1:(NSString *)name1
{
    
    if (count>10000.0) {
    NSString *couns = [NSString stringWithFormat:name,count/10000.0];
        return couns;
}else
{
    NSString *couns = [NSString stringWithFormat:name1,count];
    return couns;
}



}
- (IBAction)buttonV {
}
@end
