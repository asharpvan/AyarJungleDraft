//
//  SendGridAPIClient.h
//  Boilerplate
//
//  Created by perminder on 10/28/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmailQuery.h"

typedef void(^MailSentCompletion) (BOOL, NSString *);

@interface SendGridAPIClient : NSObject

-(instancetype)init;

-(void) sendQuery:(EmailQuery *)queryReceived onCompletion:(MailSentCompletion) complete;

/*   To call the above method use the following
 
 //    SendGridAPIClient *sendGrid = [[SendGridAPIClient alloc]init];
 //
 //    EmailQuery *emailQuery = [EmailQuery new];
 //    [emailQuery setSenderName:@"Kirti Maheshwari"];
 //    [emailQuery setSenderEmail:@"sahpranav@gmail.com"];
 //    [emailQuery setSenderContact:@9999518091];
 //    [emailQuery setNumberOfAdults:@3];
 //    [emailQuery setNumberOfChildren:@1];
 //    [emailQuery setCheckInDate:[NSDate date]];
 //    [emailQuery setCheckOutDate:[NSDate date]];
 //
 //    [sendGrid sendQuery:emailQuery onCompletion:^(BOOL success, NSString *errorString) {
 //
 //        if(success) {
 //            NSLog(@"Mail Sent!!");
 //        }else {
 //            NSLog(@"Mail Sending failed due to : %@",errorString);
 //        }
 //    }];
 */

//Getter method query exectution state
- (BOOL)getIsQueryExecuting;
@end
