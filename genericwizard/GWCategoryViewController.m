//
//  GWCategoryViewController.m
//  genericwizard
//
//  Created by Rabindra Nath Sharma on 23/08/17.
//  Copyright © 2017 Rabindra Nath Sharma. All rights reserved.
//

#import "GWCategoryViewController.h"
#import "GWMainViewController.h"
#import "GWOptionsViewController.h"

#import "MyProtocol.h"

#define MaxRow          16
#define MaxCol          4
#define ButtonWidth     80
#define ButtonHeight    40
#define ButtonLayoutYPos    119
#define ButtonLayoutXPos    16


@interface GWCategoryViewController ()

@property (strong, nonatomic) GWOptionsViewController  *itemsView;

@end

@implementation GWCategoryViewController


- (IBAction)presentItems:(id)sender {
    
    if(!self.itemsView) {
        self.itemsView = [self.storyboard instantiateViewControllerWithIdentifier:@"GWOptionsViewController"];
    }
    
    [self setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:self.itemsView animated:YES completion:nil];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.queryLabel.text = [self.currentQuery objectForKey:@"title"];
    self.options = [self.currentQuery objectForKey:@"options"];
    
    if(self.optionForCategory == nil) {
        self.optionForCategory = [[NSMutableDictionary alloc] init];
    } else {
        [self.optionForCategory removeAllObjects];
    }
    
    NSMutableArray *buttonCategories = [[NSMutableArray alloc] init];
    
    for(NSDictionary *option in self.options) {
        
        NSString *categoryName = [option objectForKey:@"category"];
        NSArray *items = [option objectForKey:@"items"] ;
        
        if(items == nil) {
            items = [[NSArray alloc] init];
        }
       
        [self.optionForCategory setObject:items forKey:categoryName];
        [buttonCategories addObject:categoryName];
    }
    [self drawButtons:buttonCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)categoryDone:(id)sender {

    if([sender isKindOfClass:[UIButton class]]) {
        self.selection = [(UIButton*)sender currentTitle];
    }
    
    if(!self.itemsView) {
        self.itemsView = [self.storyboard instantiateViewControllerWithIdentifier:@"GWOptionsViewController"];
        self.itemsView.delegate = self;
    }
    
    self.itemsView.itemList = [self.optionForCategory objectForKey:self.selection];
    if(self.itemsView.itemList.count > 0) {
        self.itemsView.queryTitle = [self.currentQuery objectForKey:@"title"];
        [self setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:self.itemsView animated:YES completion:nil];
    } else {
        self.selection = [(UIButton*)sender currentTitle];
        [self dismissViewControllerAnimated:NO completion:^{[self iamDismissed];}];
    }
}

- (void) iamDismissed {
    [self.delegate updateTable];
}

- (void) addCutomeButton:(NSString*)title at:(CGRect) rect {
    
    // Set button attributes
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]
                 forState:UIControlStateNormal];
    [button addTarget:self action:@selector(categoryDone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void) drawButtons:(NSArray*) buttonTitles {

    for (int row = 0; row < MaxRow; row = row + 1) {
        for( int col = 0; col < MaxCol && (row * MaxCol + col) < buttonTitles.count; col = col + 1) {
            
            int index = row * MaxCol + col;
            NSString *title = buttonTitles[index];

            [self addCutomeButton:title at:CGRectMake(col * (ButtonWidth + 10) + ButtonLayoutXPos,
                                                      row * (ButtonHeight + 10) + ButtonLayoutYPos,
                                                    ButtonWidth, ButtonHeight)];
        }
    }
}

- (void) optionViewDismissed {
    self.selection = self.itemsView.selection;
    [self dismissViewControllerAnimated:NO completion:^{[self iamDismissed];}];
}

-(void) updateTable {
    NSLog(@"Not Implemented");
}

@end
