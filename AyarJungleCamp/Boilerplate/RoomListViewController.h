//
//  RoomListViewController.h
//  Boilerplate
//
//  Created by Pranav Sah on 08/09/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBarView.h"

@interface RoomListViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TopBarViewDelegate>

@property (nonatomic, strong) TopBarView *topView;

-(instancetype) initWithRoomList:(NSArray *) listRecieved;

@end
