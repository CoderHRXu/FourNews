//
//  FNAVideoDecriptionCell.m
//  FourNews
//
//  Created by haoran on 16/5/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVideoDecriptionCell.h"
#import "FNAVListItem.h"

@interface FNAVideoDecriptionCell ()




@end


@implementation FNAVideoDecriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)cellBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        self.videoSubtitleLabel.numberOfLines = 0;
        
    }else{
        self.videoSubtitleLabel.numberOfLines = 2;
        
    }
  
    if (_CellBtnClickBlock) {
        _CellBtnClickBlock(_item);
    }

}

-(void)setItem:(FNAVListItem *)item{
    _item = item;
    self.videoTitleLabel.text = item.title;
    self.videoSubtitleLabel.text = item.descrip;
    self.cellBtn.hidden = item.decriptionCellHeight < 90 ? YES : NO;
}

-(void)setFrame:(CGRect)frame{
    
    frame.size.height -= 10;
    
    //给frame赋值
    [super setFrame:frame];
}
@end
