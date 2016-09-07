//
//  AttractionsDetailViewController.h
//  Boilerplate
//
//  Created by Pranav Sah on 07/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXScrollView.h"
#import "AttractionDataModel.h"
#import "TopBarView.h"

@interface AttractionsDetailViewController : UIViewController <MXScrollViewDelegate,TopBarViewDelegate,UIScrollViewDelegate> {
    
}

@property (nonatomic, strong) MXScrollView *scrollView;
@property (nonatomic, strong) UIView *parallaxContentView;
@property (nonatomic, strong) UIScrollView *nonParallaxScrollHeaderView;//UIScrollView
@property (nonatomic, strong) UIImageView *parallaxSingleImageHeaderView;//UIScrollView
@property (nonatomic, strong) TopBarView *topView;

-(instancetype) initWithAttraction:(AttractionDataModel *) attractionRecieved showAsParallaxView:(BOOL) isParallax;

@end
