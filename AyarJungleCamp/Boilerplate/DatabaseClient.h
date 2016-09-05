//
//  DatabaseClient.h
//  Sanket
//
//  Created by agatsa on 8/18/15.
//  Copyright (c) 2015 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class HotelProfile;

@interface DatabaseClient : NSObject
// variable to hold database handle
@property(nonatomic,assign) sqlite3 *dbHandle;
// variable to hold database name
@property(nonatomic,strong) NSString *dbName;
// variable to hold database name
//@property(nonatomic,assign) hasUpdatedDbname;
// SQLite methods to be accessed from other classes
//Initializers
- (id)init;
-(void) openDatabase;
-(void) closeDatabase;

//Singleton Class Method for easy reference
+(DatabaseClient *)sharedInstance;

//Function to save the Records Locally
-(BOOL) saveHotelProfileLocally:(HotelProfile *) hotelRecord;

//Function to fetch the Records From Local DB
-(HotelProfile *) fetchHotel;

@end
