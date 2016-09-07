//
//  HotelProfile.m
//  Boilerplate
//
//  Created by Pranav Sah on 26/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "HotelProfile.h"
#import "HotelReview.h"
#import "HotelRating.h"
#import "HotelAccommodation.h"


@implementation HotelProfile


-(instancetype) init {
    
    self = [super init];
    if(self) {
        
        [self setHotelName:@"Ayar Jungle Camp"];
        [self setHotelSynopsis:@"Some Synopsis here"];
        [self setHotelHistory:@"Some History here"];
        [self setHotelStreetAddr1:@"Barapathar - Sherwood College Road"];
        [self setHotelStreetAddr2:@"Mallital"];
        [self setHotelCity:@"Nainital"];
        [self setHotelPin:@"263001"];
        [self setHotelContact1:@"+91 9999-518-091"];
        [self setHotelContact2:@"+91-05942-235189"];
        
        HotelAccommodation *tent = [HotelAccommodation new];
        [tent setRoomName:@"Tent"];
        [tent setAccomodationType:[NSNumber numberWithUnsignedInteger:AccommodationTypeTent]];
        [tent setRoomCapacity:[NSNumber numberWithInteger:2]];
        [tent setRoomPrice:[NSNumber numberWithInteger:1800]];
        [tent setRoomTotal:[NSNumber numberWithInteger:18]];
        [tent setRoomImage1:@"Tent1.png"];
        [tent setRoomImage2:@"Tent2.png"];
        [tent setRoomImage3:@"Tent3.png"];
        
        HotelAccommodation *doubleBedded = [HotelAccommodation new];
        [doubleBedded setRoomName:@"Double Bedded Cottage"];
        [doubleBedded setAccomodationType:[NSNumber numberWithUnsignedInteger:AccommodationType2Bedded]];
        [doubleBedded setRoomCapacity:[NSNumber numberWithInteger:2]];
        [doubleBedded setRoomPrice:[NSNumber numberWithInteger:3000]];
        [doubleBedded setRoomTotal:[NSNumber numberWithInteger:10]];
        [doubleBedded setRoomImage1:@"DB1.png"];
        [doubleBedded setRoomImage2:@"DB2.png"];
        [doubleBedded setRoomImage3:@"DB3.png"];
        
        HotelAccommodation *fourBedded = [HotelAccommodation new];
        [fourBedded setRoomName:@"Four Bedded Cottage"];
        [fourBedded setAccomodationType:[NSNumber numberWithUnsignedInteger:AccommodationType4Bedded]];
        [fourBedded setRoomCapacity:[NSNumber numberWithInteger:4]];
        [fourBedded setRoomPrice:[NSNumber numberWithInteger:4000]];
        [fourBedded setRoomTotal:[NSNumber numberWithInteger:3]];
        [fourBedded setRoomImage1:@"FB1.png"];
        [fourBedded setRoomImage2:@"FB2.png"];
        [fourBedded setRoomImage3:@"FB3.png"];
        
        HotelAccommodation *machaan = [HotelAccommodation new];
        [machaan setRoomName:@"Machaan"];
        [machaan setAccomodationType:[NSNumber numberWithUnsignedInteger:AccommodationTypeMachan]];
        [machaan setRoomCapacity:[NSNumber numberWithInteger:2]];
        [machaan setRoomPrice:[NSNumber numberWithInteger:3500]];
        [machaan setRoomTotal:[NSNumber numberWithInteger:3]];
        [machaan setRoomImage1:@"Mach1.png"];
        [machaan setRoomImage2:@"Mach2.png"];
        [machaan setRoomImage3:@"Mach3.png"];
        
        [self setHotelAccommodationList:[NSArray arrayWithObjects:tent, doubleBedded,fourBedded,machaan, nil]];
        
        [self setHotelEstablishmentYear:[NSNumber numberWithInt:2009]];
    }
    return self;
}


