//
//  EmptyScreenViewController.m
//  Boilerplate
//
//  Created by agatsa on 7/27/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "EmptyScreenViewController.h"

@interface EmptyScreenViewController () {
    
    BOOL topBarIsAnimating;
    BOOL topBarIsShowing;
    BOOL actionBarIsAnimating;
    BOOL actionBarIsShowing;
 
}

@end

@implementation EmptyScreenViewController


-(void)loadView {
    
    [super loadView];

    self.topView = [[UILabel alloc]initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, 64)];
    [self.topView setTextColor:[UIColor whiteColor]];
    [self.topView setTextAlignment:NSTextAlignmentCenter];
    [self.topView setBackgroundColor:[UIColor orangeColor]];
    topBarIsAnimating = FALSE;
    topBarIsShowing = FALSE;
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height + 60, self.view.frame.size.width, 60)];
    [self.bottomView setBackgroundColor:[UIColor grayColor]];
    
    //Set up gesture on the view
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
//    [self.actionView addGestureRecognizer:tapGesture];
    
    self.emptyViewScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.emptyViewScroller setBackgroundColor:[UIColor redColor]];
    [self.emptyViewScroller setDelegate:self];
    [self.emptyViewScroller setBounces:FALSE];
    [self.view addSubview:self.emptyViewScroller];

    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
}

-(void) update :(NSString *)newNavTitle {
    
    [self.topView setText:newNavTitle];
}


-(void) updateNavTitleTo :(NSString *)newNavTitle {
    
    [self.topView setText:newNavTitle];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL) prefersStatusBarHidden {
    
    return TRUE;
}

#pragma mark - Navigation

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint offset = [scrollView contentOffset];
    
    // Check if current offset is within limit and adjust if it is not
    if (offset.y < 0)
        offset.y = 0;
    
    if(offset.y > self.topBarThreshold) {
        if(!topBarIsShowing && !topBarIsAnimating) {
            [self toggleTopView];
        }
    }

    if(offset.y < self.topBarThreshold) {
        if(topBarIsShowing && !topBarIsAnimating) {
            [self toggleTopView];
        }
    }
    
    // Set offset to adjusted value
    [scrollView setContentOffset : offset ];
}

-(void) toggleTopView {
    
    topBarIsAnimating = !topBarIsAnimating;
    __block CGRect tempFrame = self.topView.frame;
    __block CGRect tempFrame1 = self.bottomView.frame;
    [UIView animateWithDuration:0.75f animations:^{
        if(!topBarIsShowing){
            tempFrame.origin.y = 0;
            tempFrame1.origin.y = self.view.frame.size.height - 60;
        }else {
            tempFrame.origin.y = -60;
            tempFrame1.origin.y = self.view.frame.size.height + 60;
        }
        [self.topView setFrame:tempFrame];
        [self.bottomView setFrame:tempFrame1];
    } completion:^(BOOL finished) {
        topBarIsAnimating = !topBarIsAnimating;
        topBarIsShowing = !topBarIsShowing;
    }];
}


-(void) viewTapped:(id)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(userTappedOnActionButton)]) {
        [self.delegate userTappedOnActionButton];
    }
}
@end
