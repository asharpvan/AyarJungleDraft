//
//  DashBoardViewController.m
//  Boilerplate
//
//  Created by agatsa on 8/8/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "DashBoardViewController.h"
//#import "AFNetworking.h"
#import "DatabaseClient.h"
#import "HotelProfile.h"
#import "RoomListViewController.h"
#import "HotelProfileViewController.h"




@interface DashBoardViewController ()

@end

@implementation DashBoardViewController

-(instancetype) init {
    
    self = [super init];
    if(self) {
        [self setTitle:@"Dashboard Screen"];
    }
    return self;
}

-(void) loadView {
    
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat weatherViewHeight = self.view.frame.size.height/3;
    CGFloat dashboardViewHeight = (2 * (self.view.frame.size.height/3))/3;
    CGSize weatherViewSize = CGSizeMake(self.view.frame.size.width, weatherViewHeight);
    CGSize dashboardViewSize = CGSizeMake(self.view.frame.size.width, dashboardViewHeight);
    
    AJCWeatherView *weatherView = [[AJCWeatherView alloc] initWithSize:weatherViewSize];
    [weatherView setDelegate:self];
    [weatherView startLoading];
    [self.view addSubview:weatherView];
    
   
    AJCDashboardView *secondView = [[AJCDashboardView alloc]initWithSize:dashboardViewSize withIdentifier:AJCDashboardViewBook];
    [secondView setDelegate:self];
    [secondView setCenter:CGPointMake(secondView.center.x, weatherView.center.y + (dashboardViewSize.height + weatherViewSize.height)/2 )];
    [self.view addSubview:secondView];
    
    AJCDashboardView *thirdView = [[AJCDashboardView alloc]initWithSize:dashboardViewSize withIdentifier:AJCDashboardViewInAnAround];
    [thirdView setDelegate:self];
    [thirdView setCenter:CGPointMake(thirdView.center.x, secondView.center.y + secondView.frame.size.height)];
    [self.view addSubview:thirdView];

//    AJCDashboardView *fourthView = [[AJCDashboardView alloc]initWithSize:dashboardViewSize withIdentifier:AJCDashboardViewLocalEvents];
//    [fourthView setDelegate:self];
//    [fourthView setCenter:CGPointMake(fourthView.center.x, thirdView.center.y+thirdView.frame.size.height)];
//    [self.view addSubview:fourthView];

    UIView *fourthView = [[UIView alloc]initWithFrame:[thirdView frame]];
    [fourthView setCenter:CGPointMake(fourthView.center.x, thirdView.center.y+thirdView.frame.size.height)];
    [self.view addSubview:fourthView];
    
    NSLog(@"%@",[FBSDKAccessToken currentAccessToken]);
    if(![FBSDKAccessToken currentAccessToken]) {
        
        
//        FBSDKLikeControl *likeButton = [[FBSDKLikeControl alloc]init];
//        likeButton.center = fourthView.center;
//        likeButton.objectID = @"https://www.facebook.com/ayarjunglecamp";
//        likeButton.likeControlStyle = FBSDKLikeControlStyleBoxCount;
//        // Change the style to box count
//        likeButton.likeControlHorizontalAlignment =
//        FBSDKLikeControlHorizontalAlignmentRight;
//        [self.view addSubview:likeButton];
//        
//    }else {

        FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
        // Optional: Place the button in the center of your view.
        loginButton.center = fourthView.center;
//        [loginButton setDelegate:self];
        loginButton.readPermissions =@[@"public_profile", @"email",@"user_friends"];
        [loginButton setPublishPermissions:@[@"publish_actions"]];
        [self.view addSubview:loginButton];
        [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
        
        NSLog(@"%@",[[FBSDKProfile currentProfile] firstName]);
        NSLog(@"%@",[[FBSDKProfile currentProfile] lastName]);
        NSLog(@"%@",[[FBSDKProfile currentProfile] userID]);
        NSLog(@"%@",[[FBSDKProfile currentProfile] name]);
    }
    
}

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

-(void) userTappedOnView:(AJCDashboardViewOptions) ajcDashboardViewOptionPressed {
    
    switch (ajcDashboardViewOptionPressed) {
            
        case AJCDashboardViewBook: {
            NSLog(@"Booking Pressed!!");
            [[DatabaseClient sharedInstance] openDatabase];
            HotelProfile *profileToShow = [[DatabaseClient sharedInstance] fetchHotel];
            [[DatabaseClient sharedInstance] closeDatabase];
            RoomListViewController *roomList = [[RoomListViewController alloc]initWithRoomList:[profileToShow hotelAccommodationList]];
            [self.navigationController pushViewController:roomList animated:TRUE];
        }
            break;
            
        case AJCDashboardViewInAnAround: {
            NSLog(@"In/Around Nainital Pressed!!");
            [[DatabaseClient sharedInstance] openDatabase];
            [[DatabaseClient sharedInstance] fetchAllAttractions:^(NSArray *attractionListArray, NSString *error) {
                if(!error && attractionListArray){
                    AttractionListViewController *attractionList = [[AttractionListViewController alloc]initWithAttractionList:[attractionListArray copy]];
                    [self.navigationController pushViewController:attractionList animated:TRUE];
                }
            }];
        }
            break;
            
        case AJCDashboardViewLocalEvents: {
            NSLog(@"Local Events Pressed!!");
            [[DatabaseClient sharedInstance] openDatabase];
            HotelProfile *profileToShow = [[DatabaseClient sharedInstance] fetchHotel];
            [[DatabaseClient sharedInstance] closeDatabase];
            HotelProfileViewController *hotelProfile = [[HotelProfileViewController alloc]initWithHotelProfile:profileToShow showAsParallaxView:TRUE];
            [self.navigationController pushViewController:hotelProfile animated:TRUE];
        }
            
            break;
            
        default:
            break;
    }
}


-(void) userTappedOnWeatherView {
    
     NSLog(@"User Tapped on Weather View!!");
}

- (void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    
    if(error) {
        NSLog(@"error : %@",error);
    }else {
        NSLog(@"\n**FBSDKLoginManagerLoginResult**\ntokenString :%@\nappID :%@\nuserID :%@\npermissions :%@\nexpirationDate :%@\nrefreshDate :%@\ngrantedPermissions :%@\ndeclinedPermissions :%@",result.token.tokenString,result.token.appID,result.token.userID,result.token.permissions,result.token.expirationDate,result.token.refreshDate,result.grantedPermissions,result.declinedPermissions);
    }
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
    NSLog(@"Loggesd out!!");
    
}

- (BOOL) loginButtonWillLogin:(FBSDKLoginButton *)loginButton {

    return TRUE;
}
@end
