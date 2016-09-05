//
//  HotelReview.h
//  Boilerplate
//
//  Created by Pranav Sah on 26/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelReview : NSObject

@property(nonatomic,strong) NSNumber *positiveReviewCount;
@property(nonatomic,strong) NSNumber *negativeReviewCount;
@property(nonatomic,strong) NSNumber *timesReviewed;


-(BOOL) hasReviewChangedOverTime:(HotelReview *)reviewRecieved;
@end
