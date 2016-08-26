//
//  GIAPIClient.h
//  Boilerplate
//
//  Created by Pranav Sah on 26/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotelProfile;


typedef void(^HotelProfileFetchCompletion) (HotelProfile *, NSError *);

@interface GIAPIClient : NSObject 
-(instancetype)init;

-(void) fetchHotelDetailsForProfile:(HotelProfileFetchCompletion) complete;
@end
