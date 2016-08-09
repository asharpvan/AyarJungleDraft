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

@interface DashBoardViewController : EmptyScreenViewController <AJCDashboardViewDelegate,AJCWeatherViewDelegate>

-(instancetype)init;

@end
