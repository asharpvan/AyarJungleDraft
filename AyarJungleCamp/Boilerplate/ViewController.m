//
//  ViewController.m
//  Boilerplate
//
//  Created by agatsa on 4/1/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "ViewController.h"
#import "POP.h"
#import <Accounts/Accounts.h>
#import "BookingViewController.h"
#import "DashBoardViewController.h"
#import "AFNetworking.h"
#import "GIAPIClient.h"
#import "HotelProfile.h"
#import "HotelProfileViewViewController.h"
#import "HotelProfileViewController.h"
#import "DatabaseClient.h"
#import "AttractionListViewController.h"
#import "AttractionDataModel.h"

typedef void (^accountChooserBlock_t)(ACAccount *account, NSString *errorMessage); // don't bother with NSError for that
@interface ViewController ()
@property (nonatomic, strong) accountChooserBlock_t accountChooserBlock;
@property (nonatomic, strong) STTwitterAPI *twitter;
@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) NSArray *iOSAccounts;

@end

@implementation ViewController

-(instancetype) init {
    
    self = [super init];
    if(self) {
       
        [self setTitle:@"Ayar Jungle Camp"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self setDelegate:self];
        [self createSubview];
    }
    return self;
}

-(void) createSubview {
    
    UIButton *signInButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 60 ,self.view.frame.size.width - (20), 60)];
    [signInButton setTitle:@"Sign In & Post via Oauth" forState:UIControlStateNormal];
    [signInButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [signInButton setBackgroundColor:[UIColor blueColor]];
    [signInButton setTag:1];
    [self.emptyViewScroller addSubview:signInButton];
    
    UIButton *twitterButton = [[UIButton alloc]initWithFrame:CGRectMake(10, signInButton.frame.size.height + signInButton.frame.origin.y + 20 ,self.view.frame.size.width - (20), 60)];
    [twitterButton setTitle:@"Goto WebView" forState:UIControlStateNormal];
    [twitterButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [twitterButton setTag:0];
    [twitterButton setBackgroundColor:[UIColor blueColor]];
    self.topBarThreshold = 100;
    [self.emptyViewScroller addSubview:twitterButton];
    
    
    UIButton *detailsButton = [[UIButton alloc]initWithFrame:CGRectMake(10, twitterButton.frame.size.height + twitterButton.frame.origin.y + 20 ,self.view.frame.size.width - (20), 60)];
    [detailsButton setTitle:@"Call Goibibo for Details" forState:UIControlStateNormal];
    [detailsButton addTarget:self action:@selector(fetchDetailsFromGoibibo:) forControlEvents:UIControlEventTouchUpInside];
    [detailsButton setBackgroundColor:[UIColor blueColor]];
    [self.emptyViewScroller addSubview:detailsButton];
    
    
    UIButton *inAndAroundNainitalButton = [[UIButton alloc]initWithFrame:CGRectMake(10, detailsButton.frame.size.height + detailsButton.frame.origin.y + 20 ,self.view.frame.size.width - (20), 60)];
    [inAndAroundNainitalButton setTitle:@"Open Collection View" forState:UIControlStateNormal];
    [inAndAroundNainitalButton addTarget:self action:@selector(showListofAttractions) forControlEvents:UIControlEventTouchUpInside];
    [inAndAroundNainitalButton setBackgroundColor:[UIColor blueColor]];
    [self.emptyViewScroller addSubview:inAndAroundNainitalButton];
    
    
    UIButton *twitterFeedsbutton = [[UIButton alloc]initWithFrame:CGRectMake(10, inAndAroundNainitalButton.frame.size.height + inAndAroundNainitalButton.frame.origin.y + 20 ,self.view.frame.size.width - (20), 60)];
    [twitterFeedsbutton setTitle:@"Fetch feeds" forState:UIControlStateNormal];
    [twitterFeedsbutton addTarget:self action:@selector(fetchAyarJungleFeeds) forControlEvents:UIControlEventTouchUpInside];
    [twitterFeedsbutton setBackgroundColor:[UIColor blueColor]];
    [self.emptyViewScroller addSubview:twitterFeedsbutton];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.accountStore = [[ACAccountStore alloc] init];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

-(void) buttonPressed:(UIButton *)button {

    //Bounce Animation
    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
    sprintAnimation.springBounciness = 20.f;
    sprintAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if([button tag] == 0)  {
            NSLog(@"Here!!");
            [self loginWithTwitter];
  
            __block DashBoardViewController *dashboard = [[DashBoardViewController alloc]init];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:dashboard animated:TRUE];
            });
            
            [self sendSMS];
        }
        else
            [self signIn:@"Username" withPassword:@"Password"];
    };
    [button pop_addAnimation:sprintAnimation forKey:@"sendAnimation"];
}

