//
//  Task.h
//  PomodoroRemote
//
//  Created by 松澤 太郎 on 2014/09/07.
//  Copyright (c) 2014年 Taro Matsuzawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CouchbaseLite/CouchbaseLite.h>

@class Current;

@interface Task : CBLModel

@property (copy) NSString* title;
@property (retain) NSDate* created_at;

-(instancetype) initTaskInDatabase:(CBLDatabase *)database withTitle:(NSString *) _title;

-(Current *) createCurrentWithTask;

@end
