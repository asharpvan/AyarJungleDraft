//
//  AttractionListViewController.h
//  Boilerplate
//
//  Created by Pranav Sah on 06/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBarView.h"

@interface AttractionListViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TopBarViewDelegate>

@property (nonatomic, strong) TopBarView *topView;

-(instancetype) initWithAttractionList:(NSArray *) listRecieved;
@end
