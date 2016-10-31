//
//  AJCDashboardView.m
//  Boilerplate
//
//  Created by agatsa on 8/8/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "AJCDashboardView.h"
#import "POP.h"

@implementation AJCDashboardView

-(instancetype) initWithSize:(CGSize)size withIdentifier:(AJCDashboardViewOptions)identifierRecieved {
    self = [super init];
    if (self) {
        
        [self setFrame:CGRectMake(0, 0,size.width,size.height)];
        identifier = identifierRecieved;
        [self customizeView];
        
    }
    return self;
}

-(void) customizeView {

    if(((identifier) % 2)) {
        [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.482 blue:1.0 alpha:0.96f]];
    } else {
        [self setBackgroundColor:[UIColor colorWithRed:1.0 green:0.611 blue:0.0 alpha:0.96f]];
    }
    
    NSString *title = nil;
    switch (identifier) {
        case AJCDashboardViewBook:
            title = @"Book @ AJC";
            break;
        case AJCDashboardViewInAnAround:
            title = @"In and Around Nainital";
            break;
        case AJCDashboardViewLocalEvents:
            title = @"About Ayar Jungle Camp";
            break;
            
        default:
            break;
    }

    // set UILabel for text
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.origin.x + 10, self.frame.size.height - 64, self.frame.size.width - 20, 64)];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:title];
    [titleLabel setUserInteractionEnabled:FALSE];
    [self addSubview:titleLabel];
    
    //Set up gesture on the view
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    [self addGestureRecognizer:tapGesture];
    
}


-(void) viewTapped:(id)sender {
    
//    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
//    AJCDashboardView *selectedView = (AJCDashboardView *)[tapRecognizer view];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(userTappedOnView:)]) {
    
        [self.delegate userTappedOnView:identifier];
    }
  
}

@end
