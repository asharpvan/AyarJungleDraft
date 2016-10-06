//
//  TopBarView.m
//  Boilerplate
//
//  Created by Pranav Sah on 05/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "TopBarView.h"

@implementation TopBarView {
    
    NSString* titleToShow;
}

-(instancetype) initWithTitle:(NSString *) topBarTitle andSize:(CGSize)size {
    self = [super init];
    if (self) {
        
        [self setFrame:CGRectMake(0, 0, size.width, size.height)];
        titleToShow = topBarTitle;
        [self customizeView];
        
    }
    return self;
}

-(void) customizeView {
    
    
    [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.482 blue:1.0 alpha:0.96f]];
    
    [self addSubview:self.topBarTitleLabel];
    [self addSubview:self.backButtonView];
    
}

- (UILabel *)topBarTitleLabel {
    
    if(!_topBarTitleLabel) {
        
        _topBarTitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [_topBarTitleLabel setTextColor:[UIColor whiteColor]];
        [_topBarTitleLabel setText:titleToShow];
        [_topBarTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [_topBarTitleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        
    }
    return _topBarTitleLabel;
}

- (UIView *)backButtonView {
    
    if(!_backButtonView) {
        
        _backButtonView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_backButtonView setCenter:CGPointMake(42, self.center.y)];
        [_backButtonView setImage:[UIImage imageNamed:@"Storm.png"]];
        [_backButtonView setContentMode:UIViewContentModeCenter];
        [_backButtonView setUserInteractionEnabled:TRUE];
        
        //Set up gesture on the view
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backButtonTapped:)];
        [_backButtonView addGestureRecognizer:tapGesture];
    }
    return _backButtonView;
}

-(void) backButtonTapped:(id)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(userTappedOnBackButton)]) {
        [self.delegate userTappedOnBackButton];
    }
}


-(void) dealloc {
    
    self.topBarTitleLabel = nil;
    self.backButtonView = nil;
    NSLog(@"Booyeah!! Top View Successfully dealloc~ed!!");
}

@end
