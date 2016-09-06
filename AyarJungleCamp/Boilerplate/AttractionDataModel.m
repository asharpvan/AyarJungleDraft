//
//  AttractionDataModel.m
//  Boilerplate
//
//  Created by Pranav Sah on 06/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "AttractionDataModel.h"

@implementation AttractionDataModel


-(instancetype) initWithId:(NSNumber *)attractionID name:(NSString *)name city:(NSString *)city state:(NSString *)state pin:(NSString *)pin contact:(NSString *)contact isLocal:(BOOL)isLocal coordinates:(CLLocationCoordinate2D)coordinates  distance:(NSNumber *)distance andImageName:(NSString *)imageName {
    
    self = [super init];
    if(self) {
        
        [self setAttractionID:attractionID];
        [self setAttractionName:name];
        [self setAttractionCity:city];
        [self setAttractionState:state];
        [self setAttractionPin:pin];
        [self setAttractionContact:contact];
        [self setIsAttractionInNainital:isLocal];
        [self setAttractionCoordinates:coordinates];
        [self setAttractionDistance:distance];
        [self setAttractionImageName:imageName];
    }
    return self;
}

-(instancetype) initLocalAttraction {
    
    self = [super init];
    if(self) {
        
        [self setAttractionName:@"NainaDevi Temple"];
        [self setAttractionImageName:@"AJC_Restaurant.png"];
        [self setAttractionDistance:[NSNumber numberWithInt:2]];
        [self setIsAttractionInNainital:TRUE];
    }
    return self;
}

-(instancetype) initAroundAttraction {
    
    self = [super init];
    if(self) {
        
        [self setAttractionName:@"Almora, Almora"];
        [self setAttractionImageName:@"AJC_Campground.png"];
        [self setAttractionDistance:[NSNumber numberWithInt:65]];
        [self setIsAttractionInNainital:FALSE];
    }
    return self;
}


@end
