//
//  AnimationPlayViewController.m
//  LIBRARY
//
//  Created by Derek Neely on 2/26/13.
//  Copyright (c) 2013 derekneely.com. All rights reserved.
//

#import "AnimationPlayViewController.h"

@interface AnimationPlayViewController ()

@end

@implementation AnimationPlayViewController

- (void)flipViewIn:(UIView *)view {
    view.center = CGPointMake(480, 234);
    
    float angle = 65.0 * (M_PI / 10);
    CGAffineTransform angleTransform = CGAffineTransformMakeRotation(angle);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.15, 0.15);
    view.transform = CGAffineTransformConcat(angleTransform, scaleTransform);
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         view.center = CGPointMake(160, 234);
                         
                         float angle = 0; // * (3.14 / 100);
                         CGAffineTransform angleTransform = CGAffineTransformMakeRotation(angle);
                         CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.0, 1.0);
                         view.transform = CGAffineTransformConcat(scaleTransform, angleTransform);
                     }
                     completion:^(BOOL finished) {
                         self.currentFactTextView = (UITextView *)view;
                     }];
}

- (void)scaleViewIn:(UIView *)view {
    [view setHidden:NO];
    [[view layer] addAnimation:self.popAnimation forKey:@"transform.scale"];
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)animation1 {
    float angle = 45 * (3.14 / 100);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    tempLabel.transform = transform;
}

- (void)animation2 {
    float angle = 0 * (3.14 / 100);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    tempLabel.transform = transform;
}

- (void)animation3 {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:45.0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:0.0]; // [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = 1.0;
    //rotationAnimation.cumulative = YES;
    //rotationAnimation.repeatCount = repeat;
    
    [tempLabel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}



- (void)rotateViewOut:(UIView *)view {
    [UIView animateWithDuration:0.75
                     animations:^{
                         view.frame = CGRectMake(0, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
                         view.alpha = 0.0;
                         
                         float angle = -45.0; //* (M_PI/100);
                         CGAffineTransform angleTransform = CGAffineTransformMakeRotation(angle);
                         CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.1, 0.1);
                         view.transform = CGAffineTransformConcat(angleTransform, scaleTransform);
                     }
                     completion:^(BOOL finished) {
                         [view removeFromSuperview];
                     }];
}

#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    self.popAnimation.duration = 0.5;
    self.popAnimation.keyTimes = [NSArray arrayWithObjects:
                                  [NSNumber numberWithFloat:0.0],
                                  [NSNumber numberWithFloat:0.7],
                                  [NSNumber numberWithFloat:2.0], nil];
    
    self.popAnimation.values = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0.0],
                                [NSNumber numberWithFloat:0.7],
                                [NSNumber numberWithFloat:2.0], nil];
    
    
    //[self performSelector:@selector(scaleViewIn:) withObject:tempLabel afterDelay:1];
    //[self runSpinAnimationOnView:tempLabel duration:1.5 rotations:100000000 repeat:1];
    //[self performSelector:@selector(animation1) withObject:nil afterDelay:1.0];
    //[self performSelector:@selector(animation2) withObject:nil afterDelay:2.0];
    //[self performSelector:@selector(flipViewIn:) withObject:tempLabel afterDelay:1.0];
    //[self performSelector:@selector(flipViewIn:) withObject:tempTextView afterDelay:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
@end
