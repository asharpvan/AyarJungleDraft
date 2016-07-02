//
//  ViewController.m
//  Boilerplate
//
//  Created by agatsa on 4/1/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "ViewController.h"
#import "POP.h"

@interface ViewController ()
@end

@implementation ViewController

-(instancetype) init {
    
    self = [super init];
    if(self) {
       
        [self setTitle:@"Ayar Jungle Camp"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self createSubview];
    }
    return self;
}

-(void) createSubview {
    
    UIButton *signInButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 210 ,self.view.frame.size.width - (20), 60)];
    [signInButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [signInButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [signInButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:signInButton];
    
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

-(void) buttonPressed:(UIButton *)button {

    //Bounce Animation
    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
    sprintAnimation.springBounciness = 20.f;
    sprintAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        NSLog(@"%@ Button animation has completed.",[[button titleLabel]text]);
    };
    [button pop_addAnimation:sprintAnimation forKey:@"sendAnimation"];
    
    
}
@end
