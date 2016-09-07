//
//  RoomDetailsViewController.m
//  Boilerplate
//
//  Created by Pranav Sah on 08/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "RoomDetailsViewController.h"

@interface RoomDetailsViewController ()
{
    
    HotelAccommodation *roomData;
    UIPageControl *pageControl;
    BOOL isSingleImageParallax;
}


@end

@implementation RoomDetailsViewController

-(instancetype) initWithRoom:(HotelAccommodation *) roomRecieved showAsParallaxView:(BOOL) isParallax {
    
    self = [super init];
    if(self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        roomData = roomRecieved;
        isSingleImageParallax = isParallax;
        NSLog(@"roomData : %@",roomData);
        [self createSubview];
    }
    return self;
}

-(void) createSubview {
    
    self.topView = [[TopBarView alloc]initWithTitle:[roomData roomName] andSize:CGSizeMake(self.view.bounds.size.width, 64)];
    [self.topView setDelegate:self];
    [self.view addSubview:self.topView];
    
    if(!isSingleImageParallax) {
        
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 200 - 40, self.view.frame.size.width, 40)];
        [pageControl setBackgroundColor:[UIColor blackColor]];
        [pageControl setUserInteractionEnabled:FALSE];
    }
    
    self.scrollView.parallaxHeader.view = isSingleImageParallax ? self.parallaxSingleImageHeaderView : self.nonParallaxScrollHeaderView;
    self.scrollView.parallaxHeader.height = 200;
    self.scrollView.parallaxHeader.mode = MXParallaxHeaderModeFill;
    self.scrollView.parallaxHeader.minimumHeight = -self.parallaxContentView.bounds.size.height ;
    [self.scrollView.parallaxHeader.contentView addSubview:pageControl];
    [self.scrollView setBounces:FALSE];
    [self.scrollView addSubview:self.parallaxContentView];
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

#pragma mark <Lazy Loading>

