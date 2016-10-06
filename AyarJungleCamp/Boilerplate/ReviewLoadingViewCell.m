//
//  ReviewLoadingViewCell.m
//  Boilerplate
//
//  Created by Pranav Sah on 15/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "ReviewLoadingViewCell.h"

@implementation ReviewLoadingViewCell

-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setAutoresizesSubviews: TRUE];
        [self setClipsToBounds:TRUE];
        
        self.reviewName = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.reviewName setFrame:self.bounds];
        [self setTag:1010];
        [self setUserInteractionEnabled:FALSE];

        [self addSubview:self.reviewName];
        
    }
    return self;
}

- (void) setStartAnimating {
    
    [self.reviewName startAnimating];
}

- (void) setStopAnimating {
    
    [self.reviewName stopAnimating];
}

@end
