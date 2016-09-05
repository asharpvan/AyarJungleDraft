//
//  DatabaseClient.m
//  Sanket
//
//  Created by agatsa on 8/18/15.
//  Copyright (c) 2015 Agatsa. All rights reserved.
//

#import "DatabaseClient.h"
#import "HotelProfile.h"


@implementation DatabaseClient

@synthesize dbHandle,dbName;

- (id)init{
    self = [super init];
    if (self) {
    
        dbName = @"AJCDatabase.sqlite";
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
        }
        return;
    }
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:databasePath error:&error];
    if(!success)
        NSAssert1(0, @"Failed to create writeable database with message '%@'.", [error localizedDescription]);
}

-(void) closeDatabase{
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
//               
//                [fetchedProfile displayHotelProfile];
            }
            sqlite3_finalize(searchStatement);
        }
    }
    
    return fetchedProfile;
}


@end
