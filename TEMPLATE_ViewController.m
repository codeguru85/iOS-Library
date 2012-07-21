//
//  TEMPLATE_ViewController.m
//  LIBRARY
//
//  Created by Derek Neely on 2/1/12.
//  Copyright (c) 2012 derekneely.com. All rights reserved.
//

#import "TEMPLATE_ViewController.h"

@implementation TEMPLATE_ViewController

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
