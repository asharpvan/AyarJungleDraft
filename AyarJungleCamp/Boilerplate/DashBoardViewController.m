//
//  DashBoardViewController.m
//  Boilerplate
//
//  Created by agatsa on 8/8/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "DashBoardViewController.h"


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
    
    AJCDashboardView *firstView = [[AJCDashboardView alloc]initWithSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height/ 4) andTitle:@"About Ayar" withIdentifier:0];
    [firstView setDelegate:self];
    [firstView setCenter:CGPointMake(firstView.center.x, firstView.center.y)];
    [self.view addSubview:firstView];
  
    AJCDashboardView *secondView = [[AJCDashboardView alloc]initWithSize:firstView.frame.size andTitle:@"Book @ Ayar" withIdentifier:1];
    [secondView setDelegate:self];
    [secondView setCenter:CGPointMake(secondView.center.x, firstView.center.y+firstView.frame.size.height)];
    [self.view addSubview:secondView];
    
    AJCDashboardView *thirdView = [[AJCDashboardView alloc]initWithSize:firstView.frame.size andTitle:@"In and Around Nainital" withIdentifier:2];
    [thirdView setDelegate:self];
    [thirdView setCenter:CGPointMake(thirdView.center.x, secondView.center.y + secondView.frame.size.height)];
    [self.view addSubview:thirdView];

    AJCDashboardView *fourthView = [[AJCDashboardView alloc]initWithSize:firstView.frame.size andTitle:@"Local Events" withIdentifier:3];
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

-(void) userTappedOnView:(NSInteger)number {
    
    switch (number) {
        case 0:
            NSLog(@"Open About!!");
            break;
            
        case 1:
            NSLog(@"Open Booking!!");
            break;
            
        case 2:
            NSLog(@"Open In and Around Nainital!!");
            break;
            
        case 3:
            NSLog(@"Open Local Events!!");
            break;
            
        default:
            break;
    }
    
}

@end
