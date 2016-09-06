//
//  DatabaseClient.m
//  Sanket
//
//  Created by agatsa on 8/18/15.
//  Copyright (c) 2015 Agatsa. All rights reserved.
//

#import "DatabaseClient.h"
#import "HotelProfile.h"
#import "AttractionDataModel.h"


@implementation DatabaseClient

@synthesize dbHandle,dbName;

- (id)init{
    self = [super init];
    if (self) {
    
        dbName = @"AJCDatabase0.2.sqlite";
        [self openDatabase];
        [self closeDatabase];
    }
    return self;
}

+ (DatabaseClient *)sharedInstance {
    
    static dispatch_once_t pred;
    static DatabaseClient *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void) openDatabase{
    
    BOOL success;

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:dbName];
    success = [fileManager fileExistsAtPath:databasePath];
    if(success){
        if(sqlite3_open([databasePath UTF8String], &dbHandle) == SQLITE_OK){
            NSString *sql = [NSString stringWithFormat:@"PRAGMA FOREIGN_KEYS=ON;"];
            const char *sqlStatment = [sql UTF8String];
            sqlite3_stmt *sStatement;
            if(sqlite3_prepare_v2(dbHandle, sqlStatment, -1, &sStatement, NULL) == SQLITE_OK)
                sqlite3_finalize(sStatement);
        }else {
            
            NSLog(@"Error is: %s", sqlite3_errmsg(dbHandle));
        }
        return;
    }
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:databasePath error:&error];
    if(!success)
        NSAssert1(0, @"Failed to create writeable database with message '%@'.", [error localizedDescription]);
}

-(void) closeDatabase{
    
    NSLog(@"Error is: %s", sqlite3_errmsg(dbHandle));
    sqlite3_close(dbHandle) ;

    return;
}


-(BOOL) saveHotelProfileLocally:(HotelProfile *) hotelRecord {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:hotelRecord];
    const char* sqliteQuery = "Insert or Replace into HotelProfile (profile) VALUES (?)";
    sqlite3_stmt* statement;
    if (sqlite3_prepare_v2(dbHandle, sqliteQuery, -1, &statement, NULL) == SQLITE_OK) {
        
        sqlite3_bind_blob(statement, 1, [data bytes], (int)[data length], SQLITE_TRANSIENT);
        if (SQLITE_DONE != sqlite3_step(statement)){
            sqlite3_finalize(statement);
            NSLog(@"Error is: %s", sqlite3_errmsg(dbHandle));
            return FALSE;
        }
        else{
            // success!
            sqlite3_finalize(statement);
            return TRUE;
        }
    }
    else {
        NSLog( @"SaveBody: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(dbHandle) );
        return FALSE;
    }
}

-(HotelProfile *) fetchHotel {
    
    NSLog(@"Fetching Hotel Profile Details From Local");
    HotelProfile *fetchedProfile;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent: dbName];
    if(sqlite3_open([databasePath UTF8String], &dbHandle) == SQLITE_OK){
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM HotelProfile;"];
        const char *sqlStatment = [sql UTF8String];
        sqlite3_stmt *searchStatement;
        if(sqlite3_prepare_v2(dbHandle, sqlStatment, -1, &searchStatement, NULL) == SQLITE_OK){
            while(sqlite3_step(searchStatement) == SQLITE_ROW){
               
                NSData *data = [[NSData alloc] initWithBytes:sqlite3_column_blob(searchStatement, 1) length:sqlite3_column_bytes(searchStatement, 1)];
                fetchedProfile = (HotelProfile *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
            sqlite3_finalize(searchStatement);
        }
    }
    return fetchedProfile;
}

-(void) fetchAllAttractions: (AttractionListFetchCompletion) complete {
    
    NSLog(@"Fetching Attraction List Details From Local");
    __block NSMutableArray *arrayOfAttractions = [NSMutableArray new];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent: dbName];
    if(sqlite3_open([databasePath UTF8String], &dbHandle) == SQLITE_OK){
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM AttractionsList;"];
        const char *sqlStatment = [sql UTF8String];
        sqlite3_stmt *searchStatement;
        if(sqlite3_prepare_v2(dbHandle, sqlStatment, -1, &searchStatement, NULL) == SQLITE_OK){
            while(sqlite3_step(searchStatement) == SQLITE_ROW){
                NSNumber *attractionId = [NSNumber numberWithInt:(int)sqlite3_column_int64(searchStatement, 0)];
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *city = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSString *state = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 3)];
                NSString *pin = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 4)];
                NSString *contact = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 5)];
                BOOL isLocal = (BOOL)sqlite3_column_int64(searchStatement, 6);
                NSLog(@"%d",isLocal);
                CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(sqlite3_column_double(searchStatement, 7), sqlite3_column_double(searchStatement, 8));
                NSNumber *distance = [NSNumber numberWithFloat:(float)sqlite3_column_double(searchStatement, 9)];
                NSString *imageName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 10)];
                
                AttractionDataModel *attraction = [[AttractionDataModel alloc]initWithId:attractionId name:name city:city state:state pin:pin contact:contact isLocal:isLocal coordinates:coordinates distance:distance andImageName:imageName];
                [arrayOfAttractions addObject:attraction];
                
            }
            sqlite3_finalize(searchStatement);
        }
        else{
            if(complete) {
                [self closeDatabase];
                dispatch_async(dispatch_get_main_queue(), ^{
                    complete (nil,[NSString stringWithUTF8String:(char *)sqlite3_errmsg(dbHandle)]);
                });
            }
        }
    }
    if(complete) {
        [self closeDatabase];
        dispatch_async(dispatch_get_main_queue(), ^{
        complete ([self shuffleArray:arrayOfAttractions],nil);
        });
    }
}



-(NSArray *) shuffleArray:(NSMutableArray *) arrayRecieved {
    
//    for (NSUInteger i = arrayRecieved.count; i > 1; i--)
//        [arrayRecieved exchangeObjectAtIndex:i - 1 withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    return [arrayRecieved copy];
}
@end