-(instancetype) initAyarReal {
    
    self = [super init];
    if(self) {
        
        [self setHotelName:@"Ayar Jungle Camp"];
        [self setHotelSynopsis:@"Some Synopsis here"];
        [self setHotelHistory:@"Some History here"];
        [self setHotelStreetAddr1:@"Barapathar - Sherwood College Road"];
        [self setHotelStreetAddr2:@"Mallital"];
        [self setHotelCity:@"Nainital"];
        [self setHotelPin:@"263001"];
        [self setHotelContact1:@"+91 9999-518-091"];
        [self setHotelContact2:@"+91-05942-235189"];
        
        HotelAccommodation *tent = [HotelAccommodation new];
        [tent setRoomName:@"Tent"];
        [tent setAccomodationType:[NSNumber numberWithUnsignedInteger:AccommodationTypeTent]];
        [tent setRoomCapacity:[NSNumber numberWithInteger:2]];
        [tent setRoomPrice:[NSNumber numberWithInteger:1800]];
        [tent setRoomTotal:[NSNumber numberWithInteger:18]];
        [tent setRoomImage1:@"Tent1.png"];
        [tent setRoomImage2:@"Tent2.png"];
        [tent setRoomImage3:@"Tent3.png"];
        
        HotelAccommodation *doubleBedded = [HotelAccommodation new];
        [doubleBedded setRoomName:@"Double Bedded Cottage"];
        [doubleBedded setAccomodationType:[NSNumber numberWithUnsignedInteger:AccommodationType2Bedded]];
        [doubleBedded setRoomCapacity:[NSNumber numberWithInteger:2]];
        [doubleBedded setRoomPrice:[NSNumber numberWithInteger:3000]];
        [doubleBedded setRoomTotal:[NSNumber numberWithInteger:10]];
        [doubleBedded setRoomImage1:@"DB1.png"];
        [doubleBedded setRoomImage2:@"DB2.png"];
        [doubleBedded setRoomImage3:@"DB3.png"];
        
        HotelAccommodation *fourBedded = [HotelAccommodation new];
        [fourBedded setRoomName:@"Four Bedded Cottage"];
        [fourBedded setAccomodationType:[NSNumber numberWithUnsignedInteger:AccommodationType4Bedded]];
        [fourBedded setRoomCapacity:[NSNumber numberWithInteger:4]];
        [fourBedded setRoomPrice:[NSNumber numberWithInteger:4000]];
        [fourBedded setRoomTotal:[NSNumber numberWithInteger:3]];
        [fourBedded setRoomImage1:@"FB1.png"];
        [fourBedded setRoomImage2:@"FB2.png"];
        [fourBedded setRoomImage3:@"FB3.png"];
        
        HotelAccommodation *machaan = [HotelAccommodation new];
        [machaan setRoomName:@"Machaan"];
        [machaan setAccomodationType:[NSNumber numberWithUnsignedInteger:AccommodationTypeMachan]];
        [machaan setRoomCapacity:[NSNumber numberWithInteger:2]];
        [machaan setRoomPrice:[NSNumber numberWithInteger:3500]];
        [machaan setRoomTotal:[NSNumber numberWithInteger:3]];
        [machaan setRoomImage1:@"Mach1.png"];
        [machaan setRoomImage2:@"Mach2.png"];
        [machaan setRoomImage3:@"Mach3.png"];
        
        [self setHotelAccommodationList:[NSArray arrayWithObjects:tent, doubleBedded,fourBedded,machaan, nil]];
        
        [self setHotelEstablishmentYear:[NSNumber numberWithInt:2010]];
    }
    return self;
}


