//
//  ARSSlideTransition.m
//  ARSSlideTransition
//
//  Created by Yaroslav Arsenkin on 25.08.15.
//  Copyright (c) 2015 Iaroslav Arsenkin. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the LICENSE file in the root directory of this source tree.

#import "ARSSlideTransition.h"


@interface ARSSlideTransition ()

@property (weak, nonatomic) id<UIViewControllerContextTransitioning> context;
@property (nonatomic) CGFloat animationDuration;

@end


@implementation ARSSlideTransition

#pragma mark -
#pragma mark <UIViewControllerAnimatedTransitioning>

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.pushAnimationDuration = self.pushAnimationDuration ? self.pushAnimationDuration : 0.45;
    self.dismissAnimationDuration = self.dismissAnimationDuration ? self.dismissAnimationDuration : 0.45;
    self.animationDuration = UINavigationControllerOperationPush == self.operation ? self.pushAnimationDuration : self.dismissAnimationDuration;
    return self.animationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.context = transitionContext;
    [self checkIncomingViewControllers];
    
    id fromVC = [self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    id toVC = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    [[self.context containerView] addSubview:[toVC view]];
    
    CGFloat delta = CGRectGetWidth([toVC view].frame);
    delta = UINavigationControllerOperationPush == self.operation ? delta : delta * (-1);
    
    [toVC view].frame = [self.context finalFrameForViewController:toVC];
    [toVC view].transform = CGAffineTransformMakeTranslation(delta, 0);
    
    [self animationFromViewController:fromVC toViewController:toVC delta:delta];
}

- (void)animationEnded:(BOOL)transitionCompleted {
    id viewController = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [viewController view].transform = CGAffineTransformIdentity;
    for (UIView *object in [viewController objectsToAnimate]) {
        object.transform = CGAffineTransformIdentity;
    }
}

#pragma mark -
#pragma mark Helpers

- (void)animationFromViewController:(id)fromVC toViewController:(id)toVC delta:(CGFloat)delta {
    __block NSTimeInterval timeOffset = self.initialDelay ? self.initialDelay : 0.0;
    self.springDamping = self.springDamping ? self.springDamping : 0.8;
    self.springVelocity = self.springVelocity ? self.springVelocity : 0.8;
    self.elementDelay = self.elementDelay ? self.elementDelay : 0.05;
    self.viewDelay = self.viewDelay ? self.viewDelay : 0.15;
    self.presentedViewAnimationOption = self.presentedViewAnimationOption ? self.presentedViewAnimationOption : UIViewAnimationOptionCurveEaseOut;
    self.presentingViewAnimationOption = self.presentingViewAnimationOption ? self.presentingViewAnimationOption : UIViewAnimationOptionCurveEaseOut;
    
    [UIView animateWithDuration:0.0 delay:0.0 options:self.animationDuration animations:nil completion:^(BOOL finished) {
        for (UIView *object in [fromVC objectsToAnimate]) {
            [UIView animateWithDuration:self.animationDuration delay:timeOffset usingSpringWithDamping:self.springDamping initialSpringVelocity:self.springVelocity options:self.presentingViewAnimationOption animations:^{
                object.transform = CGAffineTransformMakeTranslation(-delta, 0);
            } completion:nil];
            
            timeOffset += self.elementDelay;
        }
        
        timeOffset = self.viewDelay;
        for (NSInteger i = 0; i < [toVC objectsToAnimate].count; i++) {
            UIView *object = [[toVC objectsToAnimate] objectAtIndex:i];
            BOOL isLastObject = i == [toVC objectsToAnimate].count - 1;
            void(^completionBlock)(BOOL) = !isLastObject ? nil : ^(BOOL finished) {
                [self.context completeTransition:YES];
            };
            
            [UIView animateWithDuration:self.animationDuration delay:timeOffset usingSpringWithDamping:self.springDamping initialSpringVelocity:self.springVelocity options:self.presentedViewAnimationOption animations:^{
                object.transform = CGAffineTransformMakeTranslation(-delta, 0);
            } completion:completionBlock];
            
            timeOffset += self.elementDelay;
        }
    }];
}

#pragma mark -
#pragma mark Check

- (void)checkIncomingViewControllers {
    [self checkIfConformToProtocol];
    [self checkViewConfigurations];
}

- (void)checkIfConformToProtocol {
    NSException *exception = [NSException exceptionWithName:@"Not conforming to protocol"
                                                     reason:@"You have to conform to ARSSlideTransitionProtocol in classes you wish to use for animation, in order to use this class. It will make sure you have all necessary methods needed by the transition class."
                                                   userInfo:nil];
    
    id presentingVC = [self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (![presentingVC conformsToProtocol:@protocol(ARSSlideTransitionProtocol)]) {
        @throw exception;
    }
    
    id presentedVC = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    if (![presentedVC conformsToProtocol:@protocol(ARSSlideTransitionProtocol)]) {
        @throw exception;
    }
}

- (void)checkViewConfigurations {
    id presentedVC = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([presentedVC view].clipsToBounds) {
        @throw [NSException exceptionWithName:@"View's clipsToBounds property is set to YES"
                                       reason:@"You have to disable clipsToBounds property on order to see presented view's elements animation. Disable this property for view that is about to appear on screen."
                                     userInfo:nil];
    }
}

@end
