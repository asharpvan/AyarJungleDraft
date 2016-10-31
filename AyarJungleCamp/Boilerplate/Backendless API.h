//
//  Backendless API.h
//  Boilerplate
//
//  Created by perminder on 10/31/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Backendless_API : NSObject

-(instancetype)init;

//Backendless_API *api = [Backendless_API new];
//[api registerUser:@"iospranav1712@gmail.com" andPassword:@"pranavSah" andName:@"Pranav"];


//Facebook related info

//    if([FBSDKAccessToken currentAccessToken]) {
//      when logged in
//        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//                                      initWithGraphPath:@"/157060791031852"
//                                      parameters:@{ @"fields":@"access_token,name,were_here_count,overall_star_rating,new_like_count,talking_about_count,rating_count"}
//                                      HTTPMethod:@"GET"];
//        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                              id result,
//                                              NSError *error) {
//            // Handle the result
//            NSLog(@"results : %@",result);
//            NSLog(@"error : %@",error);
//        }];
//    }
//    else {
//
//        NSLog(@"Not logged in!!");
//        Backendless_API *api = [Backendless_API new];
//        [api getPageInfo];
//    }



-(void) registerUser:(NSString *)emailId andPassword:(NSString *)password andName:(NSString *)userName;

-(void) getPageInfo;

//Getter method query exectution state
- (BOOL)getIsQueryExecuting;
@end
