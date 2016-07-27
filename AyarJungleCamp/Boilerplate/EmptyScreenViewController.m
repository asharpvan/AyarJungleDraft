//
//  EmptyScreenViewController.m
//  Boilerplate
//
//  Created by agatsa on 7/27/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "EmptyScreenViewController.h"

@interface EmptyScreenViewController ()

@end

@implementation EmptyScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) prefersStatusBarHidden {
    
    return TRUE;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