-(void) signIn:(NSString *)username withPassword:(NSString *)password {
    
    NSLog(@"Signing in %@ using %@",username,password);
    self.twitter = nil;
    self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:@"" consumerSecret:@"" oauthToken:@"" oauthTokenSecret:@""];
    
    [_twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        
        NSLog(@"@%@ (%@)", username, userID);
        [_twitter postStatusUpdate:@"Trial - \nPranav" inReplyToStatusID:nil latitude:nil longitude:nil placeID:nil displayCoordinates:nil trimUser:nil successBlock:^(NSDictionary *status) {
            NSLog(@"Status Posted : %@",status);
        } errorBlock:^(NSError *error) {
            NSLog(@"Error : %@",[error localizedDescription]);
        }];
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"error : %@",[error localizedDescription]);
    }];
}

-(void) loginWithTwitter {
    
    NSLog(@"Signing in with Twitter");
 
    __weak typeof(self) weakSelf = self;
    
    self.accountChooserBlock = ^(ACAccount *account, NSString *errorMessage) {
        
        NSString *status = nil;
        if(account) {
            status = [NSString stringWithFormat:@"Did select %@", account.username];
            [weakSelf loginWithiOSAccount:account];
        } else {
            status = errorMessage;
        }
        NSLog(@"Status : %@",status);
    };
    [self chooseAccount];
}

- (void)loginWithiOSAccount:(ACAccount *)account {
    
    self.twitter = nil;
    self.twitter = [STTwitterAPI twitterAPIOSWithAccount:account delegate:self];
    
    [_twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        
        NSLog(@"@%@ (%@)", username, userID);
        [self showMeTweets];
        
    } errorBlock:^(NSError *error) {
       
        NSLog(@"error : %@",[error localizedDescription]);
    }];
}


-(void) showMeTweets {
    
    NSString *query = @"ayar Jungle Camp";
    NSString *searchQuery = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Searching For (%@)", searchQuery);
    [_twitter getSearchTweetsWithQuery:searchQuery successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
        
        NSLog(@"Search data : %@",searchMetadata);
        NSLog(@"\n\n Status : %@",statuses);
        
    } errorBlock:^(NSError *error) {
        NSLog(@"Error : %@",error);
    }];
    

    
    
}

- (void)chooseAccount {
    
    ACAccountType *accountType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    ACAccountStoreRequestAccessCompletionHandler accountStoreRequestCompletionHandler = ^(BOOL granted, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            if(granted == NO) {
                _accountChooserBlock(nil, @"Acccess not granted.");
                return;
            }
            
            self.iOSAccounts = [_accountStore accountsWithAccountType:accountType];
            NSLog(@"Twitter Accounts found in iOS Device : %lu",(unsigned long)[_iOSAccounts count]);
            if([_iOSAccounts count] == 1) {
                NSLog(@"Only One Twitter Accounts found in iOS Device");
                ACAccount *account = [_iOSAccounts lastObject];
                _accountChooserBlock(account, nil);
            } else if([_iOSAccounts count] > 1) {
                
                NSLog(@"Multiple Twitter Accounts found in iOS Device");
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select an account:"  message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                        
                    }];
                    [actionSheet addAction:cancelButton];
                
                for(ACAccount *account in _iOSAccounts) {
                   
                    UIAlertAction *optionButton = [UIAlertAction actionWithTitle:account.username style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                        NSLog(@"Login With : %@",account.username);
                        [self loginWithiOSAccount:account];
                        
                    }];
                    [actionSheet addAction:optionButton];
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:actionSheet animated:YES completion:nil];
                });
            } else {
                
                _accountChooserBlock(nil,@"No Twitter Accounts found in iOS Device");
            }
        }];
    };
    
#if TARGET_OS_IPHONE &&  (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0)
    if (floor(NSFoundationVersionNumber) < NSFoundationVersionNumber_iOS_6_0) {
        [self.accountStore requestAccessToAccountsWithType:accountType
                                     withCompletionHandler:accountStoreRequestCompletionHandler];
    } else {
        [self.accountStore requestAccessToAccountsWithType:accountType
                                                   options:NULL
                                                completion:accountStoreRequestCompletionHandler];
    }
