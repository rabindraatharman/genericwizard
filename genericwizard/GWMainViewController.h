//
//  ViewController.h
//  genericwizard
//
//  Created by Rabindra Nath Sharma on 22/08/17.
//  Copyright © 2017 Rabindra Nath Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"

@interface GWMainViewController : UIViewController <UITableViewDataSource,
UITableViewDelegate, MyProtocol>

- (void) categoryPresentCompletion;

@end

