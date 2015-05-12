//
//  MessageBoardTableController.m
//  demo
//
//  Created by James Landrum on 5/11/15.
//  Copyright (c) 2015 James Landrum. All rights reserved.
//

#import "MessageBoardTableController.h"

@interface MessageBoardTableController ()
@property (nonatomic, strong) NSMutableArray * messageArray;
@property (nonatomic, strong) NSString * collection;
@end

@implementation MessageBoardTableController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messageArray = [NSMutableArray new];
    }
    return self;
}

- (id)initWithCollection:(NSString *) collection
{
    self = [self init];
    if (self) {
        self.collection = collection;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messageArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"MessageRowId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    Message * message = [self.messageArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = message.Title;
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:true];
    UIAlertView *alert = [[UIAlertView new] initWithTitle: [[self.messageArray objectAtIndex:indexPath.row] Title]
                                                  message: [[self.messageArray objectAtIndex:indexPath.row] Message]
                                                 delegate: nil
                                        cancelButtonTitle:@"Done"
                                        otherButtonTitles: nil];
    [alert show];
}

- (void)update
{
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    
    AWSDynamoDBCondition * condition = [AWSDynamoDBCondition new];
    AWSDynamoDBAttributeValue * value = [AWSDynamoDBAttributeValue new];
    value.S = self.collection;
    condition.attributeValueList = @[value];
    condition.comparisonOperator = AWSDynamoDBComparisonOperatorEQ;
    AWSDynamoDBScanExpression *expression = [AWSDynamoDBScanExpression new];
    
    expression.scanFilter = @{@"Collection": condition};
    
    
    [[dynamoDBObjectMapper scan:[Message class]
                     expression:expression]
     continueWithBlock:^id(BFTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         }
         if (task.exception) {
             NSLog(@"The request failed. Exception: [%@]", task.exception);
         }
         if (task.result) {
             AWSDynamoDBPaginatedOutput *output = task.result;
             [self.messageArray removeAllObjects];
             for (Message * message in output.items) {
                 [self.messageArray addObject:message];
             }
             //[self.tableView reloadData];
             [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
         }
         return nil;
     }
     ];
    
}

@end
