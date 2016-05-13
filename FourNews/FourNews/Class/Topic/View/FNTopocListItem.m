//
//  FNTopocListItem.m
//  FourNews
//
//  Created by xuxisong on 16/4/20.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopocListItem.h"
#import "FNTopicViewItem.h"
@interface FNTopocListItem ()


@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UIView *viewV;

@end
@implementation FNTopocListItem

+(instancetype)FNTopocListItem
{
    return [[NSBundle mainBundle] loadNibNamed:@"FNTopocListItem" owner:nil options:0].lastObject;

}


-(void)setItem:(FNTopicViewItem *)item
{
    _item = item;
   
    self.topLable.text = item.alias;
    NSString *conrenCount = [NSString stringWithFormat:@"%d",[item.concernCount intValue]];
    if ([item.concernCount intValue] >=10000.0) {
        conrenCount = [NSString stringWithFormat:@"%0.1f万",[item.concernCount intValue]/10000.0];
    }
    self.middleLabel.text = [NSString stringWithFormat:@"-- %@关注 -- ",conrenCount];

    self.viewV.layer.cornerRadius = 15;
    self.viewV.clipsToBounds = YES;
    
    
}
@end
