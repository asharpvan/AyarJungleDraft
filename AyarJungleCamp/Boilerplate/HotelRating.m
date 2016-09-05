//
//  HotelRating.m
//  Boilerplate
//
//  Created by Pranav Sah on 26/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "HotelRating.h"

@implementation HotelRating

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        
        
        self.cleanlinessRating = [decoder decodeObjectForKey:@"cleanlinessRating"];
        self.amenitiesRating = [decoder decodeObjectForKey:@"amenitiesRating"];
        self.locationRating = [decoder decodeObjectForKey:@"locationRating"];
        self.foodRating = [decoder decodeObjectForKey:@"foodRating"];
        self.hotelRating = [decoder decodeObjectForKey:@"hotelRating"];
        self.valueForMoneyRating = [decoder decodeObjectForKey:@"valueForMoneyRating"];
         }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    
    [encoder encodeObject:self.cleanlinessRating forKey:@"cleanlinessRating"];
    [encoder encodeObject:self.amenitiesRating forKey:@"amenitiesRating"];
    [encoder encodeObject:self.locationRating forKey:@"locationRating"];
    [encoder encodeObject:self.foodRating forKey:@"foodRating"];
    [encoder encodeObject:self.hotelRating forKey:@"hotelRating"];
    [encoder encodeObject:self.valueForMoneyRating forKey:@"valueForMoneyRating"];
    
}

-(BOOL) hasRatingChangedOverTime:(HotelRating *)ratingRecieved {
    
    if([self.cleanlinessRating isEqualToNumber:ratingRecieved.cleanlinessRating] && [self.amenitiesRating isEqualToNumber:ratingRecieved.amenitiesRating] && [self.locationRating isEqualToNumber:ratingRecieved.locationRating] && [self.foodRating isEqualToNumber:ratingRecieved.foodRating] && [self.hotelRating isEqualToNumber:ratingRecieved.hotelRating] && [self.valueForMoneyRating isEqualToNumber:ratingRecieved.valueForMoneyRating])return FALSE;
   
    return TRUE;
}

-(void) dealloc {
    
    self.cleanlinessRating = nil;
    self.amenitiesRating = nil;
    self.locationRating = nil;
    self.foodRating = nil;
    self.hotelRating = nil;
    self.valueForMoneyRating = nil;
//    NSLog(@"Booyeah!! Hotel Rating Successfully dealloc~ed!!");
}

@end
