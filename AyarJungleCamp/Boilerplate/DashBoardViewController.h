//
//  DashBoardViewController.h
//  Boilerplate
//
//  Created by agatsa on 8/8/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AJCDashboardView.h"
#import "EmptyScreenViewController.h"
#import "AJCWeatherView.h"
#import "AttractionListViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface DashBoardViewController : EmptyScreenViewController <AJCDashboardViewDelegate,AJCWeatherViewDelegate,FBSDKLoginButtonDelegate>

-(instancetype)init;

@end
