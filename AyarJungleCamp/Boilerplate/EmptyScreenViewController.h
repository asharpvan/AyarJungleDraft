//
//  EmptyScreenViewController.h
//  Boilerplate
//
//  Created by agatsa on 7/27/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmptyScreenViewControllerDelegate <NSObject>

@optional
-(void) userTappedOnActionButton;
-(void) userTappedOnBackButton;
@end

@interface EmptyScreenViewController : UIViewController <UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic, strong) UILabel *topView;
@property(nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) UIScrollView *emptyViewScroller;
@property(nonatomic, assign) CGFloat topBarThreshold;
@property(nonatomic, assign) CGFloat scrollbarHeight;

@property (nonatomic) id <EmptyScreenViewControllerDelegate> delegate;

-(void) updateNavTitleTo :(NSString *)newNavTitle;

@end
