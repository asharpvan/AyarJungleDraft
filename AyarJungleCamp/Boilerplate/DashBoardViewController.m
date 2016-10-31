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
//#import "afh"



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

    AJCDashboardView *fourthView = [[AJCDashboardView alloc]initWithSize:dashboardViewSize withIdentifier:AJCDashboardViewLocalEvents];
    [fourthView setDelegate:self];
    [fourthView setCenter:CGPointMake(fourthView.center.x, thirdView.center.y+thirdView.frame.size.height)];
    [self.view addSubview:fourthView];
    
    
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

@end
