//
//  AttractionListViewController.m
//  Boilerplate
//
//  Created by Pranav Sah on 06/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "AttractionListViewController.h"
#import "AttractionListViewCell.h"
#import "AttractionDataModel.h"

@interface AttractionListViewController () {
    
    UICollectionView *attractionListView;
    NSArray *attractionList;
}

@end

@implementation AttractionListViewController


-(instancetype) initWithAttractionList:(NSArray *) listRecieved {
    
    self = [super init];
    if(self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        attractionList = listRecieved;
        [self createSubview];
    }
    return self;
}

-(void) createSubview {
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumLineSpacing:2];
    [layout setItemSize:CGSizeMake(self.view.frame.size.width, (self.view.frame.size.height - 64)/3)];
    
    self.topView = [[TopBarView alloc]initWithTitle:@"In and Around Nainital" andSize:CGSizeMake(self.view.bounds.size.width, 64)];
    [self.topView setDelegate:self];
    [self.view addSubview:self.topView];

    CGRect frameForListView = CGRectMake(0, self.topView.frame.size.height, self.topView.frame.size.width, self.view.frame.size.height - self.topView.frame.size.height);
    
    attractionListView=[[UICollectionView alloc] initWithFrame:frameForListView collectionViewLayout:layout];
    [attractionListView setDataSource:self];
    [attractionListView setDelegate:self];
    [attractionListView setShowsVerticalScrollIndicator:FALSE];
    [attractionListView setContentInset:UIEdgeInsetsMake(2, 0, 0, 0)];
    [attractionListView setBackgroundColor:[UIColor whiteColor]];
    
    [attractionListView registerClass:[AttractionListViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
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
   
    return [attractionList count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AttractionListViewCell *cell= (AttractionListViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
   
    
    AttractionDataModel *attractionToShow = [attractionList objectAtIndex:[indexPath row]];
    
    [cell setPlaceName:[attractionToShow attractionName]];
    [cell setPlaceCategory:[attractionToShow isAttractionInNainital]];
    [cell setPlaceDistance:[attractionToShow attractionDistance]];
    [cell setPlaceBackgroundImage:[attractionToShow attractionImageName]];
    
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
    
    AttractionDataModel *attractionSelected = (AttractionDataModel *) [attractionList objectAtIndex:[indexPath row]];
    NSLog(@"You Selected : %@",[attractionSelected attractionName]);

}

-(void) userTappedOnBackButton {
    
    NSLog(@"backbutton Tapped");
    self.topView = nil;
    [self.navigationController popViewControllerAnimated:TRUE];
    
}
@end
