//
//  RoomListViewCellCollectionViewCell.m
//  Boilerplate
//
//  Created by Pranav Sah on 08/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "RoomListViewCellCollectionViewCell.h"

@implementation RoomListViewCellCollectionViewCell
-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setAutoresizesSubviews: TRUE];
        [self setClipsToBounds:TRUE];
        self.roomBackgroundImage = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.roomBackgroundImage setBackgroundColor:[UIColor blackColor]];
        [self.roomBackgroundImage setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.roomBackgroundImage setContentMode:UIViewContentModeScaleAspectFill];
       
        self.roomName = [[UILabel alloc] initWithFrame:CGRectMake(5, self.bounds.size.height - 40, self.bounds.size.width, 20)];
        [self.roomName setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.roomName setFont: [UIFont boldSystemFontOfSize:21]];
        [self.roomName setTextAlignment : NSTextAlignmentLeft];
        [self.roomName setTextColor:[UIColor whiteColor]];
        [self.roomName setAdjustsFontSizeToFitWidth : TRUE];
        
        self.roomPrice = [[UILabel alloc] initWithFrame:CGRectMake(5, self.bounds.size.height - 20, self.bounds.size.width, 20)];
        [self.roomPrice setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.roomPrice setTextColor:[UIColor whiteColor]];
        [self.roomPrice setTextAlignment : NSTextAlignmentLeft];
        [self.roomPrice setAdjustsFontSizeToFitWidth : TRUE];
        
        
        self.roomCapacity = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width/3)*2 - 5, self.bounds.size.height - 20, self.bounds.size.width/3, 20)];
        [self.roomCapacity setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.roomCapacity setTextAlignment : NSTextAlignmentRight];
        [self.roomCapacity setTextColor:[UIColor whiteColor]];
        [self.roomCapacity setAdjustsFontSizeToFitWidth : TRUE];
        
        [self addSubview:self.roomBackgroundImage];
        [self addSubview:self.roomName];
        [self addSubview:self.roomPrice];
        [self addSubview:self.roomCapacity];
        
    }
    return self;
}

- (void)setAccommodationBackgroundImage:(NSString *) imageName{
    
    [self.roomBackgroundImage setImage:[UIImage imageNamed:imageName]];
}

- (void)setAccommodationName:(NSString *) name{
    
    [self.roomName setText:name];
}

- (void)setAccommodationPrice:(NSString *)roomPrice{
    
    [self.roomPrice setText:[NSString stringWithFormat:@"INR %@",roomPrice]];
}

- (void)setAccommodationCapacity:(NSString *)roomCapacity {
    
    [self.roomCapacity setText:[NSString stringWithFormat:@"Capacity : %@ pax",roomCapacity]];
}

@end
