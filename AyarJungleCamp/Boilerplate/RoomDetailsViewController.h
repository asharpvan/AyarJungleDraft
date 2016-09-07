//
//  RoomDetailsViewController.h
//  Boilerplate
//
//  Created by Pranav Sah on 08/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXScrollView.h"
#import "HotelAccommodation.h"
#import "TopBarView.h"

@interface RoomDetailsViewController : UIViewController<MXScrollViewDelegate,TopBarViewDelegate,UIScrollViewDelegate> {
    
}

@property (nonatomic, strong) MXScrollView *scrollView;
@property (nonatomic, strong) UIView *parallaxContentView;
@property (nonatomic, strong) UIScrollView *nonParallaxScrollHeaderView;//UIScrollView
@property (nonatomic, strong) UIImageView *parallaxSingleImageHeaderView;//UIScrollView
@property (nonatomic, strong) TopBarView *topView;

-(instancetype) initWithRoom:(HotelAccommodation *) roomRecieved showAsParallaxView:(BOOL) isParallax;

@end
