//
//  AppDelegate.m
//  Boilerplate
//
//  Created by agatsa on 4/1/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DatabaseClient.h"
#import "HotelProfile.h"
#import "DashBoardViewController.h"
#import "SendGridAPIClient.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    SendGridAPIClient *sendGrid = [[SendGridAPIClient alloc]init];
    NSDictionary *queryDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"3",@"numberOfAdults",@"1",@"numberOfChildren",@"29/10/2016",@"checkIn",@"31/10/2016",@"checkOut",@"Need a ramp",@"specialMessage", nil];
    [sendGrid sendQueryFrom:@"ayarjunglecamp@gmail.com" withQuery:queryDictionary onCompletion:^(BOOL success, NSString *errorString) {
        
        if(success) {
            NSLog(@"Mail Sent!!");
        }else {
            NSLog(@"Mail Sending failed due to : %@",errorString);
        }
    }];
    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *viewToload = nil;
//    self.viewController=[[ViewController alloc]init];
    self.dashBoard = [[DashBoardViewController alloc]init];
    viewToload = self.dashBoard;
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:viewToload];
    self.window.rootViewController = self.navController;
    
    [self.navController setNavigationBarHidden:TRUE];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
