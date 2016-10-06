//
//  ReviewDetails.h
//  Boilerplate
//
//  Created by Pranav Sah on 14/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewDetails : NSObject

@property(nonatomic,assign) NSNumber *timesViewed;
@property(nonatomic,strong) NSString *createdAt;
@property(nonatomic,assign) NSNumber *totalRating;
@property(nonatomic,strong) NSString *reviewerFirstName;
@property(nonatomic,strong) NSString *reviewerLastName;
@property(nonatomic,strong) NSString *reviewText;
@property(nonatomic,strong) NSString *checkInOn;
@property(nonatomic,strong) NSString *stayedFor;

@end
