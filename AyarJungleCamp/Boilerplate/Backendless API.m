//
//  Backendless API.m
//  Boilerplate
//
//  Created by perminder on 10/31/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "Backendless API.h"
#import "AFNetworking.h"

static BOOL isPerformingQuery;

@implementation Backendless_API{
    
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

-(void) registerUser:(NSString *)emailId andPassword:(NSString *)password andName:(NSString *)userName {
    
    [self setisQueryExecutionState:TRUE];
    
    
    NSDictionary *postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:emailId,@"email",userName,@"name",password,@"password",nil];
    
    NSLog(@"%@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:postDataDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
    
    [manager.requestSerializer setValue:@"D372B081-C027-6E62-FF9E-61510CB97900" forHTTPHeaderField:@"application-id"];
    [manager.requestSerializer setValue:@"xxxxx" forHTTPHeaderField:@"secret-key"];
    [manager.requestSerializer setValue:@"REST" forHTTPHeaderField:@"application-type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:@"https://api.backendless.com/v1/users/register" parameters:postDataDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        NSLog(@"%@",[[NSString alloc]initWithData:[[error userInfo] valueForKeyPath:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
}

- (BOOL)getIsQueryExecuting {
    
    return isPerformingQuery;
}

- (void)setisQueryExecutionState:(BOOL)state {
    
    isPerformingQuery = state;
}


-(void) getPageInfo {
    
    NSString *access_Token_user = @"EAAFw3tkLZAZCQBAMe0riLOpKpWZBSydFLygOfgBy2eyEK2EuEES1utdg8IO9zTQ5LWa6qrv0AFlWdViUR8LaVVJwkfamgxFxwpbsIl6dlZCKg2a97dwntLDooI373pU0yJqGZCUNcmc9QAzJioDJV"; //this token never expires
    
   NSString *access_Token_page = @"  EAAFw3tkLZAZCQBAHMaEmFt0MnLYRaD7tPYZCMJpXrYbFEvIqScbydvDqAWv5czZBjdhEDpSTTtknB1guKYgPB2IP4BlPNRX9NoSZCi38oNS9JUGJF6nUBDUooeHRMZBQa71aaaT4hkaokh64aNcjVfSPXSSqKnM7IZD";
    
    NSString *pageURI = [NSString stringWithFormat:@"https://graph.facebook.com/v2.8/157060791031852?access_token=%@",access_Token_page];
    
    [self setisQueryExecutionState:TRUE];
    
    
    NSDictionary *postDataDictionary = @{ @"fields": @"were_here_count,talking_about_count,rating_count,overall_star_rating,new_like_count,id,ratings{rating,review_text,reviewer,created_time}"};
    
    [manager GET:pageURI parameters:postDataDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",[[NSString alloc]initWithData:[[error userInfo] valueForKeyPath:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
}
@end
