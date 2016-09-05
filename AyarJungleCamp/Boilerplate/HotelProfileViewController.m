//
//  HotelProfileViewController.m
//  Boilerplate
//
//  Created by Pranav Sah on 29/08/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "HotelProfileViewController.h"
#import "HotelProfile.h"
#import "HotelRating.h"
#import "HotelReview.h"
#import "HotelAccommodation.h"



@interface HotelProfileViewController () {
    
    HotelProfile *hotel;
    UIPageControl *pageControl;
    
}
@end

@implementation HotelProfileViewController


-(instancetype) initWithHotelProfile:(HotelProfile *) hotelProfileRecieved {
    
    self = [super init];
    if(self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        hotel = hotelProfileRecieved;
        NSLog(@"hotel : %@",hotel);
        [self createSubview];
    }
    return self;
}

-(void) createSubview {

    self.topView = [[TopBarView alloc]initWithTitle:@"Ayar Jungle Camp" andSize:CGSizeMake(self.view.bounds.size.width, 64)];
    [self.topView setDelegate:self];
    [self.view addSubview:self.topView];

    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 200 - 40, self.view.frame.size.width, 40)];
    [pageControl setBackgroundColor:[UIColor blackColor]];
    
    self.scrollView.parallaxHeader.view = self.parallaxHeaderView;
    self.scrollView.parallaxHeader.height = 200;
    self.scrollView.parallaxHeader.mode = MXParallaxHeaderModeFill;
    self.scrollView.parallaxHeader.minimumHeight = -self.parallaxContentView.bounds.size.height ;
    [self.scrollView setBounces:FALSE];
    [self.scrollView addSubview:self.parallaxContentView];
    [self.scrollView.parallaxHeader.contentView addSubview:pageControl];
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

- (UIScrollView *)parallaxHeaderView {
    
    if(!_parallaxHeaderView) {
        
        _parallaxHeaderView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        [_parallaxHeaderView setShowsVerticalScrollIndicator:FALSE];
        [_parallaxHeaderView setShowsHorizontalScrollIndicator:FALSE];
        [_parallaxHeaderView setDelegate:self];
        
        __block float totalWidth = 0;
        for(int i=0; i<3; i++){
            UIImageView *parallaxImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * _parallaxHeaderView.frame.size.width, 0, _parallaxHeaderView.frame.size.width, _parallaxHeaderView.frame.size.height)];
            [parallaxImageView setContentMode:UIViewContentModeScaleAspectFill];
            [parallaxImageView setImage:[UIImage imageNamed:@"AJC_Restaurant.png"]];
            [_parallaxHeaderView addSubview:parallaxImageView];
            totalWidth += _parallaxHeaderView.frame.size.width;
        }

        [_parallaxHeaderView setPagingEnabled:TRUE];
        [_parallaxHeaderView setContentSize:CGSizeMake(totalWidth, _parallaxHeaderView.bounds.size.height)];
        
//        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 100, _parallaxHeaderView.frame.size.width, 40)];
        [pageControl setNumberOfPages:totalWidth/_parallaxHeaderView.frame.size.width];
//        [pageControl setBackgroundColor:[UIColor grayColor]];
//        [self.view addSubview:pageControl];
////
//        [self.view bringSubviewToFront:pageControl];
        
        
    }
    return _parallaxHeaderView;
}

//- (UIImageView *)parallaxHeaderView {
//    
//    if(!_parallaxHeaderView) {
//        
//        _parallaxHeaderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
//        [_parallaxHeaderView setContentMode:UIViewContentModeScaleAspectFill];
//        [_parallaxHeaderView setImage:[UIImage imageNamed:@"AJC_Restaurant.png"]];
// 
//        /* Add additional view here*/
//        
//        //        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, _parallaxHeaderView.frame.size.height - 44, _parallaxHeaderView.frame.size.width, 40)];
//        //        [text setBackgroundColor:[UIColor grayColor]];
//        //        [_parallaxHeaderView addSubview:text];
//        
//    }
//    return _parallaxHeaderView;
//}


