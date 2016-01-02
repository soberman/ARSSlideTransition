//
//  ARSSlideTransition.h
//  ARSSlideTransition
//
//  Created by Yaroslav Arsenkin on 25.08.15.
//  Copyright (c) 2015 Iaroslav Arsenkin. All rights reserved.
//  Website: http://arsenkin.com
//

#import <UIKit/UIKit.h>


@protocol ARSSlideTransitionProtocol <NSObject>

/*!
 Used by Transition class to get objects for animation. Use this method to pack array of UIView subclasses to animate.
 @returns Array of objects to animate.
 */
- (NSArray *)objectsToAnimate;

@end


@interface ARSSlideTransition : NSObject <UIViewControllerAnimatedTransitioning>

/*!
 Used to store the type of navigation controller transitions to determine proper transition and configuration.
 */
@property (nonatomic) UINavigationControllerOperation operation;

/*!
 Duration for Push animation.
 */
@property (nonatomic) CGFloat pushAnimationDuration;

/*!
 Duration for Dismiss animation.
 */
@property (nonatomic) CGFloat dismissAnimationDuration;

/*!
 Delay prior to animation start.
 */
@property (nonatomic) CGFloat initialDelay;

/*!
 Delay before animation each next element on the presenting view.
 */
@property (nonatomic) CGFloat elementDelay;

/*!
 Delay, after which launched animation for the presented view. Presented view uses elementTimeOffset property to determine animation delay for it's views.
 */
@property (nonatomic) CGFloat viewDelay;

/*!
 Value, used for animation's spring damping parameter.
 */
@property (nonatomic) CGFloat springDamping;

/*!
 Value, used for animation's spring velocity parameter.
 */
@property (nonatomic) CGFloat springVelocity;

/*!
 Presenting view animation options.
 */
@property (nonatomic) UIViewAnimationOptions presentingViewAnimationOption;

/*!
 Presented view Animation options.
 */
@property (nonatomic) UIViewAnimationOptions presentedViewAnimationOption;

@end
