//
//  TopBarView.h
//  Boilerplate
//
//  Created by Pranav Sah on 05/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopBarViewDelegate <NSObject>
@optional
-(void) userTappedOnBackButton;

@end

@interface TopBarView : UIView
@property (nonatomic, strong) UILabel *topBarTitleLabel;
@property (nonatomic, strong) UIImageView *backButtonView;
@property (nonatomic, assign) id <TopBarViewDelegate> delegate;

-(instancetype) initWithTitle:(NSString *) topBarTitle andSize:(CGSize)size;

@end
