//
//  ReviewLoadedViewCell.h
//  Boilerplate
//
//  Created by Pranav Sah on 15/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewLoadedViewCell : UICollectionViewCell

@property(nonatomic,retain) UILabel *reviewName;

- (void) setUpdateLoadedCellReason:(NSString *) status;
@end
