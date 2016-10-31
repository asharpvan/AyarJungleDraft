//
//  SendGridAPIClient.m
//  Boilerplate
//
//  Created by perminder on 10/28/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "SendGridAPIClient.h"
#import "AFNetworking.h"


static BOOL isPerformingQuery;

@implementation SendGridAPIClient{
    
    AFHTTPSessionManager *manager;
}

-(instancetype) init {
    
    self = [super init];
    if(self) {
        
        manager = [AFHTTPSessionManager manager];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    }
    return self;
}

-(void) sendQuery:(EmailQuery *)queryReceived onCompletion:(MailSentCompletion) complete {
    

    [self setisQueryExecutionState:TRUE];
    
    NSString *mailContent = [NSString stringWithFormat:@"Dear Pranav,<br /> Please find the following details: <br /><br /> Name : %@<br /> Contact Number : %@<br /> Number of Adults : %@<br /> Number of Children : %@<br /> Check In Date : %@<br /> Check Out Date : %@<br /><br /> Best Wishes, <br />NainiExplorer",[queryReceived senderName],[queryReceived senderContact],[queryReceived numberOfAdults],[queryReceived numberOfChildren],[queryReceived checkInDate],[queryReceived checkOutDate]];
    
    NSArray *sendToEmailArray = @[@{@"email": @"iospranav1712@gmail.com"}];
    NSDictionary *emailDictionary = [NSDictionary dictionaryWithObjectsAndKeys:sendToEmailArray,@"to",@"Trial Message",@"subject",nil];
    NSArray *personalisationArray = @[emailDictionary];
    
    NSArray *contentArray = @[@{@"type": @"text/html", @"value": mailContent}];
    NSDictionary *fromDetailsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[queryReceived senderEmail],@"email", nil];
    NSDictionary *postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:contentArray,@"content",fromDetailsDictionary,@"from",personalisationArray,@"personalizations",nil];
    
    [manager.requestSerializer setValue:@"xxxxxx" forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
    [manager POST:@"https://api.sendgrid.com/v3/mail/send" parameters:postDataDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(complete) {
            [self setisQueryExecutionState:FALSE];
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(TRUE,nil);
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(complete) {
            [self setisQueryExecutionState:FALSE];
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(FALSE,[error localizedDescription]);
            });
        }
    }];
}


- (BOOL)getIsQueryExecuting {
    
    return isPerformingQuery;
}

- (void)setisQueryExecutionState:(BOOL)state {
    
    isPerformingQuery = state;
}

@end
