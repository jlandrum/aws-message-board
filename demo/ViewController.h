//
//  ViewController.h
//  demo
//
//  Created by James Landrum on 5/11/15.
//  Copyright (c) 2015 James Landrum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageBoardTableController.h"
#import "NewPostViewController.h"

@interface ViewController : UIViewController<NewPostViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView * messageTableView;

@end

