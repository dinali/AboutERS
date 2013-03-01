//
//  PublicationCell.m
//  SimpleDrillDown
//
//  Created by Dina Li on 2/26/13.
//
//

#import "PublicationCellView.h"

@implementation PublicationCellView

@synthesize contentTextView = _contentTextView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UITextView *)contentTextView{
    if(!_contentTextView){
        _contentTextView = [[UITextView alloc]init];
    }
    return _contentTextView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [[self contentView] addSubview:self.contentTextView];
    
}

@end
