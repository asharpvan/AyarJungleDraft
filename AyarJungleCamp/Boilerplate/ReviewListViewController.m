//
//  ReviewListViewController.m
//  Boilerplate
//
//  Created by Pranav Sah on 14/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "ReviewListViewController.h"
#import "ReviewDetails.h"
#import "ReviewListViewCell.h"
#import "GIAPIClient.h"
#import "ReviewLoadedViewCell.h"
#import "ReviewLoadingViewCell.h"


@interface ReviewListViewController () {
    
    UICollectionView *attractionListView;
    NSMutableArray *holderArray;
    NSNumber *offset;
    NSNumber *totalReviewsToLoad;
    BOOL shouldLoadMore;
    NSString *noLoadReason;
}


@end

@implementation ReviewListViewController

-(instancetype)initWithTotalReviews:(NSNumber *)totalReviews {
    
    self = [super init];
    if(self) {
        totalReviewsToLoad = totalReviews;
        NSLog(@"totalReviewsToLoad : %d",[totalReviewsToLoad integerValue]);
        offset = [NSNumber numberWithInt:0];
        noLoadReason = nil;
        [self setLoadMore:TRUE];
        [self createSubview];
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
//    [self loadMoreReviews];
}


- (void)setLoadMore:(BOOL)loadMore {
    
    shouldLoadMore = loadMore;
}


-(void) createSubview {
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumLineSpacing:2];
    
    holderArray = [NSMutableArray new];
    
    self.topView = [[TopBarView alloc]initWithTitle:@"Reviews" andSize:CGSizeMake(self.view.bounds.size.width, 64)];
    [self.topView setDelegate:self];
    [self.view addSubview:self.topView];
    
    CGRect frameForListView = CGRectMake(0, self.topView.frame.size.height, self.topView.frame.size.width, self.view.frame.size.height - self.topView.frame.size.height);
    
    attractionListView=[[UICollectionView alloc] initWithFrame:frameForListView collectionViewLayout:layout];
    [attractionListView setDataSource:self];
    [attractionListView setDelegate:self];
    [attractionListView setBounces:FALSE];
    [attractionListView setShowsVerticalScrollIndicator:FALSE];
    [attractionListView setContentInset:UIEdgeInsetsMake(2, 0, 0, 0)];
    [attractionListView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:attractionListView];
    
    [attractionListView registerClass:[ReviewListViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [attractionListView registerClass:[ReviewLoadedViewCell class] forCellWithReuseIdentifier:@"cellIdentifier1"];
    [attractionListView registerClass:[ReviewLoadingViewCell class] forCellWithReuseIdentifier:@"cellIdentifier2"];
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
    
    return [holderArray count] + 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //check if we have records in the holder array
    if(shouldLoadMore) {
        if(indexPath.row < [holderArray count]) {
            ReviewListViewCell *cell= (ReviewListViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
            ReviewDetails *reviewToShow = [holderArray objectAtIndex:[indexPath row]];
            [cell setReviewerFirstName:[reviewToShow reviewerFirstName] andLastName:[reviewToShow reviewerLastName]];
            [cell setReviewerCreationDate:[reviewToShow createdAt]];
            [cell setReviewerRatings:[reviewToShow totalRating]];
            
            return cell;
        }else {
            
            ReviewLoadingViewCell *cell= (ReviewLoadingViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier2" forIndexPath:indexPath];
            [cell setStartAnimating];
            
            return cell;
        }
    }/*if(!shouldShowLoadingCell) block ends */else {
        
        if(indexPath.row < [holderArray count]) {
            ReviewListViewCell *cell= (ReviewListViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
            ReviewDetails *reviewToShow = [holderArray objectAtIndex:[indexPath row]];
            [cell setReviewerFirstName:[reviewToShow reviewerFirstName] andLastName:[reviewToShow reviewerLastName]];
            [cell setReviewerCreationDate:[reviewToShow createdAt]];
            [cell setReviewerRatings:[reviewToShow totalRating]];
            
            
            return cell;
        }else {
            ReviewLoadedViewCell *cell= (ReviewLoadedViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier1" forIndexPath:indexPath];
            [cell setUpdateLoadedCellReason:noLoadReason];
            return cell;
        }
    }
}

-(BOOL) prefersStatusBarHidden {
    
    return TRUE;
}

-(void) loadMoreReviews {
    
    
    GIAPIClient *apiClient = [[GIAPIClient alloc]init];
    if([apiClient getIsQueryExecuting])
        return;
    NSLog(@"Load With Offset : %d",[offset integerValue]);
    if(!shouldLoadMore) {
        return;
    }
    
    [apiClient fetchReviewsWithOffset:offset onCompletion:^(NSMutableArray *listOfReviews, NSError *error) {
        if(!error && listOfReviews){
            [holderArray addObjectsFromArray:listOfReviews];
            [attractionListView reloadData];
            offset = [NSNumber numberWithInteger:[holderArray count]];
            NSLog(@"offset : %d",[offset integerValue]);
            NSLog(@"Reviews to Load More : %d",([totalReviewsToLoad integerValue] - [offset integerValue]));
            if(([totalReviewsToLoad integerValue] - [offset integerValue]) > 0)
                [self setLoadMore:TRUE];
            else {
                noLoadReason = @"No More Reviews";
                [self setLoadMore:FALSE];
            }
        }/*if(!errorString && recordsArray) block end*/ else {
            [attractionListView reloadData];
            noLoadReason = [error localizedDescription];
            NSLog(@"error: %@",[error localizedDescription]);
            [self setLoadMore:FALSE];
        }
    }];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ReviewDetails *reviewSelected = (ReviewDetails *) [holderArray objectAtIndex:[indexPath row]];
    NSLog(@"You Selected Review which has time : %@",[reviewSelected createdAt]);
}

-(void) userTappedOnBackButton {
    
    NSLog(@"backbutton Tapped");
    self.topView = nil;
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row < [holderArray count]) {
        return CGSizeMake(self.view.frame.size.width, 88);
    }else {
        return CGSizeMake(self.view.frame.size.width, 44);
    }
}

-(void) collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (cell.tag == 1010) {
        [self loadMoreReviews];
    }
}

@end
