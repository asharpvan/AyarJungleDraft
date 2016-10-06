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
#import "ReviewDetails.h"
#import "AFNetworking.h"

static BOOL isPerformingQuery;


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
    
    [self setisQueryExecutionState:FALSE];
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
        

        HotelProfile *hotelDetails = [[HotelProfile alloc]init];
        [hotelDetails setHotelRating:hotelRating];
        [hotelDetails setHotelReview:hotelReview];
        [hotelDetails setHotelRecommendedByPercentage:[NSNumber numberWithFloat:[[responseObject valueForKey:@"recommendationPercent"]floatValue]]];
//        [hotelDetails setHotelCoordinates:CLLocationCoordinate2DMake([[responseObject valueForKey:@"latitude"]floatValue], [[responseObject valueForKey:@"longitude"]floatValue])];
       
//        [hotelDetails displayHotelProfile];
 
#pragma mark <Testing Code>
//        HotelRating *hotelRatingClone = [HotelRating new];
//        [hotelRatingClone setAmenitiesRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"amenitiesRating"]floatValue]]];
//        [hotelRatingClone setFoodRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"fdRating"]floatValue]]];
//        [hotelRatingClone setLocationRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"locRating"]floatValue]]];
//        [hotelRatingClone setCleanlinessRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"cleanlinessRating"]floatValue]]];
//        [hotelRatingClone setHotelRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"hotelRating"]floatValue]]];
//        [hotelRatingClone setValueForMoneyRating:[NSNumber numberWithFloat:[[responseObject valueForKey:@"vfmRating"]floatValue]]];
//        
//        
//        HotelReview *hotelReviewClone = [HotelReview new];
//        [hotelReviewClone setPositiveReviewCount:[NSNumber numberWithFloat:[[responseObject valueForKeyPath:@"filteredReviewCounts.positive"]floatValue]]];
//        [hotelReviewClone setNegativeReviewCount:[NSNumber numberWithFloat:[[responseObject valueForKeyPath:@"filteredReviewCounts.negative"]floatValue]]];
//        [hotelReviewClone setTimesReviewed:[NSNumber numberWithFloat:[[responseObject valueForKey:@"reviewCount"]floatValue]]];
//        
//        HotelProfile *hotelReal = [[HotelProfile alloc]initAyarReal];
//        [hotelReal setHotelRating:hotelRating];
//        [hotelReal setHotelReview:hotelReview];
//        [hotelReal setHotelRecommendedByPercentage:[NSNumber numberWithFloat:[[responseObject valueForKey:@"recommendationPercent"]floatValue]]];
//        [hotelReal setHotelCoordinates:CLLocationCoordinate2DMake(1.0, 1.0)];
//        [hotelReal displayHotelProfile];
//
//
//        //Actual Clone
//        HotelProfile *hotelClone = [[HotelProfile alloc]initAyarReal];
//        [hotelClone setHotelRating:hotelRating];
//        [hotelClone setHotelReview:hotelReview];
//        [hotelClone setHotelRecommendedByPercentage:[NSNumber numberWithFloat:[[responseObject valueForKey:@"recommendationPercent"]floatValue]]];
//        [hotelClone setHotelCoordinates:CLLocationCoordinate2DMake(1.0, 1.1)];
//
//        //Fake Clone
//        HotelProfile *hotelClone = [[HotelProfile alloc]initAyarClone];
//        [hotelClone setHotelRating:hotelRatingClone];
//        [hotelClone setHotelReview:hotelReviewClone];
//        [hotelClone setHotelRecommendedByPercentage:[NSNumber numberWithFloat:[[responseObject valueForKey:@"recommendationPercent"]floatValue]]];
//        [hotelClone setHotelCoordinates:CLLocationCoordinate2DMake(1.0, 1.5)];
//        [hotelClone displayHotelProfile];
        
        
//        if([hotelClone hasProfileChangedOverTime:hotelReal]){
//            NSLog(@"Both are same");
//        }else {
//            NSLog(@"Both are different");
//        }
        
        
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

-(void) fetchReviewsWithOffset:(NSNumber *)offset onCompletion:(HotelReviewFetchCompletion)complete {
    
    [self setisQueryExecutionState:TRUE];
    [manager GET:[NSString stringWithFormat:@"https://ugc.goibibo.com/api/HotelReviews/forWeb?app_id=9b87cc53&app_key=7ab9aeb357403ad48e687d152c878379&vid=5471802327961501541&limit=10&offset=%@",[offset stringValue]] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {

        __block NSMutableArray *arrayOfReviews = [NSMutableArray new];

        for(id singleResponseObject in responseObject) {
            
            ReviewDetails *individualReview = [ReviewDetails new];
            [individualReview setCheckInOn:[singleResponseObject valueForKeyPath:@"bookingDetails.checkin"]];
            [individualReview setStayedFor:[singleResponseObject valueForKeyPath:@"bookingDetails.roomNights"]];
            [individualReview setCreatedAt:[singleResponseObject valueForKeyPath:@"createdAt"]];
            [individualReview setReviewText:[singleResponseObject valueForKeyPath:@"reviewContent"]];
            [individualReview setTimesViewed:[NSNumber numberWithInteger:[[singleResponseObject valueForKeyPath:@"viewedCount"]integerValue]]];
            [individualReview setTotalRating:[NSNumber numberWithInteger:[[singleResponseObject valueForKeyPath:@"totalRating"]integerValue]]];
            [individualReview setReviewerLastName:[singleResponseObject valueForKeyPath:@"reviewer.lastName"]];
            [individualReview setReviewerFirstName:[singleResponseObject valueForKeyPath:@"reviewer.firstName"]];
            
            [arrayOfReviews addObject:individualReview];
        }

        if(complete) {

            [self setisQueryExecutionState:FALSE];
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(arrayOfReviews,nil);
            });
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"error : %@",[error localizedDescription]);
        if(complete) {
            [self setisQueryExecutionState:FALSE];
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(nil,error);
            });
        }
    }];
}

- (BOOL)getIsQueryExecuting {
    
    return isPerformingQuery;
}


- (void)setisQueryExecutionState:(BOOL)state {
    
    isPerformingQuery = state;
}

//-  (void)updateSkipValue {
//    
//    skip = skip + limit;
//}
//
//- (void)revertSkipValueOnError {
//    
//    skip = skip - limit;
//}
//
//- (void)resetSkipValue {
//    
//    skip = 0;
//}

@end
