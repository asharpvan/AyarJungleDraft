//
//  ReviewListViewCell.m
//  Boilerplate
//
//  Created by Pranav Sah on 14/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "ReviewListViewCell.h"

@implementation ReviewListViewCell

-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setAutoresizesSubviews: TRUE];
        [self setClipsToBounds:TRUE];
        
        self.reviewName = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.bounds.size.width - 20, 44)];
        [self.reviewName setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.reviewName setFont: [UIFont boldSystemFontOfSize:21]];
        [self.reviewName setTextAlignment : NSTextAlignmentLeft];
        [self.reviewName setTextColor:[UIColor whiteColor]];
        [self.reviewName setAdjustsFontSizeToFitWidth : TRUE];
        
        self.reviewTotalRatings = [[UILabel alloc] initWithFrame:self.reviewName.frame];
        [self.reviewTotalRatings setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.reviewTotalRatings setTextColor:[UIColor whiteColor]];
        [self.reviewTotalRatings setTextAlignment : NSTextAlignmentRight];
        [self.reviewTotalRatings setAdjustsFontSizeToFitWidth : TRUE];
        
        
        self.reviewCreatedOn = [[UILabel alloc] initWithFrame:CGRectMake(self.reviewName.frame.origin.x, self.reviewName.frame.origin.y + self.reviewName.frame.size.height, self.reviewName.frame.size.width, self.reviewName.frame.size.height)];
        [self.reviewCreatedOn setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.reviewCreatedOn setTextAlignment : NSTextAlignmentRight];
        [self.reviewCreatedOn setTextColor:[UIColor whiteColor]];
        [self.reviewCreatedOn setAdjustsFontSizeToFitWidth : TRUE];
        
        
        [self setBackgroundColor:[UIColor blackColor]];
        [self addSubview:self.reviewName];
        [self addSubview:self.reviewCreatedOn];
        [self addSubview:self.reviewTotalRatings];
        
    }
    return self;
}

- (void)setReviewerFirstName:(NSString *) name andLastName:(NSString *) surname {
 
       [self.reviewName setText:[NSString stringWithFormat:@"%@ %@",name,surname]];
}

- (void)setReviewerRatings:(NSNumber *) ratings {
    
    [self.reviewTotalRatings setText:[NSString stringWithFormat:@" Rated %@",ratings]];
}

- (void)setReviewerCreationDate:(NSString *) dateString {

    [self.reviewCreatedOn setText:dateString];

}

@end
