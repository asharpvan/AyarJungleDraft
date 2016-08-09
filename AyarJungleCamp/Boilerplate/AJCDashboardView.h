//
//  AJCDashboardView.h
//  Boilerplate
//
//  Created by agatsa on 8/8/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, AJCDashboardViewOptions) {
    AJCDashboardViewBook          = 0,
    AJCDashboardViewInAnAround    = 1 << 0,
    AJCDashboardViewLocalEvents   = 1 << 1,
};

@protocol AJCDashboardViewDelegate <NSObject>

@optional
-(void) userTappedOnView:(AJCDashboardViewOptions) ajcDashboardViewOptionPressed;

@end

@interface AJCDashboardView : UIView {

    AJCDashboardViewOptions identifier;
}

@property (nonatomic) id <AJCDashboardViewDelegate> delegate;

-(instancetype) initWithSize:(CGSize)size withIdentifier:(AJCDashboardViewOptions)identifierRecieved;

@end