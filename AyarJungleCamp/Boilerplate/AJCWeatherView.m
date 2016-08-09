//
//  AJCWeatherView.m
//  Boilerplate
//
//  Created by agatsa on 8/9/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "AJCWeatherView.h"

@implementation AJCWeatherView

-(instancetype) initWithSize:(CGSize)size {
    self = [super init];
    if (self) {
        
        [self setFrame:CGRectMake(0, 0,size.width,size.height)];
        //        [self :identifier];
        [self customizeView];
        
    }
    return self;
}

-(void) customizeView {
    
   
    [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.482 blue:1.0 alpha:0.96f]];
    
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:[self center]];
    [spinner setHidesWhenStopped:TRUE];
    [self addSubview:spinner];
    
    
    infoView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10)];
    [self addSubview:infoView];
    
    //Style 2
    CGFloat widthForTempLabel = infoView.bounds.size.width/2;
    
    ajcTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(infoView.bounds.size.width - widthForTempLabel,0,widthForTempLabel, infoView.bounds.size.height)];
    
    [ajcTempLabel setTextColor:[UIColor whiteColor]];
    [ajcTempLabel setFont:[UIFont systemFontOfSize:85]];
    [ajcTempLabel setTextAlignment:NSTextAlignmentLeft];
    [infoView addSubview:ajcTempLabel];
    
    
    weatherIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
    [weatherIconImageView setCenter:CGPointMake(infoView.center.x - 44, infoView.center.y)];
    [weatherIconImageView setContentMode:UIViewContentModeCenter];
    [infoView addSubview:weatherIconImageView];
    
    
    CGFloat currentDayLabelOrigin = infoView.center.y - (weatherIconImageView.bounds.size.height/2 + 22 + 5);
    currentDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentDayLabelOrigin, widthForTempLabel, 44)];
    [currentDayLabel setTextColor:[UIColor whiteColor]];
    [currentDayLabel setTextAlignment:NSTextAlignmentRight];
    [infoView addSubview:currentDayLabel];
    
    
    CGFloat currentWeatherConditionsLabelOrigin = infoView.center.y + (weatherIconImageView.bounds.size.height/2 - 22 + 5);
    
    currentWeatherConditionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(infoView.center.x, currentWeatherConditionsLabelOrigin, widthForTempLabel, 44)];
    [currentWeatherConditionsLabel setTextColor:[UIColor whiteColor]];
    [currentWeatherConditionsLabel setTextAlignment:NSTextAlignmentLeft];
    [infoView addSubview:currentWeatherConditionsLabel];

    //Set up gesture on the view
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    [self addGestureRecognizer:tapGesture];
    
}


-(void) viewTapped:(id)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(userTappedOnWeatherView)]) {
        [self.delegate userTappedOnWeatherView];
    }
}


-(void) updateWeatherConditions:(NSString *)weatherConditionString weatherIconString:(NSString *)weatherIconString temperature:(NSString *)temperatureReading andCurrentDay:(NSString *)currentDay {
    
    [currentWeatherConditionsLabel setText:weatherConditionString];
    [currentDayLabel setText:currentDay];
    [weatherIconImageView setImage:[UIImage imageNamed:weatherIconString]];
    [ajcTempLabel setText:[NSString stringWithFormat:@"%@˚",temperatureReading]];

}


-(void) startLoading {
    
    [infoView setHidden:TRUE];
    [spinner startAnimating];
}


-(void) stopLoading {
    
    [spinner stopAnimating];
    [infoView setHidden:FALSE];
    
}

@end
