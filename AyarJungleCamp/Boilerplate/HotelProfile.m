//
//  HotelProfile.m
//  Boilerplate
//
//  Created by Pranav Sah on 26/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "HotelProfile.h"
#import "HotelReview.h"
#import "HotelRating.h"
#import "HotelAccommodation.h"


@implementation HotelProfile


-(instancetype) init {
    
    self = [super init];
    if(self) {
        
        [self setHotelName:@"Ayar Jungle Camp"];
        [self setHotelSynopsis:@"Some Synopsis here"];
        [self setHotelHistory:@"Some History here"];
        [self setHotelStreetAddr1:@"Barapathar - Sherwood College Road"];
        [self setHotelStreetAddr2:@"Mallital"];
        [self setHotelCity:@"Nainital"];
        [self setHotelPin:@"263001"];
        [self setHotelContact1:@"+91 9999-518-091"];
        [self setHotelContact2:@"+91-05942-235189"];
        
        HotelAccommodation *tent = [HotelAccommodation new];
        [tent setRoomName:@"Tent"];
        [tent setRoomCapacity:[NSNumber numberWithInteger:2]];
        [tent setRoomPrice:[NSNumber numberWithInteger:1800]];
        [tent setRoomTotal:[NSNumber numberWithInteger:18]];
        [tent setRoomImage1:@"Tent1.png"];
        [tent setRoomImage2:@"Tent2.png"];
        [tent setRoomImage3:@"Tent3.png"];
        
        HotelAccommodation *doubleBedded = [HotelAccommodation new];
        [doubleBedded setRoomName:@"Double Bedded Cottage"];
        [doubleBedded setRoomCapacity:[NSNumber numberWithInteger:2]];
        [doubleBedded setRoomPrice:[NSNumber numberWithInteger:3000]];
        [doubleBedded setRoomTotal:[NSNumber numberWithInteger:10]];
        [doubleBedded setRoomImage1:@"DB1.png"];
        [doubleBedded setRoomImage2:@"DB2.png"];
        [doubleBedded setRoomImage3:@"DB3.png"];
        
        HotelAccommodation *fourBedded = [HotelAccommodation new];
        [fourBedded setRoomName:@"Four Bedded Cottage"];
        [fourBedded setRoomCapacity:[NSNumber numberWithInteger:4]];
        [fourBedded setRoomPrice:[NSNumber numberWithInteger:4000]];
        [fourBedded setRoomTotal:[NSNumber numberWithInteger:3]];
        [fourBedded setRoomImage1:@"FB1.png"];
        [fourBedded setRoomImage2:@"FB2.png"];
        [fourBedded setRoomImage3:@"FB3.png"];
        
        HotelAccommodation *machaan = [HotelAccommodation new];
        [machaan setRoomName:@"Machaan"];
        [machaan setRoomCapacity:[NSNumber numberWithInteger:2]];
        [machaan setRoomPrice:[NSNumber numberWithInteger:3500]];
        [machaan setRoomTotal:[NSNumber numberWithInteger:3]];
        [machaan setRoomImage1:@"Mach1.png"];
        [machaan setRoomImage2:@"Mach2.png"];
        [machaan setRoomImage3:@"Mach3.png"];
        
        [self setHotelAccommodationList:[NSArray arrayWithObjects:tent, doubleBedded,fourBedded,machaan, nil]];
        
        [self setHotelEstablishmentYear:[NSNumber numberWithInt:2009]];
    }
    return self;
}

-(void) displayHotelProfile {
   
    NSLog(@"\n************ About ****************");
    NSLog(@"Hotel Name  : %@",[self hotelName]);
    NSLog(@"Hotel Synopsis  : %@",[self hotelSynopsis]);
    NSLog(@"Hotel History  : %@",[self hotelHistory]);
    NSLog(@"Hotel Addr 1  : %@",[self hotelStreetAddr1]);
    NSLog(@"Hotel Addr 2  : %@",[self hotelStreetAddr2]);
    NSLog(@"Hotel City : %@",[self hotelCity]);
    NSLog(@"Hotel Pin : %@",[self hotelPin]);
    NSLog(@"Hotel Contact 1 : %@",[self hotelContact1]);
    NSLog(@"Hotel Contact 2 : %@",[self hotelContact2]);
    NSLog(@"Hotel Established In : %@",[self hotelEstablishmentYear]);
    NSLog(@"Hotel Recommended by  : %@",[self hotelRecommendedByPercentage]);
    NSLog(@"Coordinates : %f,%f",[self hotelCoordinates].longitude ,[self hotelCoordinates].latitude);
    NSLog(@"Hotel Recommended by  : %@",[self hotelRecommendedByPercentage]);
    
    for(HotelAccommodation *accommodationType in  [self hotelAccommodationList]) {
        
        NSLog(@"**** %@ ****",[accommodationType roomName]);
        NSLog(@"Image 1 %@",[accommodationType roomImage1]);
        NSLog(@"Image 2 %@",[accommodationType roomImage2]);
        NSLog(@"Image 3 %@",[accommodationType roomImage3]);
        NSLog(@"Price %@",[accommodationType roomPrice]);
        NSLog(@"Capacity %@",[accommodationType roomCapacity]);
        NSLog(@"Total Room Count %@",[accommodationType roomTotal]);
    }

    NSLog(@"\n************ RANKING ****************");
    NSLog(@"Amenities : %@",[[self hotelRating] amenitiesRating]);
    NSLog(@"Cleanliness : %@",[[self hotelRating] cleanlinessRating]);
    NSLog(@"Food : %@",[[self hotelRating] foodRating]);
    NSLog(@"Location : %@",[[self hotelRating] locationRating]);
    NSLog(@"Hotel : %@",[[self hotelRating] hotelRating]);
    NSLog(@"Value for Money : %@",[[self hotelRating] valueForMoneyRating]);
    NSLog(@"\n************ REVIEW ****************");
    NSLog(@"Positive  : %@",[[self hotelReview] positiveReviewCount]);
    NSLog(@"Negative  : %@",[[self hotelReview] negativeReviewCount]);
    NSLog(@"Total Review Count  : %@",[[self hotelReview] timesReviewed]);
   
}

@end
