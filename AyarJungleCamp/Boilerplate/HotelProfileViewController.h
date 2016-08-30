//
//  HotelProfileViewController.h
//  Boilerplate
//
//  Created by Pranav Sah on 29/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXScrollView.h"

@interface HotelProfileViewController : UIViewController <MXScrollViewDelegate>

@property (nonatomic, strong) MXScrollView *scrollView;
@property (nonatomic, strong) UIView *parallaxContentView;
@property (nonatomic, strong) UIImageView *parallaxHeaderView;

-(instancetype)init;

@end
