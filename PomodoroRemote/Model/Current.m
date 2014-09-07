//
//  Current.m
//  PomodoroRemote
//
//  Created by 松澤 太郎 on 2014/09/07.
//  Copyright (c) 2014年 Taro Matsuzawa. All rights reserved.
//

#import "Current.h"
#import "Task.h"

@implementation Current

@dynamic task, started_at;

-(instancetype) initCurrentInTask:(Task *)_task
{
    CBLDocument* doc = [_task.document.database documentWithID:@"current"];
    self = [self initWithDocument:doc];
    if (self) {
        self.task = _task;
        self.started_at = [NSDate date];
    }
    return self;
}

@end
