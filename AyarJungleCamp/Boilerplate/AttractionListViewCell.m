//
//  AttractionListViewCell.m
//  Boilerplate
//
//  Created by Pranav Sah on 06/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "AttractionListViewCell.h"

@implementation AttractionListViewCell


-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
      
        [self setAutoresizesSubviews: TRUE];
        [self setClipsToBounds:TRUE];
        self.attractionBackgroundImage = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.attractionBackgroundImage setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.attractionBackgroundImage setContentMode:UIViewContentModeScaleAspectFill];
        [self.attractionBackgroundImage setBackgroundColor:[UIColor blackColor]];
        
        self.attractionName = [[UILabel alloc] initWithFrame:CGRectMake(5, self.bounds.size.height - 40, self.bounds.size.width, 20)];
        [self.attractionName setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.attractionName setFont: [UIFont boldSystemFontOfSize:21]];
        [self.attractionName setTextAlignment : NSTextAlignmentLeft];
        [self.attractionName setTextColor:[UIColor blackColor]];
        [self.attractionName setAdjustsFontSizeToFitWidth : TRUE];
       
        self.attractionCategory = [[UILabel alloc] initWithFrame:CGRectMake(5, self.bounds.size.height - 20, self.bounds.size.width, 20)];
        [self.attractionCategory setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.attractionCategory setTextColor:[UIColor blackColor]];
        [self.attractionCategory setTextAlignment : NSTextAlignmentLeft];
        [self.attractionCategory setAdjustsFontSizeToFitWidth : TRUE];

        
        self.attractionDistance = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width/3)*2 - 5, self.bounds.size.height - 20, self.bounds.size.width/3, 20)];
        [self.attractionDistance setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.attractionDistance setTextAlignment : NSTextAlignmentRight];
        [self.attractionDistance setTextColor:[UIColor blackColor]];
        [self.attractionDistance setAdjustsFontSizeToFitWidth : TRUE];
        
        [self addSubview:self.attractionBackgroundImage];
        [self addSubview:self.attractionName];
        [self addSubview:self.attractionCategory];
        [self addSubview:self.attractionDistance];
       
    }
    return self;
}

- (void)setPlaceBackgroundImage:(NSString *) imageName{
    
    [self.attractionBackgroundImage setImage:[UIImage imageNamed:imageName]];
}

- (void)setPlaceName:(NSString *) name {
    
    [self.attractionName setText:name];
}

- (void)setPlaceCategory:(BOOL) isLocal {
    
    if(isLocal) [self.attractionCategory setText:@"In Nainital"];
    else [self.attractionCategory setText:@"Around Nainital"];
}

- (void)setPlaceDistance:(NSNumber *) distance {
    
    [self.attractionDistance setText:[NSString stringWithFormat:@"%@ kms",distance]];
}

@end
