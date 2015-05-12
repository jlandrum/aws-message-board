//
//  Message.m
//  demo
//
//  Created by James Landrum on 5/11/15.
//  Copyright (c) 2015 James Landrum. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (NSString *)dynamoDBTableName {
    return @"Messages";
}

+ (NSString *)hashKeyAttribute {
    return @"Id";
}

@end