//
//  GWOptionsViewController.m
//  genericwizard
//
//  Created by Rabindra Nath Sharma on 23/08/17.
//  Copyright © 2017 Rabindra Nath Sharma. All rights reserved.
//

#import "GWOptionsViewController.h"

@interface GWOptionsViewController ()

@property (weak, nonatomic) IBOutlet UIView *tablePopupView;

@end

@implementation GWOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tablePopupView.layer.cornerRadius = 10;
    self.tablePopupView.layer.masksToBounds = YES;
    self.items = (id)[self.view viewWithTag:2];
    self.items.dataSource = self;
    self.items.delegate = self;
    self.queryOnOptionView.text = self.queryTitle;
}

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section {
    return [self.itemList count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *SimpleTableIdentifier = @"SBIDGWOptionsViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
    }
    cell.textLabel.text = self.itemList[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) iamDismissed {
    [self.delegate optionViewDismissed];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selection = cell.textLabel.text;
    
    [self dismissViewControllerAnimated:NO completion:^{[self iamDismissed];}];
}

@end
