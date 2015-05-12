//
//  MessageBoardTableController.h
//  demo
//
//  Created by James Landrum on 5/11/15.
//  Copyright (c) 2015 James Landrum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessageBoardTableController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

- (id)initWithCollection:(NSString *) collection;
- (void)update;

@end
