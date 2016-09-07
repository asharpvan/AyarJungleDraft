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
#import "RoomListViewController.h"
#import "RoomDetailsViewController.h"



@interface HotelProfileViewController () {
    
    HotelProfile *hotel;
    UIPageControl *pageControl;
    BOOL isSingleImageParallax;
    
}
@end

@implementation HotelProfileViewController


-(instancetype) initWithHotelProfile:(HotelProfile *) hotelProfileRecieved showAsParallaxView:(BOOL) isParallax {
    
    self = [super init];
    if(self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        hotel = hotelProfileRecieved;
        isSingleImageParallax = isParallax;
        NSLog(@"hotelData : %@",hotel);
        [self createSubview];
    }
    return self;
}

-(void) createSubview {
    
    self.topView = [[TopBarView alloc]initWithTitle:[hotel hotelName] andSize:CGSizeMake(self.view.bounds.size.width, 64)];
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
            [parallaxImageView setImage:[UIImage imageNamed:@"AJC_Restaurant.png"]]; //bannerPic for hotel
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
        [_parallaxSingleImageHeaderView setImage:[UIImage imageNamed:@"AJC_Restaurant.png"]];
        
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
        if(hotel == nil) {
            textToShow = @"No Data to share please check internet!";
       
        }else {
            textToShow = @"powered by Goibibo";
           
            UILabel *addr1Label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _parallaxContentView.bounds.size.width - (2*5), 40)];
            [addr1Label setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [addr1Label setText:[hotel hotelStreetAddr1]];
            [_parallaxContentView addSubview:addr1Label];
            
            
            UILabel *addr2Label = [[UILabel alloc]initWithFrame:[self getFrameUsing:[addr1Label frame]]];
            
            [addr2Label setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [addr2Label setText:[NSString stringWithFormat:@"%@ - %@",[hotel hotelStreetAddr2],[hotel hotelPin]]];
            [_parallaxContentView addSubview:addr2Label];
            
            
            UIButton *showAllRooms = [[UIButton alloc]initWithFrame:[self getFrameUsing:[addr2Label frame]]];
            [showAllRooms setTitle:@"View All Rooms" forState:UIControlStateNormal];
            [showAllRooms addTarget:self action:@selector(someButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [showAllRooms setTag:HotelProfileButtonPressedAccommodationAll];
            [showAllRooms setBackgroundColor:[UIColor blackColor]];
            [_parallaxContentView addSubview:showAllRooms];
            
            
            UILabel *hotelSynopsisLabel = [[UILabel alloc]initWithFrame:[self getFrameUsing:[showAllRooms frame]]];
            [hotelSynopsisLabel setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [hotelSynopsisLabel setText:[hotel hotelSynopsis]];
            [_parallaxContentView addSubview:hotelSynopsisLabel];
            
            UIButton *tweetUs = [[UIButton alloc]initWithFrame:[self getFrameUsing:[hotelSynopsisLabel frame]]];
            [tweetUs setTitle:@"Tweet Us" forState:UIControlStateNormal];
            [tweetUs addTarget:self action:@selector(someButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [tweetUs setTag:HotelProfileButtonPressedTweet];
            [tweetUs setBackgroundColor:[UIColor blackColor]];
            [_parallaxContentView addSubview:tweetUs];
          
            UIButton *callUs = [[UIButton alloc]initWithFrame:[self getFrameUsing:[tweetUs frame]]];
            [callUs setTitle:@"Call" forState:UIControlStateNormal];
            [callUs addTarget:self action:@selector(someButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [callUs setTag:HotelProfileButtonPressedCall];
            [callUs setBackgroundColor:[UIColor blackColor]];
            [_parallaxContentView addSubview:callUs];
            
            UILabel *hotelHistory = [[UILabel alloc]initWithFrame:[self getFrameUsing:[callUs frame]]];
            
            [hotelHistory setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [hotelHistory setText:[hotel hotelHistory]];
            [_parallaxContentView addSubview:hotelHistory];
            
            
            UILabel *foodRating = [[UILabel alloc]initWithFrame:[self getFrameUsing:[hotelHistory frame]]];
            [foodRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [foodRating setText:[NSString stringWithFormat:@"Food - %@",[[hotel hotelRating] foodRating]]];
            [_parallaxContentView addSubview:foodRating];
            
            
            UILabel *locationRating = [[UILabel alloc]initWithFrame:[self getFrameUsing:[foodRating frame]]];
            
            [locationRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [locationRating setText:[NSString stringWithFormat:@"Location - %@",[[hotel hotelRating] locationRating]]];
            [_parallaxContentView addSubview:locationRating];
            
            
            UILabel *amnetiesRating = [[UILabel alloc]initWithFrame:[self getFrameUsing:[locationRating frame]]];
            [amnetiesRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [amnetiesRating setText:[NSString stringWithFormat:@"Amneties - %@",[[hotel hotelRating] foodRating]]];
            [_parallaxContentView addSubview:amnetiesRating];
            
            UILabel *hotelRating = [[UILabel alloc]initWithFrame:[self getFrameUsing:[amnetiesRating frame]]];
            
            [hotelRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [hotelRating setText:[NSString stringWithFormat:@"Hotel - %@",[[hotel hotelRating] hotelRating]]];
            [_parallaxContentView addSubview:hotelRating];
            
            
            UILabel *vfmRating = [[UILabel alloc]initWithFrame:[self getFrameUsing:[hotelRating frame]]];
            [vfmRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [vfmRating setText:[NSString stringWithFormat:@"VFM - %@",[[hotel hotelRating] valueForMoneyRating]]];
            [_parallaxContentView addSubview:vfmRating];
            
            
            UILabel *cleanlinessRating = [[UILabel alloc]initWithFrame:[self getFrameUsing:[vfmRating frame]]];
            
            [cleanlinessRating setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [cleanlinessRating setText:[NSString stringWithFormat:@"Cleanliness - %@",[[hotel hotelRating]cleanlinessRating]]];
            [_parallaxContentView addSubview:cleanlinessRating];
            

            UILabel *positiveReviewCount = [[UILabel alloc]initWithFrame:[self getFrameUsing:[cleanlinessRating frame]]];
            
            [positiveReviewCount setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [positiveReviewCount setText:[NSString stringWithFormat:@"Positive Review Count - %@",[[hotel hotelReview]positiveReviewCount]]];
            [_parallaxContentView addSubview:positiveReviewCount];
            
            
            UILabel *negativeReviewCount = [[UILabel alloc]initWithFrame:[self getFrameUsing:[positiveReviewCount frame]]];
            [negativeReviewCount setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
            [negativeReviewCount setText:[NSString stringWithFormat:@"Negative Review Count - %@",[[hotel hotelReview]negativeReviewCount]]];
            [_parallaxContentView addSubview:negativeReviewCount];
            
            
            UIButton *totalReviewCount = [[UIButton alloc]initWithFrame:[self getFrameUsing:[negativeReviewCount frame]]];
            [totalReviewCount setTitle:[NSString stringWithFormat:@"Total Review Count - %@",[[hotel hotelReview] timesReviewed]] forState:UIControlStateNormal];
            [totalReviewCount addTarget:self action:@selector(someButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [totalReviewCount setTag:HotelProfileButtonPressedReview];
            [totalReviewCount setBackgroundColor:[UIColor blackColor]];
//            [[totalReviewCount titleLabel] setFont:[UIFont systemFontOfSize:17.0f weight:0.0f]];
//            [[totalReviewCount titleLabel]setText:[NSString stringWithFormat:@"Total Review Count - %@",[[hotel hotelReview] timesReviewed]]];
            [_parallaxContentView addSubview:totalReviewCount];
        
            __block CGFloat y = totalReviewCount.frame.origin.y + totalReviewCount.frame.size.height;
            for(HotelAccommodation *accommodationType in  [hotel hotelAccommodationList]) {

                UIButton *accomodationType = [[UIButton alloc]initWithFrame:CGRectMake(totalReviewCount.frame.origin.x, y + 2 , totalReviewCount.frame.size.width, totalReviewCount.frame.size.height)];
                [accomodationType setTitle:[NSString stringWithFormat:@"%@ - INR %@ - %@ Total Rooms",[accommodationType roomName],[accommodationType roomPrice],[accommodationType roomTotal]] forState:UIControlStateNormal];
                [accomodationType addTarget:self action:@selector(someButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
                
                if([[accommodationType accomodationType]unsignedIntegerValue] == AccommodationTypeTent){
                
                    [accomodationType setTag:HotelProfileButtonPressedAccommodationTent];
                }
                
                if([[accommodationType accomodationType]unsignedIntegerValue] == AccommodationType2Bedded){
                    
                    [accomodationType setTag:HotelProfileButtonPressedAccommodation2Bedded];
                }
                
                if([[accommodationType accomodationType]unsignedIntegerValue] == AccommodationType4Bedded){
                    
                    [accomodationType setTag:HotelProfileButtonPressedAccommodation4Bedded];
                }
                
                if([[accommodationType accomodationType]unsignedIntegerValue] == AccommodationTypeMachan){
                    
                    [accomodationType setTag:HotelProfileButtonPressedAccommodationMachan];
                }
                
                
                [accomodationType setBackgroundColor:[UIColor blackColor]];
                [_parallaxContentView addSubview:accomodationType];
                
                y += accomodationType.frame.size.height + 2;
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

-(void) someButtonSelected :(id) sender {
    
    BOOL loadNewViewController = FALSE;
    UIButton *buttonPressed = (UIButton *)sender;
    
    NSArray *allAccommodation = nil;
    HotelAccommodation *individualAccommodation = nil;
    
    if(([buttonPressed tag] == HotelProfileButtonPressedAccommodationTent) ||
       ([buttonPressed tag] == HotelProfileButtonPressedAccommodation2Bedded) ||
       ([buttonPressed tag] == HotelProfileButtonPressedAccommodation4Bedded) ||
       ([buttonPressed tag] == HotelProfileButtonPressedAccommodationMachan)) {
        for(HotelAccommodation *accommodationType in  [hotel hotelAccommodationList]) {
            if(([[accommodationType accomodationType]unsignedIntegerValue] == [buttonPressed tag])) {
                individualAccommodation = accommodationType;
            }
        }
        loadNewViewController = TRUE;
    }
    
    if([buttonPressed tag] == HotelProfileButtonPressedAccommodationAll) {
        allAccommodation = [hotel hotelAccommodationList];
        loadNewViewController = TRUE;
    }

    if(loadNewViewController) {
        UIViewController *viewControllerToLoad;
        if(allAccommodation != nil) {
            NSLog(@"Show List");
            viewControllerToLoad = [[RoomListViewController alloc]initWithRoomList:allAccommodation];
        }else {
            
            NSLog(@"Show Room Types");
            viewControllerToLoad = [[RoomDetailsViewController alloc]initWithRoom:individualAccommodation showAsParallaxView:TRUE];
        }
        
        [self.navigationController pushViewController:viewControllerToLoad animated:TRUE];
  }
    else {
        switch ([buttonPressed tag]) {
            case HotelProfileButtonPressedReview:
                NSLog(@"Review Pressed");
                break;
            case HotelProfileButtonPressedCall:
                NSLog(@"Call Pressed");
                break;
            case HotelProfileButtonPressedTweet:
                NSLog(@"Tweet Pressed");
                break;
            default:
                break;
        }
        
    }
    
}


-(CGRect) getFrameUsing:(CGRect) rectRecieved {
    
    return CGRectMake(rectRecieved.origin.x, rectRecieved.origin.y + rectRecieved.size.height + 2, rectRecieved.size.width, rectRecieved.size.height);
}
////dragging ends, please switch off paging to listen for this event
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *) targetContentOffset {
//    
//    NSLog(@"%@",[scrollView class]);
//    if([scrollView isKindOfClass:[MXScrollView class]]) return;
//    //find the page number you are on
//    CGFloat pageWidth = scrollView.frame.size.width;
//    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    NSLog(@"Dragging - You are now on page %i",page);
//    
//}
@end