-(instancetype) initAyarClone {
    
    self = [super init];
    if(self) {
        
        [self setHotelName:@"Ayar Jungle Camp"];
        [self setHotelSynopsis:@"Some Synopsis here"];
        [self setHotelHistory:@"Some History here"];
        [self setHotelStreetAddr1:@"Barapathar - Sherwood College Road"];
        [self setHotelStreetAddr2:@"Mallital"];
        [self setHotelCity:@"Nainital"];
        [self setHotelPin:@"263001"];
        [self setHotelContact1:@"+91 9999-518-091"];
        [self setHotelContact2:@"+91-05942-235189"];
        
        HotelAccommodation *tent = [HotelAccommodation new];
        [tent setRoomName:@"Tent"];
        [tent setRoomCapacity:[NSNumber numberWithInteger:2]];
        [tent setRoomPrice:[NSNumber numberWithInteger:1800]];
        [tent setRoomTotal:[NSNumber numberWithInteger:18]];
        [tent setRoomImage1:@"Tent1.png"];
        [tent setRoomImage2:@"Tent2.png"];
        [tent setRoomImage3:@"Tent3.png"];
        
        HotelAccommodation *doubleBedded = [HotelAccommodation new];
        [doubleBedded setRoomName:@"Double Bedded Cottage"];
        [doubleBedded setRoomCapacity:[NSNumber numberWithInteger:2]];
        [doubleBedded setRoomPrice:[NSNumber numberWithInteger:3000]];
        [doubleBedded setRoomTotal:[NSNumber numberWithInteger:10]];
        [doubleBedded setRoomImage1:@"DB1.png"];
        [doubleBedded setRoomImage2:@"DB2.png"];
        [doubleBedded setRoomImage3:@"DB3.png"];
        
        HotelAccommodation *fourBedded = [HotelAccommodation new];
        [fourBedded setRoomName:@"Four Bedded Cottage"];
        [fourBedded setRoomCapacity:[NSNumber numberWithInteger:4]];
        [fourBedded setRoomPrice:[NSNumber numberWithInteger:4000]];
        [fourBedded setRoomTotal:[NSNumber numberWithInteger:3]];
        [fourBedded setRoomImage1:@"FB19.png"];
        [fourBedded setRoomImage2:@"FB2.png"];
        [fourBedded setRoomImage3:@"FB3.png"];
        
        HotelAccommodation *machaan = [HotelAccommodation new];
        [machaan setRoomName:@"Machaan"];
        [machaan setRoomCapacity:[NSNumber numberWithInteger:2]];
        [machaan setRoomPrice:[NSNumber numberWithInteger:3500]];
        [machaan setRoomTotal:[NSNumber numberWithInteger:3]];
        [machaan setRoomImage1:@"Mach1.png"];
        [machaan setRoomImage2:@"Mach2.png"];
        [machaan setRoomImage3:@"Mach3.png"];
        [self setHotelAccommodationList:[NSArray arrayWithObjects:tent, doubleBedded,fourBedded,machaan, nil]];
        [self setHotelEstablishmentYear:[NSNumber numberWithInt:2010]];
    }
    return self;
}


-(void) displayCompleteHotelProfile {
   
    NSLog(@"\n************ About ****************");
    NSLog(@"Hotel Name  : %@",[self hotelName]);
    NSLog(@"Hotel Synopsis  : %@",[self hotelSynopsis]);
    NSLog(@"Hotel History  : %@",[self hotelHistory]);
    NSLog(@"Hotel Addr 1  : %@",[self hotelStreetAddr1]);
    NSLog(@"Hotel Addr 2  : %@",[self hotelStreetAddr2]);
    NSLog(@"Hotel City : %@",[self hotelCity]);
    NSLog(@"Hotel Pin : %@",[self hotelPin]);
    NSLog(@"Hotel Contact 1 : %@",[self hotelContact1]);
    NSLog(@"Hotel Contact 2 : %@",[self hotelContact2]);
    NSLog(@"Hotel Established In : %@",[self hotelEstablishmentYear]);
    NSLog(@"Coordinates : %f,%f",[self hotelCoordinates].longitude ,[self hotelCoordinates].latitude);
    NSLog(@"Hotel Recommended by  : %@",[self hotelRecommendedByPercentage]);
    for(HotelAccommodation *accommodationType in  [self hotelAccommodationList]) {
        NSLog(@"**** %@ ****",[accommodationType roomName]);
        NSLog(@"Image 1 %@",[accommodationType roomImage1]);
        NSLog(@"Image 2 %@",[accommodationType roomImage2]);
        NSLog(@"Image 3 %@",[accommodationType roomImage3]);
        NSLog(@"Price %@",[accommodationType roomPrice]);
        NSLog(@"Capacity %@",[accommodationType roomCapacity]);
        NSLog(@"Total Room Count %@",[accommodationType roomTotal]);
    }
    NSLog(@"\n************ RANKING ****************");
    NSLog(@"Amenities : %@",[[self hotelRating] amenitiesRating]);
    NSLog(@"Cleanliness : %@",[[self hotelRating] cleanlinessRating]);
    NSLog(@"Food : %@",[[self hotelRating] foodRating]);
    NSLog(@"Location : %@",[[self hotelRating] locationRating]);
    NSLog(@"Hotel : %@",[[self hotelRating] hotelRating]);
    NSLog(@"Value for Money : %@",[[self hotelRating] valueForMoneyRating]);
    NSLog(@"\n************ REVIEW ****************");
    NSLog(@"Positive  : %@",[[self hotelReview] positiveReviewCount]);
    NSLog(@"Negative  : %@",[[self hotelReview] negativeReviewCount]);
    NSLog(@"Total Review Count  : %@",[[self hotelReview] timesReviewed]);
   
}


