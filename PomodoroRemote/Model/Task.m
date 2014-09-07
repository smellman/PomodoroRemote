//
//  Task.m
//  PomodoroRemote
//
//  Created by 松澤 太郎 on 2014/09/07.
//  Copyright (c) 2014年 Taro Matsuzawa. All rights reserved.
//

#import "Task.h"
#import "Current.h"

@implementation Task
@dynamic title, created_at;

-(instancetype) initTaskInDatabase:(CBLDatabase *)database withTitle:(NSString *)_title
{
    self = [super initWithNewDocumentInDatabase:database];
    if (self) {
        [self setValue:@"task" ofProperty:@"type"];
        self.title = _title;
        self.created_at = [NSDate date];
    }
    return self;

}
- (Current*) createCurrentWithTask
{
    CBLDocument *doc = [self.document.database existingDocumentWithID:@"current"];
    if (doc) {
        Current *current = [Current modelForDocument:doc];
        current.task = self;
        current.started_at = [NSDate date];
        return current;
    }
    return [[Current alloc] initCurrentInTask:self];
}

@end
