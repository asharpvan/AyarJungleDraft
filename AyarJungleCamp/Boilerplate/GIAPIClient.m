//
//  GIAPIClient.m
//  Boilerplate
//
//  Created by Pranav Sah on 26/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "GIAPIClient.h"
#import "HotelProfile.h"
#import "HotelRating.h"
#import "HotelReview.h"
#import "AFNetworking.h"

@implementation GIAPIClient {
    
    AFHTTPSessionManager *manager;
}

-(instancetype) init {
    
    self = [super init];
    if(self) {

        manager = [AFHTTPSessionManager manager];
        [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    }
    return self;
}


-(void) fetchHotelDetailsForProfile:(HotelProfileFetchCompletion) complete {
    
    
    [manager GET:@"https://ugc.goibibo.com/api/Hotels/getRatings?app_id=9b87cc53&app_key=7ab9aeb357403ad48e687d152c878379&vid=5471802327961501541" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        HotelRating *hotelRating = [HotelRating new];
        [hotelRating setAmenitiesRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"amenitiesRating"]floatValue]]];
        [hotelRating setFoodRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"fdRating"]floatValue]]];
        [hotelRating setLocationRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"locRating"]floatValue]]];
        [hotelRating setCleanlinessRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"cleanlinessRating"]floatValue]]];
        [hotelRating setHotelRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"hotelRating"]floatValue]]];
        [hotelRating setValueForMoneyRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"vfmRating"]floatValue]]];
        
        HotelReview *hotelReview = [HotelReview new];
        [hotelReview setPositiveReviewCount:[NSNumber numberWithFloat:[[responseObject valueForKeyPath:@"filteredReviewCounts.positive"]floatValue]]];
        [hotelReview setNegativeReviewCount:[NSNumber numberWithFloat:[[responseObject valueForKeyPath:@"filteredReviewCounts.negative"]floatValue]]];
        [hotelReview setTimesReviewed:[NSNumber numberWithFloat:[[responseObject valueForKey:@"reviewCount"]floatValue]]];
        
        HotelProfile *hotelDetails = [HotelProfile new];
        [hotelDetails setHotelRating:hotelRating];
        [hotelDetails setHotelReview:hotelReview];
        [hotelDetails setHotelRecommendedByPercentage:[NSNumber numberWithFloat:[[responseObject valueForKey:@"recommendationPercent"]floatValue]]];
        [hotelDetails setHotelCoordinates:CLLocationCoordinate2DMake([[responseObject valueForKey:@"latitude"]floatValue], [[responseObject valueForKey:@"longitude"]floatValue])];
        
        if(complete) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(hotelDetails,nil);
            });
        }
    
    } failure:^(NSURLSessionTask *operation, NSError *error) {
     
        NSLog(@"error : %@",[error localizedDescription]);
        if(complete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(nil,error);
            });
        }
    }];
}
@end