-(void) displaySelectiveHotelProfile {
    
    NSLog(@"\n************ About ****************");
    NSLog(@"Hotel Name  : %@",[self hotelName]);
    NSLog(@"Hotel Recommended by  : %@",[self hotelRecommendedByPercentage]);    
}


- (id)initWithCoder:(NSCoder *)decoder {
    
    if (self = [super init]) {
        
        self.hotelName = [decoder decodeObjectForKey:@"hotelName"];
        self.hotelSynopsis = [decoder decodeObjectForKey:@"hotelSynopsis"];
        self.hotelHistory = [decoder decodeObjectForKey:@"hotelHistory"];
        self.hotelStreetAddr1 = [decoder decodeObjectForKey:@"hotelStreetAddr1"];
        self.hotelStreetAddr2 = [decoder decodeObjectForKey:@"hotelStreetAddr2"];
        self.hotelCity = [decoder decodeObjectForKey:@"hotelCity"];
        self.hotelPin = [decoder decodeObjectForKey:@"hotelPin"];
        self.hotelContact1 = [decoder decodeObjectForKey:@"hotelContact1"];
        self.hotelContact2 = [decoder decodeObjectForKey:@"hotelContact2"];
        self.hotelEstablishmentYear = [decoder decodeObjectForKey:@"hotelEstablishmentYear"];
        self.hotelCoordinates = CLLocationCoordinate2DMake([decoder decodeDoubleForKey:@"hotelCoordinates.Latitude"], [decoder decodeDoubleForKey:@"hotelCoordinates.Longitude"]);
        self.hotelRecommendedByPercentage = [decoder decodeObjectForKey:@"hotelRecommendedByPercentage"];
        self.hotelRating = [decoder decodeObjectForKey:@"hotelRating"];
        self.hotelReview = [decoder decodeObjectForKey:@"hotelReview"];
        self.hotelAccommodationList = [decoder decodeObjectForKey:@"hotelAccommodationList"];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.hotelName forKey:@"hotelName"];
    [encoder encodeObject:self.hotelSynopsis forKey:@"hotelSynopsis"];
    [encoder encodeObject:self.hotelHistory forKey:@"hotelHistory"];
    [encoder encodeObject:self.hotelStreetAddr1 forKey:@"hotelStreetAddr1"];
    [encoder encodeObject:self.hotelStreetAddr2 forKey:@"hotelStreetAddr2"];
    [encoder encodeObject:self.hotelCity forKey:@"hotelCity"];
    [encoder encodeObject:self.hotelPin forKey:@"hotelPin"];
    [encoder encodeObject:self.hotelContact1 forKey:@"hotelContact1"];
    [encoder encodeObject:self.hotelContact2 forKey:@"hotelContact2"];
    [encoder encodeObject:self.hotelEstablishmentYear forKey:@"hotelEstablishmentYear"];
    [encoder encodeDouble:self.hotelCoordinates.latitude forKey:@"hotelCoordinates.Latitude"];
    [encoder encodeDouble:self.hotelCoordinates.longitude forKey:@"hotelCoordinates.Longitude"];
    [encoder encodeObject:self.hotelRecommendedByPercentage forKey:@"hotelRecommendedByPercentage"];
    [encoder encodeObject:self.hotelRating forKey:@"hotelRating"];
    [encoder encodeObject:self.hotelReview forKey:@"hotelReview"];
    [encoder encodeObject:self.hotelAccommodationList forKey:@"hotelAccommodationList"];

}

