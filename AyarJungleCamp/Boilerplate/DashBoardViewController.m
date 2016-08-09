//
//  DashBoardViewController.m
//  Boilerplate
//
//  Created by agatsa on 8/8/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "DashBoardViewController.h"
#import "AFNetworking.h"
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
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://www.raywenderlich.com/demos/weather_sample/weather.php?format=json" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
    
        NSDictionary *weatherDictionary = (NSDictionary *)[responseObject valueForKeyPath:@"data.current_condition"];
        NSString * temperatureRecieved = [[weatherDictionary valueForKey:@"temp_C"] firstObject];
        NSString * conditionRecieved = [[[weatherDictionary valueForKeyPath:@"weatherDesc.value"] firstObject] firstObject];
        
        [weatherView updateWeatherConditions:conditionRecieved weatherIconString:@"Storm3.png" temperature:temperatureRecieved andCurrentDay:@"Tue, December 17"];
        [weatherView stopLoading];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        [weatherView updateWeatherConditions:@"error" weatherIconString:@"Storm3.png" temperature:@"19˚" andCurrentDay:@"Tue, December 17"];
        [weatherView stopLoading];
    }];
    
    
    
    
//    double delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//      
//    });
    
    
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
            
        case AJCDashboardViewBook:
            NSLog(@"Booking Pressed!!");
            break;
            
        case AJCDashboardViewInAnAround:
            NSLog(@"In/Around Nainital Pressed!!");
            break;
            
        case AJCDashboardViewLocalEvents:
            NSLog(@"Local Events Pressed!!");
            break;
            
        default:
            break;
    }
}


-(void) userTappedOnWeatherView {
    
     NSLog(@"User Tapped on Weather View!!");
}

@end
