//
//  ReviewLoadedViewCell.m
//  Boilerplate
//
//  Created by Pranav Sah on 15/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "ReviewLoadedViewCell.h"

@implementation ReviewLoadedViewCell

-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setAutoresizesSubviews: TRUE];
        [self setClipsToBounds:TRUE];
        
        self.reviewName = [[UILabel alloc] initWithFrame:self.bounds];
        [self.reviewName setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
//        [self.reviewName setFont: [UIFont boldSystemFontOfSize:21]];
        [self.reviewName setTextAlignment : NSTextAlignmentCenter];
        [self.reviewName setTextColor:[UIColor redColor]];
        [self.reviewName setAdjustsFontSizeToFitWidth : TRUE];
        
        [self setUserInteractionEnabled:FALSE];
        
        [self addSubview:self.reviewName];
    }
    return self;
}

- (void) setUpdateLoadedCellReason:(NSString *) status {

    [self.reviewName setText:status];
}
@end
