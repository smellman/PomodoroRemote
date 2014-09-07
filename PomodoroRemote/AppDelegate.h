//
//  AppDelegate.h
//  PomodoroRemote
//
//  Created by 松澤 太郎 on 2014/09/07.
//  Copyright (c) 2014年 Taro Matsuzawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CBLDatabase *database;

@end

