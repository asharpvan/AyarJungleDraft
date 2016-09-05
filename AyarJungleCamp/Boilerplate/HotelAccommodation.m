//
//  HotelAccommodation.m
//  Boilerplate
//
//  Created by Pranav Sah on 27/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "HotelAccommodation.h"

@implementation HotelAccommodation

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        
        
        self.roomName = [decoder decodeObjectForKey:@"roomName"];
        self.roomPrice = [decoder decodeObjectForKey:@"roomPrice"];
        self.roomImage1 = [decoder decodeObjectForKey:@"roomImage1"];
        self.roomImage2 = [decoder decodeObjectForKey:@"roomImage2"];
        self.roomImage3 = [decoder decodeObjectForKey:@"roomImage3"];
        self.roomTotal = [decoder decodeObjectForKey:@"roomTotal"];
        self.roomCapacity = [decoder decodeObjectForKey:@"roomCapacity"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    
    [encoder encodeObject:self.roomName forKey:@"roomName"];
    [encoder encodeObject:self.roomPrice forKey:@"roomPrice"];
    [encoder encodeObject:self.roomImage1 forKey:@"roomImage1"];
    [encoder encodeObject:self.roomImage2 forKey:@"roomImage2"];
    [encoder encodeObject:self.roomImage3 forKey:@"roomImage3"];
    [encoder encodeObject:self.roomTotal forKey:@"roomTotal"];
    [encoder encodeObject:self.roomCapacity forKey:@"roomCapacity"];
    
}

-(BOOL) hasHotelAccommodationDetailsChangedOverTime:(HotelAccommodation *)accommodationRecieved {
    
    if([self.roomName isEqualToString:accommodationRecieved.roomName] &&
       [self.roomPrice isEqualToNumber:accommodationRecieved.roomPrice] &&
       [self.roomImage1 isEqualToString:accommodationRecieved.roomImage1] &&
       [self.roomImage2 isEqualToString:accommodationRecieved.roomImage2] &&
       [self.roomImage3 isEqualToString:accommodationRecieved.roomImage3] &&
       [self.roomTotal isEqualToNumber:accommodationRecieved.roomTotal] &&
       [self.roomCapacity isEqualToNumber:accommodationRecieved.roomCapacity])return FALSE;
    return TRUE;
}

-(void) dealloc {
    
    self.roomName = nil;
    self.roomPrice = nil;
    self.roomImage1 = nil;
    self.roomImage2 = nil;
    self.roomImage3 = nil;
    self.roomTotal = nil;
    self.roomCapacity = nil;
//    NSLog(@"Booyeah!! Hotel Accommodation for %@ Successfully dealloc~ed!!",self.roomName);
}

@end
