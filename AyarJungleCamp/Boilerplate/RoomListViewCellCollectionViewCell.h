//
//  RoomListViewCellCollectionViewCell.h
//  Boilerplate
//
//  Created by Pranav Sah on 08/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomListViewCellCollectionViewCell : UICollectionViewCell

@property(nonatomic,retain) UIImageView *roomBackgroundImage;
@property(nonatomic,retain) UILabel *roomName;
@property(nonatomic,retain) UILabel *roomPrice;
@property(nonatomic,retain) UILabel *roomCapacity;

- (void)setAccommodationBackgroundImage:(NSString *) imageName;
- (void)setAccommodationName:(NSString *) name;
- (void)setAccommodationPrice:(NSString *)roomPrice;
- (void)setAccommodationCapacity:(NSString *)roomCapacity;

@end
