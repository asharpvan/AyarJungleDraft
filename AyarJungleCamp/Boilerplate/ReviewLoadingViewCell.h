//
//  ReviewLoadingViewCell.h
//  Boilerplate
//
//  Created by Pranav Sah on 15/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewLoadingViewCell : UICollectionViewCell

@property(nonatomic,retain) UIActivityIndicatorView *reviewName;

- (void) setStartAnimating;
- (void) setStopAnimating;
@end
