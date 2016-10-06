//
//  ReviewListViewCell.h
//  Boilerplate
//
//  Created by Pranav Sah on 14/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewListViewCell : UICollectionViewCell

@property(nonatomic,retain) UILabel *reviewName;
@property(nonatomic,retain) UILabel *reviewTotalRatings;
@property(nonatomic,retain) UILabel *reviewCreatedOn;

- (void)setReviewerFirstName:(NSString *) name andLastName:(NSString *) surname;
- (void)setReviewerRatings:(NSNumber *) ratings;
- (void)setReviewerCreationDate:(NSString *) dateString;
@end
