//
//  GWOptionsViewController.h
//  genericwizard
//
//  Created by Rabindra Nath Sharma on 23/08/17.
//  Copyright © 2017 Rabindra Nath Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"

@interface GWOptionsViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<MyProtocol> delegate;

@property (weak, nonatomic) IBOutlet UITableView *items;

@property (copy, nonatomic) NSArray *itemList;
@property (copy, nonatomic) NSString *selection;
@property (weak, nonatomic) IBOutlet UILabel *queryOnOptionView;
@property (copy, nonatomic) NSString *queryTitle;

@end
