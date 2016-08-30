//
//  HotelProfileViewViewController.h
//  Boilerplate
//
//  Created by Pranav Sah on 27/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyScreenViewController.h"
//#import "HotelProfile.h"

@class HotelProfile;
@interface HotelProfileViewViewController : EmptyScreenViewController <EmptyScreenViewControllerDelegate>


-(instancetype) initWithHotelProfile:(HotelProfile *) hotelProfileRecieved;

@end
