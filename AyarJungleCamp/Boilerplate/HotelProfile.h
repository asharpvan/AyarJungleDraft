//
//  HotelProfile.h
//  Boilerplate
//
//  Created by Pranav Sah on 26/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "HotelRating.h"
//#import "HotelReview.h"
@class HotelRating;
@class HotelReview;

@interface HotelProfile : NSObject


@property(nonatomic,strong) HotelRating *hotelRating;
@property(nonatomic,strong) HotelReview *hotelReview;
@property(nonatomic,strong) NSNumber *recommendedPercentage;
@property(nonatomic,strong) NSNumber *longitudeDegree;
@property(nonatomic,strong) NSNumber *latitudeDegree;

//@property(nonatomic,strong) NSNumber *negativeReviewCount;



-(void) displayHotelProfile;

@end
