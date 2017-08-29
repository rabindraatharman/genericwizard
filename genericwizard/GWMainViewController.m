//
//  ViewController.m
//  genericwizard
//
//  Created by Rabindra Nath Sharma on 22/08/17.
//  Copyright © 2017 Rabindra Nath Sharma. All rights reserved.
//

#import "GWMainViewController.h"
#import "WizardCell.h"

#import "GWCategoryViewController.h"
#import "GWOptionsViewController.h"

#define CellEdgeInset     20

static NSString *QueryCellID = @"QueryCellID";

@interface GWMainViewController ()
{
    NSMutableArray *questions;
    NSArray *queryListFromJSON;
    NSString *currentQueryStatement;
    int queryIndex;
}

@property (strong, nonatomic) GWCategoryViewController *category;
@property (strong, nonatomic) GWOptionsViewController  *options;

@end

@implementation GWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    queryIndex = -1;
    questions = [[NSMutableArray alloc] init];
    UITableView *queryTable = (id)[self.view viewWithTag:1];
    
    queryTable.rowHeight = 65;
    UINib *nib = [UINib nibWithNibName:@"WizardCell" bundle:nil];
    [queryTable registerNib:nib forCellReuseIdentifier:QueryCellID];    
}

- (IBAction)buttonNextQuestions:(UIButton *)sender {
    NSDictionary *currentQuery = [self getNextQuery];
    
    if(currentQuery) {
        [self showQuery:currentQuery];
        [sender setTitle:@"Next" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
    }
}

- (void) displayCategoryView:(NSDictionary*)query {
    
    if(!self.category) {
        self.category = [self.storyboard instantiateViewControllerWithIdentifier:@"GWCategoryViewController"];
        self.category.delegate = self;
    }

    self.category.currentQuery = query;
    [self setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:self.category animated:YES completion:nil];
}

- (void) displayOptionView:(NSDictionary*)query {
    
    if(!self.options) {
        self.options = [self.storyboard instantiateViewControllerWithIdentifier:@"GWOptionsViewController"];
        self.options.delegate = self;
    }
    
    self.options.queryTitle = [query objectForKey:@"title"];
    self.options.itemList = [query objectForKey:@"options"];
    [self setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:self.options animated:YES completion:nil];
}

- (void) optionViewDismissed {
    NSLog(@"Option view dismissed");
    
    NSString *queryValue = [[NSString alloc] initWithFormat:@"%@", currentQueryStatement];
    NSString *choiceValue = [[NSString alloc] initWithFormat:@"%@", self.options.selection];
    
    NSDictionary *nsDictionary = @{@"query": queryValue, @"choice": choiceValue};
    [questions addObject:nsDictionary];
    UITableView *queryList = (id)[self.view viewWithTag:1];
    [queryList beginUpdates];
    NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:questions.count - 1
                                                               inSection:0]];
    [queryList insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
    [queryList endUpdates];
    
}

- (void) categoryPresentCompletion {
    
    NSString *queryValue = [[NSString alloc] initWithFormat:@"%@", self.category.queryLabel.text];
    NSString *choiceValue = [[NSString alloc] initWithFormat:@"%@", self.category.selection];
    NSDictionary *nsDictionary = @{@"query": queryValue, @"choice": choiceValue};
    [questions addObject:nsDictionary];
    UITableView *queryList = (id)[self.view viewWithTag:1];
    [queryList beginUpdates];
    NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:questions.count - 1
                                                               inSection:0]];
    [queryList insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
    [queryList endUpdates];
}

- (void) endCategoryView {
    
    if(self.category && self.category.view.superview) {
        [self.category.view removeFromSuperview];
    }
    self.category = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section {
    return [questions count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WizardCell *cell = [tableView dequeueReusableCellWithIdentifier: QueryCellID
                                                       forIndexPath:indexPath];
    
    NSDictionary *rowData = questions[indexPath.row];
    cell.name = rowData[@"query"];
    cell.color = rowData[@"choice"];
    return cell;
}

-(void) updateTable {
    NSLog(@"Update Table Executed");
    [self categoryPresentCompletion];
}

- (NSDictionary*) getNextQuery {
    queryListFromJSON = [self readJSONData];
    queryIndex = queryIndex + 1;
    
    if(queryIndex < queryListFromJSON.count) {
        return queryListFromJSON[queryIndex];
    }
    return nil;
}

- (void) showQuery:(NSDictionary*) query {
    
    // query is holding current question
    currentQueryStatement = [query objectForKey:@"title"];
    NSArray *options = [query objectForKey:@"options"];
    
    // If options is list of dictionaries
    if([options[0] isKindOfClass:[NSDictionary class]]) {
        [self displayCategoryView:query];
    }

    if([options[0] isKindOfClass:[NSString class]]) {
        [self displayOptionView:query];
    }
    
}

- (NSArray*) readJSONData {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
