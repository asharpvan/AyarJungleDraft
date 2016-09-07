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

typedef NS_ENUM(NSUInteger, HotelProfileButtonPressed) {
    HotelProfileButtonPressedReview = 0,
    HotelProfileButtonPressedCall,
    HotelProfileButtonPressedAccommodationAll,
    HotelProfileButtonPressedAccommodationTent,
    HotelProfileButtonPressedAccommodation2Bedded,
    HotelProfileButtonPressedAccommodation4Bedded,
    HotelProfileButtonPressedAccommodationMachan,
    HotelProfileButtonPressedTweet,
};

@interface HotelProfileViewController : UIViewController <MXScrollViewDelegate,TopBarViewDelegate,UIScrollViewDelegate> {
    
}

@property (nonatomic, strong) MXScrollView *scrollView;
@property (nonatomic, strong) UIView *parallaxContentView;
@property (nonatomic, strong) UIScrollView *nonParallaxScrollHeaderView;
@property (nonatomic, strong) UIImageView *parallaxSingleImageHeaderView;
@property (nonatomic, strong) TopBarView *topView;

-(instancetype) initWithHotelProfile:(HotelProfile *) hotelProfileRecieved showAsParallaxView:(BOOL) isParallax;

@end
