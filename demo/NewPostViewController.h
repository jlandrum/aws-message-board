//
//  NewPostView.h
//  demo
//
//  Created by James Landrum on 5/12/15.
//  Copyright (c) 2015 James Landrum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@protocol NewPostViewControllerDelegate <NSObject>

- (void) dialogWasDismissed:(NSInteger) success;

@end

@interface NewPostViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *postMessage;
@property (weak, nonatomic) IBOutlet UITextField *postTitle;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) id<NewPostViewControllerDelegate> delegate;
@end
