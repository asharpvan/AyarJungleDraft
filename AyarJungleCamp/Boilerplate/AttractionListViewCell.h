//
//  AttractionListViewCell.h
//  Boilerplate
//
//  Created by Pranav Sah on 06/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttractionListViewCell : UICollectionViewCell

@property(nonatomic,retain) UIImageView *attractionBackgroundImage;
@property(nonatomic,retain) UILabel *attractionName;
@property(nonatomic,retain) UILabel *attractionCategory;
@property(nonatomic,retain) UILabel *attractionDistance;

- (void)setPlaceBackgroundImage:(NSString *) imageName;
- (void)setPlaceName:(NSString *) name;
- (void)setPlaceCategory:(BOOL) isLocal;
- (void)setPlaceDistance:(NSNumber *) distance;

@end
