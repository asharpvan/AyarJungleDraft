//
//  HotelProfileViewController.h
//  Boilerplate
//
//  Created by Pranav Sah on 29/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXScrollView.h"
#import "HotelProfile.h"
#import "TopBarView.h"

@interface HotelProfileViewController : UIViewController <MXScrollViewDelegate,TopBarViewDelegate,UIScrollViewDelegate> {
    
}

@property (nonatomic, strong) MXScrollView *scrollView;
@property (nonatomic, strong) UIView *parallaxContentView;
@property (nonatomic, strong) UIScrollView *parallaxHeaderView;//UIScrollView
@property (nonatomic, strong) TopBarView *topView;
//@property (nonatomic, strong) UIPageControl *pageControl;

-(instancetype) initWithHotelProfile:(HotelProfile *) hotelProfileRecieved;

@end
