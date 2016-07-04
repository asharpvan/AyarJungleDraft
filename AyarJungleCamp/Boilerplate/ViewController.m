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
        [self createSubview];
    }
    return self;
}

-(void) createSubview {
    
    UIButton *signInButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 120 ,self.view.frame.size.width - (20), 60)];
    [signInButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [signInButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [signInButton setBackgroundColor:[UIColor blueColor]];
    [signInButton setTag:0];
    [self.view addSubview:signInButton];
    
    UIButton *twitterButton = [[UIButton alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height - 120 ,self.view.frame.size.width - (20), 60)];
    [twitterButton setTitle:@"Log in with Twitter" forState:UIControlStateNormal];
    [twitterButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [twitterButton setTag:1];
    [twitterButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:twitterButton];
    
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
        if([button tag] == 0)
            [self signIn:@"Username" withPassword:@"Password"];
        else
            [self loginWithTwitter];
    };
    [button pop_addAnimation:sprintAnimation forKey:@"sendAnimation"];
}

-(void) signIn:(NSString *)username withPassword:(NSString *)password {
    
    NSLog(@"Signing in %@ using %@",username,password);
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
        
    } errorBlock:^(NSError *error) {
       
        NSLog(@"error : %@",[error localizedDescription]);
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
            NSLog(@"Twitter Accounts found in iOS Device : %lu",[_iOSAccounts count]);
            if([_iOSAccounts count] == 1) {
                NSLog(@"Only One Twitter Accounts found in iOS Device");
//                ACAccount *account = [_iOSAccounts lastObject];
//                _accountChooserBlock(account, nil);
            } else if([_iOSAccounts count] > 1) {
                
                NSLog(@"Multiple Twitter Accounts found in iOS Device");
                
//                UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Select an account:"
//                                                                delegate:self
//                                                       cancelButtonTitle:@"Cancel"
//                                                  destructiveButtonTitle:nil otherButtonTitles:nil];
//                for(ACAccount *account in _iOSAccounts) {
//                    [as addButtonWithTitle:[NSString stringWithFormat:@"@%@", account.username]];
//                }
//                [as showInView:self.view.window];
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


@end
