//
//  HotelAccommodation.h
//  Boilerplate
//
//  Created by Pranav Sah on 27/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AccommodationType) {
    AccommodationTypeTent = 3,
    AccommodationType2Bedded,
    AccommodationType4Bedded,
    AccommodationTypeMachan
};

@interface HotelAccommodation : NSObject


@property(nonatomic,assign) NSNumber *accomodationType;
@property(nonatomic,strong) NSString *roomName;
@property(nonatomic,strong) NSString *roomImage1;
@property(nonatomic,strong) NSString *roomImage2;
@property(nonatomic,strong) NSString *roomImage3;
@property(nonatomic,strong) NSNumber *roomTotal;
@property(nonatomic,strong) NSNumber *roomCapacity;
@property(nonatomic,strong) NSNumber *roomPrice;


-(BOOL) hasHotelAccommodationDetailsChangedOverTime:(HotelAccommodation *)accommodationRecieved;
@end
