//
//  AnimationPlayViewController.h
//  LIBRARY
//
//  Created by Derek Neely on 2/26/13.
//  Copyright (c) 2013 derekneely.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

@interface AnimationPlayViewController : UIViewController {
    IBOutlet UILabel *tempLabel;
}

@property (nonatomic, retain) CAKeyframeAnimation *popAnimation;

@property (nonatomic, retain) UITextView *currentFactTextView;

@end
