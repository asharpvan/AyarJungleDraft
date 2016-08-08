//
//  AJCDashboardView.h
//  Boilerplate
//
//  Created by agatsa on 8/8/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol AJCDashboardViewDelegate <NSObject>

@optional
-(void) userTappedOnView:(NSInteger)number;

@end

@interface AJCDashboardView : UIView

@property (nonatomic) id <AJCDashboardViewDelegate> delegate;
@property (nonatomic) NSInteger identifier;

-(instancetype) initWithSize:(CGSize)size andTitle:(NSString *)title withIdentifier:(NSInteger)identifier;

@end
