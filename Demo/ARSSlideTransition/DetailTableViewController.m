//
//  DetailTableViewController.m
//  ARSSlideTransition
//
//  Created by Yaroslav Arsenkin on 25.08.15.
//  Copyright (c) 2015 Iaroslav Arsenkin. All rights reserved.
//  Website: http://arsenkin.com
//

#import "DetailTableViewController.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

static NSString * const kDetailTableViewCell = @"Smooth";

#pragma mark -
#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTableView];
}

#pragma mark -
#pragma mark Visual

- (void)configureTableView {
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDetailTableViewCell forIndexPath:indexPath];
    return cell;
}

#pragma mark -
#pragma mark <ARSSlideTransitionProtocol>

- (NSArray *)objectsToAnimate {
    return [self.tableView visibleCells];
}

@end
