//
//  HotelProfileViewController.m
//  Boilerplate
//
//  Created by Pranav Sah on 29/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "HotelProfileViewController.h"


@interface HotelProfileViewController ()

@end

@implementation HotelProfileViewController


-(instancetype) init {
    
    self = [super init];
    if(self) {
        
        [self setTitle:@"Hotel Profile"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self createSubview];
    }
    return self;
}

-(void) createSubview {


    [self.parallaxHeaderView setBackgroundColor:[UIColor blackColor]];
//    [self.parallaxContentView setBackgroundColor:[UIColor greenColor]];
    
    UIView *lastView = [[UIView alloc]initWithFrame:CGRectMake(0, _parallaxContentView.frame.size.height - 50, 44, 44)];
    [lastView setBackgroundColor:[UIColor blueColor]];
    [_parallaxContentView addSubview:lastView];
    
    self.scrollView.parallaxHeader.view = _parallaxHeaderView;
    self.scrollView.parallaxHeader.height = 200;
    self.scrollView.parallaxHeader.mode = MXParallaxHeaderModeFill;
    self.scrollView.parallaxHeader.minimumHeight = 0;
    
    [self.scrollView addSubview:_parallaxContentView];
    [self.view addSubview:_scrollView];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy Loading

- (MXScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[MXScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIImageView *)parallaxHeaderView {
    
    if(!_parallaxHeaderView) {
//        _parallaxHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
//        // Parallax Header
//        [_parallaxHeaderView setImage:[UIImage imageNamed:@"AJC_Restaurant.png"]];
        _parallaxHeaderView = [NSBundle.mainBundle loadNibNamed:@"StarshipHeader" owner:self options:nil].firstObject;

    }
    return _parallaxHeaderView;
}

- (UIView *)parallaxContentView {
   
    if(!_parallaxContentView) {
        _parallaxContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + 100)];
   }
    return _parallaxContentView;
}

#pragma mark <UIScrollViewDelegate>

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"progress %f", self.scrollView.parallaxHeader.progress);
//}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.parallaxContentView.frame;
    self.scrollView.contentSize = frame.size;
}

-(BOOL) prefersStatusBarHidden {
    
    return TRUE;
}
@end
