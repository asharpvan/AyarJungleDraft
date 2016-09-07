//
//  RoomListViewController.m
//  Boilerplate
//
//  Created by Pranav Sah on 08/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "RoomListViewController.h"
#import "HotelAccommodation.h"
#import "RoomListViewCellCollectionViewCell.h"
#import "RoomDetailsViewController.h"

@interface RoomListViewController (){
    
    UICollectionView *attractionListView;
    NSArray *roomList;
}



@end

@implementation RoomListViewController

-(instancetype) initWithRoomList:(NSArray *) listRecieved {
    
    self = [super init];
    if(self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        roomList = listRecieved;
        [self createSubview];
    }
    return self;
}

-(void) createSubview {
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumLineSpacing:2];
    [layout setItemSize:CGSizeMake(self.view.frame.size.width, (self.view.frame.size.height - 64)/3)];
    
    self.topView = [[TopBarView alloc]initWithTitle:@"Accommodation Types" andSize:CGSizeMake(self.view.bounds.size.width, 64)];
    [self.topView setDelegate:self];
    [self.view addSubview:self.topView];
    
    CGRect frameForListView = CGRectMake(0, self.topView.frame.size.height, self.topView.frame.size.width, self.view.frame.size.height - self.topView.frame.size.height);
    
    attractionListView=[[UICollectionView alloc] initWithFrame:frameForListView collectionViewLayout:layout];
    [attractionListView setDataSource:self];
    [attractionListView setDelegate:self];
    [attractionListView setShowsVerticalScrollIndicator:FALSE];
    [attractionListView setContentInset:UIEdgeInsetsMake(2, 0, 0, 0)];
    [attractionListView setBackgroundColor:[UIColor whiteColor]];
    
    [attractionListView registerClass:[RoomListViewCellCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.view addSubview:attractionListView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [roomList count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RoomListViewCellCollectionViewCell *cell= (RoomListViewCellCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    
    HotelAccommodation *roomToShow = [roomList objectAtIndex:[indexPath row]];
    
    [cell setAccommodationName:[roomToShow roomName]];
    [cell setAccommodationPrice:[[roomToShow roomPrice]stringValue]];
    [cell setAccommodationCapacity:[[roomToShow roomCapacity]stringValue]];
    [cell setAccommodationBackgroundImage:[roomToShow roomImage1]];
    
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    return CGSizeMake(collectionView.bounds.size.width, 200);
//}

-(BOOL) prefersStatusBarHidden {
    
    return TRUE;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HotelAccommodation *roomSelected = (HotelAccommodation *) [roomList objectAtIndex:[indexPath row]];
    NSLog(@"You Selected : %@",[roomSelected roomName]);
    RoomDetailsViewController *roomsDetailsVC = [[RoomDetailsViewController alloc]initWithRoom:roomSelected showAsParallaxView:TRUE];
    [self.navigationController pushViewController:roomsDetailsVC animated:TRUE];
    
}

-(void) userTappedOnBackButton {
    
    NSLog(@"backbutton Tapped");
    self.topView = nil;
    [self.navigationController popViewControllerAnimated:TRUE];
    
}@end
