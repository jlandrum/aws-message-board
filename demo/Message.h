//
//  Message.h
//  demo
//
//  Created by James Landrum on 5/11/15.
//  Copyright (c) 2015 James Landrum. All rights reserved.
//

#ifndef demo_Message_h
#define demo_Message_h

#import <Foundation/Foundation.h>
#import <AWSDynamoDB/AWSDynamoDb.h>

@interface Message : AWSDynamoDBObjectModel <AWSDynamoDBModeling>

@property (nonatomic, strong) NSNumber *Id;
@property (nonatomic, strong) NSString *Collection;
@property (nonatomic, strong) NSString *Title;
@property (nonatomic, strong) NSString *Message;

@end

#endif
