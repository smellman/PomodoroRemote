//
//  ViewController.h
//  PomodoroRemote
//
//  Created by 松澤 太郎 on 2014/09/07.
//  Copyright (c) 2014年 Taro Matsuzawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *counter;
@property (strong, nonatomic) IBOutlet UITextField *addTask;

@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSDate *end_at;


@end

