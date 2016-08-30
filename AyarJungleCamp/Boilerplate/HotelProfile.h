//
//  HotelProfile.h
//  Boilerplate
//
//  Created by Pranav Sah on 26/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//#import "HotelRating.h"
//#import "HotelReview.h"
@class HotelRating;
@class HotelReview;
@class HotelAccommodationList;

@interface HotelProfile : NSObject

//About
@property(nonatomic,strong) NSString *hotelName;
@property(nonatomic,strong) NSString *hotelSynopsis;
@property(nonatomic,strong) NSString *hotelHistory;
@property(nonatomic,strong) NSString *hotelStreetAddr1;
@property(nonatomic,strong) NSString *hotelStreetAddr2;
@property(nonatomic,strong) NSString *hotelCity;
@property(nonatomic,strong) NSString *hotelPin;
@property(nonatomic,strong) NSString *hotelContact1;
@property(nonatomic,strong) NSString *hotelContact2;
@property(nonatomic,strong) NSNumber *hotelEstablishmentYear;
@property(nonatomic,assign) CLLocationCoordinate2D hotelCoordinates;
@property(nonatomic,strong) NSNumber *hotelRecommendedByPercentage;

@property(nonatomic,strong) HotelRating *hotelRating;
@property(nonatomic,strong) HotelReview *hotelReview;
@property(nonatomic,strong) NSArray *hotelAccommodationList;

//@property(nonatomic,strong) NSNumber *longitudeDegree;
//@property(nonatomic,strong) NSNumber *latitudeDegree;
//@property(nonatomic,strong) NSString *latitudeDegree;

//@property(nonatomic,strong) NSNumber *negativeReviewCount;

-(instancetype) init;

-(void) displayHotelProfile;

@end
