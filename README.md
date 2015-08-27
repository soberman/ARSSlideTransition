#ARSSlideTransition

This library helps to achieve smooth custom view controller transition animation in your project. It uses your provided UIView objects to perform animations.

![ARSSlideTransition](http://git.arsenkin.com/ARSSlideTransition.gif)

## Installation

### CocoaPods
To install with [CocoaPods](http://cocoapods.org/), copy and paste this in your *.pod* file:

    platform :ios, '7.0'
    pod 'ARSSlideTransition', '~> 1.0'

### Non-CocoaPods way
You can always to do the old way - just drag the source files into your projects and you are good to go.

## Usage

### Prepare your classes
In order to prepare your views for animation, you have to configure your UIViewControllers to support custom transition:

###### Presenting view controller

1. Make sure, that in your view, that contains elements you wish to animate, you have set `clipsToBounds` property to `NO`. This will allow animate these elements outside of the view's bounds.

2. Import `ARSSlideTransition.h` and conform to protocols `UINavigationControllerDelegate` and `ARSSlideTransitionProtocol`

```objective-c
@interface TableViewController () <UINavigationControllerDelegate, ARSSlideTransitionProtocol>
```

3. Implement `ARSSlideTransitionProtocol`'s required `objectsToAnimate` method. It should return `NSArray` of UIView class/subclass objects, that you wish to animate. **Order matters** - objects are going to be animated in the same order as they are presented in array.

4. Set your presenting viewController as a delegate for navigationController

```objective-c
self.navigationController.delegate = self;
```

5. Implement `UINavigationControllerDelegate` method, to let iOS know, that custom transition would be used instead of the default one:

```objective-c
(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC 
{
ARSSlideTransition *transition = [ARSSlideTransition new];
transition.operation = operation;
return transition;
}
```

###### Presented view controller

1.  Import `ARSSlideTransition.h` and conform to `ARSSlideTransitionProtocol` protocol.
2. Implement `ARSSlideTransitionProtocol`'s required method.

## Customizing animation
In case you specify only those three lines of code from step 4 in the section above, then default animation parameters are going to be used.

In order to provide your custom tweaks or configurations to animation's behavior, you are able to use these properties:

* `pushAnimationDuration` - specify presenting view controller's animation duration.

```objective-c
transition.pushAnimationDuration = 0.45; // Default.
```

* `dismissAnimationDuration` - specify presented view controller's animation duration.

```objective-c
transition.dismissAnimationDuration = 0.45; // Default
```

* `springDamping` - specify spring damping ratio for spring animation.

```objective-c
transition.springDamping = 0.8; // Default
```

* `springVelocity` - specify spring velocity ratio for spring animation.

```objective-c
transition.springVelocity = 0.8; // Default
```

* `initialDelay` - specify initial delay, after which animation transition will be launched.

```objective-c
transition.initialDelay = 0.0; // Default
```

* `elementDelay` - specify delay for animating each following view element.

```objective-c
transition.elementDelay = 0.05; // Default
```

* `viewDelay` - specify delay for animating presented view controller's elements.

```objective-c
transition.viewDelay = 0.15; // Default
```

* `presentingViewAnimationOption` - specify animation option for presenting view.

```objective-c
transition.presentingViewAnimationOption = UIViewAnimationOptionCurveEaseOut; // Default
```

* `presentedViewAnimationOption` - specify animation option for presented view.

```objective-c
transition.presentedViewAnimationOption = UIViewAnimationOptionCurveEaseOut; // Default
```

## License

ARSSlideTransition is released under the [MIT license](http://opensource.org/licenses/MIT). See LICENSE for details.
