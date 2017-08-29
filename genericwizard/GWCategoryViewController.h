//
//  GWCategoryViewController.h
//  genericwizard
//
//  Created by Rabindra Nath Sharma on 23/08/17.
//  Copyright © 2017 Rabindra Nath Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyProtocol.h"

@interface GWCategoryViewController : UIViewController <MyProtocol>

@property (nonatomic, weak) id<MyProtocol> delegate;

//This lable will display the question
@property (weak, nonatomic) IBOutlet UILabel *queryLabel;


// This array will hold categories
@property NSArray *options;

// seelected choice
@property NSString  *selection;
@property  NSDictionary *currentQuery;
@property  NSMutableDictionary *optionForCategory;

@end
