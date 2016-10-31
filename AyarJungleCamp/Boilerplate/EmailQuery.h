//
//  Mail.h
//  Boilerplate
//
//  Created by perminder on 10/28/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmailQuery : NSObject

@property(nonatomic,strong) NSString *senderEmail;
@property(nonatomic,strong) NSString *senderName;
@property(nonatomic,strong) NSNumber *senderContact;
@property(nonatomic,strong) NSNumber *numberOfAdults;
@property(nonatomic,strong) NSNumber *numberOfChildren;
@property(nonatomic,strong) NSDate *checkInDate;
@property(nonatomic,strong) NSDate *checkOutDate;

@end
