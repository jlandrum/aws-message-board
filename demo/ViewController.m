//
//  ViewController.m
//  demo
//
//  Created by James Landrum on 5/11/15.
//  Copyright (c) 2015 James Landrum. All rights reserved.
//

#import "ViewController.h"
#import <AWSDynamoDB/AWSDynamoDB.h>
#import "Message.h"
#import "NewPostViewController.h"

@interface ViewController ()
@property (strong, nonatomic) MessageBoardTableController * messageBoardController;
@end

@implementation ViewController

@synthesize messageTableView;
@synthesize messageBoardController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    messageBoardController = [[MessageBoardTableController new] initWithCollection:@"Main"];
    [messageTableView setDelegate:messageBoardController];
    [messageTableView setDataSource:messageBoardController];
    [messageBoardController setTableView:messageTableView];
    [messageBoardController update];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NewPostViewController *svc = (NewPostViewController *)segue.destinationViewController;
    svc.delegate = self;
}

- (void) dialogWasDismissed:(NSInteger) success
{
    if (!success) {
        UIAlertView * alert = [[UIAlertView new] initWithTitle:@"Error"
                                                       message:@"There was a problem adding the new message. Please try again later."
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles: nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
    }
    
    [messageBoardController update];
}

@end
