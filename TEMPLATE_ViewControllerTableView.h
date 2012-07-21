//
//  TEMPLATE_ViewControllerTableView.h
//  LIBRARY
//
//  Created by Derek Neely on 2/1/12.
//  Copyright (c) 2012 derekneely.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEMPLATE_ViewControllerTableView : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *theTableView;
}

@end
