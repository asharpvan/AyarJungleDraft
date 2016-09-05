//
//  HotelReview.m
//  Boilerplate
//
//  Created by Pranav Sah on 26/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "HotelReview.h"

@implementation HotelReview


- (id)initWithCoder:(NSCoder *)decoder {
   
    if (self = [super init]) {
        
        
        self.positiveReviewCount = [decoder decodeObjectForKey:@"positiveReviewCount"];
        self.negativeReviewCount = [decoder decodeObjectForKey:@"negativeReviewCount"];
        self.timesReviewed = [decoder decodeObjectForKey:@"timesReviewed"];
       }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    
    [encoder encodeObject:self.positiveReviewCount forKey:@"positiveReviewCount"];
    [encoder encodeObject:self.negativeReviewCount forKey:@"negativeReviewCount"];
    [encoder encodeObject:self.timesReviewed forKey:@"timesReviewed"];
    
}

-(BOOL) hasReviewChangedOverTime:(HotelReview *)reviewRecieved {
    
    if([self.positiveReviewCount isEqualToNumber:reviewRecieved.positiveReviewCount] &&
       [self.negativeReviewCount isEqualToNumber:reviewRecieved.negativeReviewCount] &&
       [self.timesReviewed isEqualToNumber:reviewRecieved.timesReviewed])return FALSE;
    return TRUE;
}

-(void) dealloc {
    
    self.positiveReviewCount = nil;
    self.negativeReviewCount = nil;
    self.timesReviewed = nil;
//    NSLog(@"Booyeah!! Hotel Review Successfully dealloc~ed!!");
}
@end
