//
//  HotelProfileViewViewController.m
//  Boilerplate
//
//  Created by Pranav Sah on 27/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "HotelProfileViewViewController.h"
#import "HotelProfile.h"
#import "POP.h"

@interface HotelProfileViewViewController () {
    
    HotelProfile *hotel;
}

@end

@implementation HotelProfileViewViewController

-(instancetype) initWithHotelProfile:(HotelProfile *) hotelProfileRecieved {
    
    self = [super init];
    if(self) {
        
        hotel = hotelProfileRecieved;
        [self setTitle:@"Ayar Jungle Camp"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self setDelegate:self];
        [self createSubview];
    }
    return self;
}


-(void) createSubview {
    
    UIImageView *bannerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)];
    [bannerImage setBackgroundColor:[UIColor blackColor]];
    [self.emptyViewScroller addSubview:bannerImage];
   
    UIButton *bookButton = [[UIButton alloc]initWithFrame:CGRectMake(bannerImage.frame.size.width - 55, bannerImage.frame.size.height + 5, 50, 50)];
    [bookButton setTitle:@"Book" forState:UIControlStateNormal];
    [[bookButton layer] setCornerRadius:bookButton.frame.size.height/2];
    [bookButton addTarget:self action:@selector(bookButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bookButton setBackgroundColor:[UIColor blueColor]];
    UIView *blackView = [[UIView alloc] initWithFrame:bookButton.bounds];
    blackView.backgroundColor = [UIColor clearColor];
    
    blackView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:bookButton.frame cornerRadius:bookButton.frame.size.height/2].CGPath;
    blackView.layer.shadowColor = [UIColor blackColor].CGColor;
    blackView.layer.shadowRadius = 3;
    blackView.layer.shadowOffset = CGSizeMake(0, 5);
    blackView.layer.shadowOpacity = .25;
    blackView.layer.cornerRadius = bookButton.bounds.size.height/2;
    
    [self.view.superview insertSubview:blackView belowSubview:bookButton];
    
    
    [self.emptyViewScroller addSubview:bookButton];
    
    NSLog(@"topbar threshold in Hotel Profile View : %f",bookButton.frame.size.height + bookButton.frame.origin.y + 5);
    
    
    [self updateNavTitleTo:@"Ayar Jungle Camp"];
    self.topBarThreshold =  bookButton.frame.origin.y;
    [self.emptyViewScroller bringSubviewToFront:bookButton];
    
    [self.emptyViewScroller setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 300)];
    [self.emptyViewScroller setBounces:FALSE];
    self.scrollbarHeight = self.emptyViewScroller.frame.size.height;
    
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

-(void) bookButtonPressed:(id) sender {
    
    UIButton *button = (UIButton *)sender;
    
    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
    sprintAnimation.springBounciness = 20.f;
    sprintAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        
        NSLog(@"bookButtonPressed (HotelProfileView)");
     
    };
    [button pop_addAnimation:sprintAnimation forKey:@"sendAnimation"];
}

-(void)userTappedOnActionButton {
    
    NSLog(@"User Tapped Recieved on ViewController");
}
@end
