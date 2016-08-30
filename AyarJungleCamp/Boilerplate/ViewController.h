//
//  ViewController.h
//  Boilerplate
//
//  Created by agatsa on 4/1/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyScreenViewController.h"
#import "STTwitter.h"

@interface ViewController : EmptyScreenViewController <STTwitterAPIOSProtocol,EmptyScreenViewControllerDelegate>

-(instancetype)init;

@end