//Method to check whether or not two Hotel Profile Object are exactly same or not
-(BOOL) hasProfileChangedOverTime:(HotelProfile *)profileRecieved {
    
    if(![self.hotelName isEqualToString:profileRecieved.hotelName] &&
       ![self.hotelSynopsis isEqualToString:profileRecieved.hotelSynopsis] &&
       ![self.hotelHistory isEqualToString:profileRecieved.hotelHistory] &&
       ![self.hotelStreetAddr1 isEqualToString:profileRecieved.hotelStreetAddr1] &&
       ![self.hotelStreetAddr2 isEqualToString:profileRecieved.hotelStreetAddr2] &&
       ![self.hotelCity isEqualToString:profileRecieved.hotelCity] &&
       ![self.hotelPin isEqualToString:profileRecieved.hotelPin] &&
       ![self.hotelContact1 isEqualToString:profileRecieved.hotelContact1] &&
       ![self.hotelContact2 isEqualToString:profileRecieved.hotelContact2] &&
       ![self.hotelEstablishmentYear isEqualToNumber:profileRecieved.hotelEstablishmentYear] &&
       ![self.hotelRecommendedByPercentage isEqualToNumber:profileRecieved.hotelRecommendedByPercentage] &&
       ![self.hotelRating hasRatingChangedOverTime:profileRecieved.hotelRating] &&
       ![self.hotelReview hasReviewChangedOverTime:profileRecieved.hotelReview] &&
       ![self checkIfAccommodationListChangedIn:self.hotelAccommodationList and:profileRecieved.hotelAccommodationList] &&
       ![self checkIfLocationChangedOverIn:self.hotelCoordinates and:profileRecieved.hotelCoordinates]) return TRUE;

    return FALSE;
}


-(BOOL) checkIfAccommodationListChangedIn:(NSArray *)accomodationArray and:(NSArray *) accommodationArray1 {
    
    __block BOOL changedStatus = FALSE;
    for(int i = 0; i <= [accomodationArray count]-1; i++) {
        HotelAccommodation *object1 = (HotelAccommodation *)[accomodationArray objectAtIndex:i];
        HotelAccommodation *object2 = (HotelAccommodation *)[accommodationArray1 objectAtIndex:i];
        if([object1 hasHotelAccommodationDetailsChangedOverTime:object2])
            changedStatus = TRUE;
    }
    return changedStatus;
}

-(BOOL) checkIfLocationChangedOverIn:(CLLocationCoordinate2D) locationOne and:(CLLocationCoordinate2D) locationTwo {

    __block BOOL changedStatus = FALSE;
    if(!(locationOne.latitude == locationTwo.latitude) || !(locationOne.longitude == locationTwo.longitude))
        changedStatus = TRUE;
    return changedStatus;
}

-(void) dealloc {
    
    self.hotelName = nil;
    self.hotelSynopsis = nil;
    self.hotelHistory = nil;
    self.hotelStreetAddr1 = nil;
    self.hotelStreetAddr2 = nil;
    self.hotelCity = nil;
    self.hotelPin = nil;
    self.hotelContact1 = nil;
    self.hotelContact2 = nil;
    self.hotelEstablishmentYear = nil;
    self.hotelRecommendedByPercentage = nil;
    self.hotelRating = nil;
    self.hotelReview = nil;
    self.hotelAccommodationList = nil;
//    NSLog(@"Booyeah!! Hotel Profile Successfully dealloc~ed!!");
}

@end
