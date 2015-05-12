//
//  NewPostView.m
//  demo
//
//  Created by James Landrum on 5/12/15.
//  Copyright (c) 2015 James Landrum. All rights reserved.
//

#import "NewPostViewController.h"
#import "ViewController.h"

@implementation NewPostViewController

@synthesize postTitle, postMessage, postButton;

- (IBAction)postNewMessage:(UIButton *)sender
{
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    
    long val = [[NSDate date] timeIntervalSince1970] * 1000;
    
    Message * message = [[Message new] init];
    message.Collection = @"Main";
    message.Title = postTitle.text;
    message.Message = postMessage.text;
    message.Id = [NSNumber numberWithLong:val];
    
    [[dynamoDBObjectMapper save:message]
        continueWithBlock:^id(BFTask *task)
        {
            if (task.error) {
                NSLog(@"The request failed. Error: [%@]", task.error);
                [[self delegate] dialogWasDismissed:0];
            }
            if (task.exception) {
                NSLog(@"The request failed. Exception: [%@]", task.exception);
                [[self delegate] dialogWasDismissed:0];
            }
            if (task.result) {
                [self dismissViewControllerAnimated:true completion:nil];
                [[self delegate] dialogWasDismissed:1];
            }
         return nil;
        }
     ];
}




@end