- (UIView *)parallaxContentView {
   
    if(!_parallaxContentView) {
        
        #pragma mark <Change height here for Content View>
        //Change height here for Content View
        _parallaxContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,64)];
        
        #pragma mark <Add subview here for Content View>
        NSString *textToShow = nil;
        if(hotel == nil) {
            textToShow = @"No Data to share please check internet!";
       
        }else {
            textToShow = @"powered by Goibibo";
           
            UILabel *addr1Label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _parallaxContentView.bounds.size.width - (2*5), 40)];
            [addr1Label setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [addr1Label setText:[hotel hotelStreetAddr1]];
            [_parallaxContentView addSubview:addr1Label];
            
            
            UILabel *addr2Label = [[UILabel alloc]initWithFrame:CGRectMake(addr1Label.frame.origin.x, addr1Label.frame.origin.y + addr1Label.frame.size.height, addr1Label.frame.size.width, addr1Label.frame.size.height)];
            
            [addr2Label setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [addr2Label setText:[NSString stringWithFormat:@"%@ - %@",[hotel hotelStreetAddr2],[hotel hotelPin]]];
            [_parallaxContentView addSubview:addr2Label];
            
            
            UILabel *hotelSynopsisLabel = [[UILabel alloc]initWithFrame:CGRectMake(addr2Label.frame.origin.x, addr2Label.frame.origin.y + addr2Label.frame.size.height, addr2Label.frame.size.width, addr2Label.frame.size.height)];
            [hotelSynopsisLabel setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [hotelSynopsisLabel setText:[hotel hotelSynopsis]];
            [_parallaxContentView addSubview:hotelSynopsisLabel];
            
            
            UILabel *hotelHistory = [[UILabel alloc]initWithFrame:CGRectMake(hotelSynopsisLabel.frame.origin.x, hotelSynopsisLabel.frame.origin.y + hotelSynopsisLabel.frame.size.height, hotelSynopsisLabel.frame.size.width, hotelSynopsisLabel.frame.size.height)];
            
            [hotelHistory setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [hotelHistory setText:[hotel hotelHistory]];
            [_parallaxContentView addSubview:hotelHistory];
            
            
            UILabel *foodRating = [[UILabel alloc]initWithFrame:CGRectMake(hotelHistory.frame.origin.x, hotelHistory.frame.origin.y + hotelHistory.frame.size.height, hotelHistory.frame.size.width, hotelHistory.frame.size.height)];
            [foodRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [foodRating setText:[NSString stringWithFormat:@"Food - %@",[[hotel hotelRating] foodRating]]];
            [_parallaxContentView addSubview:foodRating];
            
            
            UILabel *locationRating = [[UILabel alloc]initWithFrame:CGRectMake(foodRating.frame.origin.x, foodRating.frame.origin.y + foodRating.frame.size.height, foodRating.frame.size.width, foodRating.frame.size.height)];
            
            [locationRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [locationRating setText:[NSString stringWithFormat:@"Location - %@",[[hotel hotelRating] locationRating]]];
            [_parallaxContentView addSubview:locationRating];
            
            
            UILabel *amnetiesRating = [[UILabel alloc]initWithFrame:CGRectMake(locationRating.frame.origin.x, locationRating.frame.origin.y + locationRating.frame.size.height, locationRating.frame.size.width, locationRating.frame.size.height)];
            [amnetiesRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [amnetiesRating setText:[NSString stringWithFormat:@"Amneties - %@",[[hotel hotelRating] foodRating]]];
            [_parallaxContentView addSubview:amnetiesRating];
            
            UILabel *hotelRating = [[UILabel alloc]initWithFrame:CGRectMake(amnetiesRating.frame.origin.x, amnetiesRating.frame.origin.y + amnetiesRating.frame.size.height, amnetiesRating.frame.size.width, amnetiesRating.frame.size.height)];
            
            [hotelRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [hotelRating setText:[NSString stringWithFormat:@"Hotel - %@",[[hotel hotelRating] hotelRating]]];
            [_parallaxContentView addSubview:hotelRating];
            
            
            UILabel *vfmRating = [[UILabel alloc]initWithFrame:CGRectMake(hotelRating.frame.origin.x, hotelRating.frame.origin.y + hotelRating.frame.size.height, hotelRating.frame.size.width, hotelRating.frame.size.height)];
            [vfmRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [vfmRating setText:[NSString stringWithFormat:@"VFM - %@",[[hotel hotelRating] valueForMoneyRating]]];
            [_parallaxContentView addSubview:vfmRating];
            
            
            UILabel *cleanlinessRating = [[UILabel alloc]initWithFrame:CGRectMake(vfmRating.frame.origin.x, vfmRating.frame.origin.y + vfmRating.frame.size.height, vfmRating.frame.size.width, vfmRating.frame.size.height)];
            
            [cleanlinessRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [cleanlinessRating setText:[NSString stringWithFormat:@"Cleanliness - %@",[[hotel hotelRating]cleanlinessRating]]];
            [_parallaxContentView addSubview:cleanlinessRating];
            

            UILabel *positiveReviewCount = [[UILabel alloc]initWithFrame:CGRectMake(cleanlinessRating.frame.origin.x, cleanlinessRating.frame.origin.y + cleanlinessRating.frame.size.height, amnetiesRating.frame.size.width, cleanlinessRating.frame.size.height)];
            
            [positiveReviewCount setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [positiveReviewCount setText:[NSString stringWithFormat:@"Positive Review Count - %@",[[hotel hotelReview]positiveReviewCount]]];
            [_parallaxContentView addSubview:positiveReviewCount];
            
            
            UILabel *negativeReviewCount = [[UILabel alloc]initWithFrame:CGRectMake(positiveReviewCount.frame.origin.x, positiveReviewCount.frame.origin.y + positiveReviewCount.frame.size.height, positiveReviewCount.frame.size.width, positiveReviewCount.frame.size.height)];
            [negativeReviewCount setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [negativeReviewCount setText:[NSString stringWithFormat:@"Negative Review Count - %@",[[hotel hotelReview]negativeReviewCount]]];
            [_parallaxContentView addSubview:negativeReviewCount];
            
            
            UILabel *totalReviewCount = [[UILabel alloc]initWithFrame:CGRectMake(negativeReviewCount.frame.origin.x, negativeReviewCount.frame.origin.y + negativeReviewCount.frame.size.height, negativeReviewCount.frame.size.width, negativeReviewCount.frame.size.height)];
            
            [totalReviewCount setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [totalReviewCount setText:[NSString stringWithFormat:@"Total Review Count - %@",[[hotel hotelReview] timesReviewed]]];
            [_parallaxContentView addSubview:totalReviewCount];
            
        
            __block CGFloat y = totalReviewCount.frame.origin.y + totalReviewCount.frame.size.height;
            for(HotelAccommodation *accommodationType in  [hotel hotelAccommodationList]) {

                UILabel *accomodationType = [[UILabel alloc]initWithFrame:CGRectMake(totalReviewCount.frame.origin.x, y , totalReviewCount.frame.size.width, totalReviewCount.frame.size.height)];
                
                [accomodationType setFont:[UIFont systemFontOfSize:10.0f weight:0.0f]];
                [accomodationType setText:[NSString stringWithFormat:@"%@ - INR %@ - %@ Total Rooms",[accommodationType roomName],[accommodationType roomPrice],[accommodationType roomTotal]]];
                [_parallaxContentView addSubview:accomodationType];
                
                y += accomodationType.frame.size.height;
            }
        
            CGRect temp = _parallaxContentView.frame;
            temp.size.height += y;
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
    self.parallaxHeaderView = nil;
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if([scrollView isKindOfClass:[MXScrollView class]]) return;
    //find the page number you are on
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"Decelerating - You are now on page %i",page);

    [pageControl setCurrentPage:page];
}

//dragging ends, please switch off paging to listen for this event
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *) targetContentOffset {
    
    NSLog(@"%@",[scrollView class]);
    if([scrollView isKindOfClass:[MXScrollView class]]) return;
    //find the page number you are on
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"Dragging - You are now on page %i",page);
    
}
@end
