//
//  ReviewListViewController.h
//  Boilerplate
//
//  Created by Pranav Sah on 14/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBarView.h"

@interface ReviewListViewController : UIViewController <TopBarViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) TopBarView *topView;

-(instancetype) initWithTotalReviews:(NSNumber *)totalReviews;
//-(void) startLoading;


@end