- (MXScrollView *)scrollView {
    
    if(!_scrollView) {
        _scrollView = [[MXScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIScrollView *)nonParallaxScrollHeaderView {
    
    if(!_nonParallaxScrollHeaderView) {
        
        _nonParallaxScrollHeaderView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        [_nonParallaxScrollHeaderView setShowsVerticalScrollIndicator:FALSE];
        [_nonParallaxScrollHeaderView setShowsHorizontalScrollIndicator:FALSE];
        [_nonParallaxScrollHeaderView setDelegate:self];
        
        __block float totalWidth = 0;
        for(int i=0; i<3; i++){
            UIImageView *parallaxImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * _nonParallaxScrollHeaderView.frame.size.width, 0, _nonParallaxScrollHeaderView.frame.size.width, _nonParallaxScrollHeaderView.frame.size.height)];
            [parallaxImageView setContentMode:UIViewContentModeScaleAspectFill];
            [parallaxImageView setImage:[UIImage imageNamed:[roomData roomImage1]]];
            [_nonParallaxScrollHeaderView addSubview:parallaxImageView];
            totalWidth += _nonParallaxScrollHeaderView.frame.size.width;
        }
        
        [_nonParallaxScrollHeaderView setPagingEnabled:TRUE];
        [_nonParallaxScrollHeaderView setContentSize:CGSizeMake(totalWidth, _nonParallaxScrollHeaderView.bounds.size.height)];
        
        [pageControl setNumberOfPages:totalWidth/_nonParallaxScrollHeaderView.frame.size.width];
    }
    return _nonParallaxScrollHeaderView;
}

- (UIImageView *)parallaxSingleImageHeaderView {
    
    if(!_parallaxSingleImageHeaderView) {
        
        _parallaxSingleImageHeaderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
        [_parallaxSingleImageHeaderView setContentMode:UIViewContentModeScaleAspectFill];
        [_parallaxSingleImageHeaderView setImage:[UIImage imageNamed:[roomData roomImage1]]];
        
    }
    return _parallaxSingleImageHeaderView;
}


- (UIView *)parallaxContentView {
    
    if(!_parallaxContentView) {
        
#pragma mark <Change height here for Content View>
        //Change height here for Content View
        _parallaxContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,64)];
        
#pragma mark <Add subview here for Content View>
        NSString *textToShow = nil;
        if(roomData == nil) {
            textToShow = @"This is weird  Should never occur!! Can use NSAssert here";
            
        }else {
            textToShow = @"powered by Ayar Jungle Camp";
            
            UILabel *addr1Label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _parallaxContentView.bounds.size.width - (2*5), 40)];
            [addr1Label setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [addr1Label setText:[NSString stringWithFormat:@"Capacity - %@",[roomData roomCapacity]]];
            [_parallaxContentView addSubview:addr1Label];
            
            
            UILabel *addr2Label = [[UILabel alloc]initWithFrame:CGRectMake(addr1Label.frame.origin.x, addr1Label.frame.origin.y + addr1Label.frame.size.height, addr1Label.frame.size.width, addr1Label.frame.size.height)];
            
            [addr2Label setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [addr2Label setText:[NSString stringWithFormat:@"Room Image One - %@",[roomData roomImage1]]];
            [_parallaxContentView addSubview:addr2Label];
            
            UIButton *bookNow = [[UIButton alloc]initWithFrame:CGRectMake(addr2Label.frame.origin.x, addr2Label.frame.origin.y + addr2Label.frame.size.height, addr2Label.frame.size.width, addr2Label.frame.size.height)];
            [bookNow setTitle:[NSString stringWithFormat:@"Book %@ Now",[roomData roomName]] forState:UIControlStateNormal];
            [bookNow addTarget:self action:@selector(bookNowPressed) forControlEvents:UIControlEventTouchUpInside];
            [bookNow setBackgroundColor:[UIColor blackColor]];
            //            [[totalReviewCount titleLabel] setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            //            [[totalReviewCount titleLabel]setText:[NSString stringWithFormat:@"Total Review Count - %@",[[hotel hotelReview] timesReviewed]]];
            [_parallaxContentView addSubview:bookNow];

            
            
            UILabel *hotelSynopsisLabel = [[UILabel alloc]initWithFrame:CGRectMake(bookNow.frame.origin.x, bookNow.frame.origin.y + bookNow.frame.size.height, addr2Label.frame.size.width, bookNow.frame.size.height)];
            [hotelSynopsisLabel setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [hotelSynopsisLabel setText:[NSString stringWithFormat:@"Room Image Two - %@",[roomData roomImage2]]];
            [_parallaxContentView addSubview:hotelSynopsisLabel];
            
            
            UILabel *hotelHistory = [[UILabel alloc]initWithFrame:CGRectMake(hotelSynopsisLabel.frame.origin.x, hotelSynopsisLabel.frame.origin.y + hotelSynopsisLabel.frame.size.height, hotelSynopsisLabel.frame.size.width, hotelSynopsisLabel.frame.size.height)];
            
            [hotelHistory setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [hotelHistory setText:[NSString stringWithFormat:@"Total Rooms Available - %@",[roomData roomTotal]]];
            [_parallaxContentView addSubview:hotelHistory];
            
            
            UILabel *foodRating = [[UILabel alloc]initWithFrame:CGRectMake(hotelHistory.frame.origin.x, hotelHistory.frame.origin.y + hotelHistory.frame.size.height, hotelHistory.frame.size.width, hotelHistory.frame.size.height)];
            [foodRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [foodRating setText:[NSString stringWithFormat:@"Price - %@",[roomData roomPrice]]];
            [_parallaxContentView addSubview:foodRating];
            
            CGRect temp = _parallaxContentView.frame;
            temp.size.height += foodRating.frame.origin.y + foodRating.frame.size.height;
            [_parallaxContentView setFrame:temp];
        }
        //Add subview here for Content View
        UILabel *lastView = [[UILabel alloc]initWithFrame:CGRectMake(0, _parallaxContentView.frame.size.height - 50, _parallaxContentView.bounds.size.width, 44)];
        [lastView setTextAlignment:NSTextAlignmentCenter];
        [lastView setText:textToShow];
        [_parallaxContentView addSubview:lastView];
        
    }
    return _parallaxContentView;
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    CGRect frame = self.parallaxContentView.frame;
    self.scrollView.contentSize = frame.size;
}

-(BOOL) prefersStatusBarHidden {
    
    return TRUE;
}


-(void) userTappedOnBackButton {
    
    NSLog(@"backbutton Tapped");
    self.topView = nil;
    self.scrollView = nil;
    self.parallaxContentView = nil;
    if(self.parallaxSingleImageHeaderView)
        self.parallaxSingleImageHeaderView = nil;
    else
        self.nonParallaxScrollHeaderView = nil;
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if([scrollView isKindOfClass:[MXScrollView class]]) return;
    //find the page number you are on
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [pageControl setCurrentPage:page];
}

-(void) bookNowPressed {
    
    NSLog(@"Show Booking for %@",[roomData roomName]);
}

@end
