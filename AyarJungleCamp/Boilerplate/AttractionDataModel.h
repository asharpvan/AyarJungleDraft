//
//  AttractionDataModel.h
//  Boilerplate
//
//  Created by Pranav Sah on 06/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AttractionDataModel : NSObject

@property(nonatomic,strong) NSNumber *attractionID;
@property(nonatomic,strong) NSString *attractionName;
@property(nonatomic,strong) NSString *attractionCity;
@property(nonatomic,strong) NSString *attractionState;
@property(nonatomic,strong) NSString *attractionPin;
@property(nonatomic,strong) NSString *attractionContact;
@property(nonatomic,assign) BOOL isAttractionInNainital;
//@property(nonatomic,strong) NSNumber *attractionEstablishmentYear;
@property(nonatomic,assign) CLLocationCoordinate2D attractionCoordinates;
@property(nonatomic,strong) NSNumber *attractionDistance;
@property(nonatomic,strong) NSString *attractionImageName;


-(instancetype) initWithId:(NSNumber *)attractionID name:(NSString *)name city:(NSString *)city state:(NSString *)state pin:(NSString *)pin contact:(NSString *)contact isLocal:(BOOL)isLocal coordinates:(CLLocationCoordinate2D)coordinates  distance:(NSNumber *)distance andImageName:(NSString *)imageName;
-(instancetype) initLocalAttraction;
-(instancetype) initAroundAttraction;
@end
