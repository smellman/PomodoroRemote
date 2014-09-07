//
//  Current.h
//  PomodoroRemote
//
//  Created by 松澤 太郎 on 2014/09/07.
//  Copyright (c) 2014年 Taro Matsuzawa. All rights reserved.
//

#import <CouchbaseLite/CouchbaseLite.h>

@class Task;

@interface Current : CBLModel

@property (readwrite) Task* task;
@property NSDate* started_at;

-(instancetype) initCurrentInTask:(Task *)_task;

@end