#else
    [self.accountStore requestAccessToAccountsWithType:accountType
                                               options:NULL
                                            completion:accountStoreRequestCompletionHandler];
#endif
    
}


#pragma mark STTwitterAPIOSProtocol

- (void)twitterAPI:(STTwitterAPI *)twitterAPI accountWasInvalidated:(ACAccount *)invalidatedAccount {
    if(twitterAPI != _twitter) return;
    NSLog(@"-- account was invalidated: %@ | %@", invalidatedAccount, invalidatedAccount.username);
}


#pragma mark Goibibo APIs

-(void) fetchDetailsFromGoibibo:(id) sender {
    
    UIButton *button = (UIButton *)sender;
    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
    sprintAnimation.springBounciness = 20.f;
    sprintAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        
        NSLog(@"Call AFNetworking Call laced with GOibibo APIs");
        GIAPIClient *apiClient = [[GIAPIClient alloc]init];
        [apiClient fetchHotelDetailsForProfile:^(HotelProfile *ayarDetails, NSError *error) {

//            [[DatabaseClient sharedInstance] openDatabase];
//            [[DatabaseClient sharedInstance] deleteAllRecordFromHotelProfileData];
//            [[DatabaseClient sharedInstance] closeDatabase];
            
            [[DatabaseClient sharedInstance] openDatabase];
            HotelProfile *profileToShow = [[DatabaseClient sharedInstance] fetchHotel];
            [[DatabaseClient sharedInstance] closeDatabase];
            NSLog(@"profileToShow : %@",profileToShow);

            if(!error) {
                
                //Check whether or not the object fetched from net has been modified since last update
                if(!profileToShow || ( profileToShow && [profileToShow hasProfileChangedOverTime:ayarDetails])) {
            
                    [[DatabaseClient sharedInstance] openDatabase];
                    [[DatabaseClient sharedInstance] saveHotelProfileLocally:ayarDetails];
                    [[DatabaseClient sharedInstance] closeDatabase];
                    
                }
                profileToShow = ayarDetails;
            } else {
                
                NSLog(@"error : %@",[error localizedDescription]);
            }

            [profileToShow displaySelectiveHotelProfile];
            
            HotelProfileViewController *hotelProfile = [[HotelProfileViewController alloc]initWithHotelProfile:profileToShow showAsParallaxView:TRUE];
            [self.navigationController pushViewController:hotelProfile animated:TRUE];
        }];
        
    };
    [button pop_addAnimation:sprintAnimation forKey:@"sendAnimation"];
}


-(void) userTappedOnActionButton {
    
    NSLog(@"User Tapped Recieved on ViewController");
}

-(void) fetchAyarJungleFeeds {

    NSLog(@"Login and Fetch Feeds");
    [self loginWithTwitter];

}


-(void) showListofAttractions {
    
    NSLog(@"List of Attractions!!");
    
//    NSMutableArray *attractionListArray = [NSMutableArray new];
//    
//    for(int i =0; i < 25; i++) {
//        AttractionDataModel *dataToFill;
//        if(i%2 == 0){
//            dataToFill = [[AttractionDataModel alloc]initLocalAttraction];
//        } else {
//            dataToFill = [[AttractionDataModel alloc]initAroundAttraction];
//        }
//        [attractionListArray addObject:dataToFill];
//    }
    
    //Without CompletionHandler
//    [[DatabaseClient sharedInstance] openDatabase];
//    NSArray *attractionListArray = [[DatabaseClient sharedInstance] fetchAllAttractions];
//    [[DatabaseClient sharedInstance] closeDatabase];
//    
//    AttractionListViewController *attractionList = [[AttractionListViewController alloc]initWithAttractionList:[attractionListArray copy]];
//    [self.navigationController pushViewController:attractionList animated:TRUE];
    
    [[DatabaseClient sharedInstance] openDatabase];
    [[DatabaseClient sharedInstance] fetchAllAttractions:^(NSArray *attractionListArray, NSString *error) {
        if(!error && attractionListArray){
            AttractionListViewController *attractionList = [[AttractionListViewController alloc]initWithAttractionList:[attractionListArray copy]];
            [self.navigationController pushViewController:attractionList animated:TRUE];
        }
    }];
}



-(void) sendSMS {
    
    NSLog(@"Send SMS");    
}

@end
