//
//  ViewController.m
//  PomodoroRemote
//
//  Created by 松澤 太郎 on 2014/09/07.
//  Copyright (c) 2014年 Taro Matsuzawa. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Task.h"
#import "Current.h"

@interface ViewController () {
    BOOL started;
    NSDate* started_at;
    CBLDatabase *database;
    AppDelegate *app;
    Current *current;
}
- (void) updateTimer;
@end

@implementation ViewController
@synthesize timer, end_at;
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    started = NO;
    started_at = nil;
    app = [[UIApplication sharedApplication] delegate];
    database = app.database;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toggle:(id)sender {
    NSLog(@"toggle");
    NSString* task_name = self.addTask.text;
    UIButton *button = sender;
    if (!started) {
        if ([task_name length] == 0) {
            return;
        }
        [button setTitle:@"Stop" forState:UIControlStateNormal];
        
        Task* task = [[Task alloc] initTaskInDatabase:database withTitle:@"test2"];
        NSError *error;
        if ([task save:&error]) {
            NSLog(@"saved!");
            
        } else {
            NSLog(@"can't save");
            return;
        }
        current = [task createCurrentWithTask];
        if ([ current save:&error]) {
            NSLog(@"current saved!");
        } else {
            NSLog(@"can't save current");
            return;
        }
        self.end_at = [current.started_at dateByAddingTimeInterval:5];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                               target:self
                                                             selector:@selector(updateTimer)
                                                             userInfo:nil
                                                              repeats:YES];
        /*
        CBLView* view = [database viewNamed: @"tasks"];
        if (!view.mapBlock) {
            [view setMapBlock: MAPBLOCK({
                if ([doc[@"type"] isEqualToString:@"task"]) {
                    emit(@"title", doc[@"title"]);
                    emit(@"type", doc[@"type"]);
                }
            }) reduceBlock: nil version: @"1"];
        }
        CBLQuery* query = [view createQuery];
        NSError* error;
        CBLQueryEnumerator* rowEnum = [query run: &error];
        for (CBLQueryRow *row in rowEnum) {
            NSLog(@"%@", row.key);
            NSLog(@"%@", row.value);
        }
        [view deleteView];
         */
    } else {
        [button setTitle:@"Start" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        [self updateTimer];
        current.started_at = nil;
        NSError *error;
        if ([current save:&error]) {
            
        }
    }
    
    
    started = !started;
    
}

#pragma mark -
#pragma mark Private Methods

- (void) updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [self.end_at timeIntervalSinceDate:currentDate];
    if (timeInterval < 0) {
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        started = NO;
        self.counter.text = @"Please Restart";
        current.started_at = nil;
        NSError *error;
        if ([current save:&error]) {
            
        }
        return;
    }
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.counter.text = timeString;
}

@end
