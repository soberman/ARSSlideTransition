//
//  TableViewController.m
//  ARSSlideTransition
//
//  Created by Yaroslav Arsenkin on 25.08.15.
//  Copyright (c) 2015 Iaroslav Arsenkin. All rights reserved.
//

#import "TableViewController.h"
#import "DetailTableViewController.h"
#import "ARSSlideTransition.h"


@interface TableViewController () <UINavigationControllerDelegate, ARSSlideTransitionProtocol>

@end


@implementation TableViewController

static NSString * const kTableViewCell = @"Cell";

#pragma mark -
#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell forIndexPath:indexPath];
    return cell;
}

#pragma mark -
#pragma mark <UINavigationControllerDelegate>

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    ARSSlideTransition *transition = [ARSSlideTransition new];
    transition.operation = operation;
    transition.pushAnimationDuration = 0.45;
    transition.dismissAnimationDuration = 0.45;
    transition.springDamping = 0.8;
    transition.springVelocity = 0.8;
    transition.initialDelay = 0.0;
    transition.elementDelay = 0.05;
    transition.viewDelay = 0.15;
    transition.presentingViewAnimationOption = UIViewAnimationOptionCurveEaseOut;
    transition.presentedViewAnimationOption = UIViewAnimationOptionCurveEaseOut;
    return transition;
}

#pragma mark -
#pragma mark <ARSSlideTransitionProtocol>

- (NSArray *)objectsToAnimate {
    return [self.tableView visibleCells];
}

@end
