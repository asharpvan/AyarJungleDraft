//
//  SendGridAPIClient.h
//  Boilerplate
//
//  Created by perminder on 10/28/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MailSentCompletion) (BOOL, NSString *);

@interface SendGridAPIClient : NSObject

-(instancetype)init;

-(void) sendQueryFrom:(NSString *)senderEmailID withQuery:(NSDictionary *)queryReceived onCompletion:(MailSentCompletion) complete;

//Getter method query exectution state
- (BOOL)getIsQueryExecuting;
@end
