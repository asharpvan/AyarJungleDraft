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

@implementation HotelProfile

-(void) displayHotelProfile {
    
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
    NSLog(@"\n************ Others ****************");
    NSLog(@"Recommended By (in Percentage)  : %@",[self recommendedPercentage]);
    NSLog(@"Longitude / Lattitude : %@,%@",[self longitudeDegree],[self latitudeDegree]);

}

@end
