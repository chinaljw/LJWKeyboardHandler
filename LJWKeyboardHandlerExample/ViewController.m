//
//  ViewController.m
//  LJWKeyboardHandlerExample
//
//  Created by ljw on 15/5/18.
//  Copyright (c) 2015年 ljw. All rights reserved.
//

#import "ViewController.h"
#import "LJWKeyboardHandler.h"
//#import "UIView+FirstResponderNotification.h"
//#import "DaiDodgeKeyboard.h"

@interface ViewController ()

@property (nonatomic, strong) LJWKeyboardHandler *handler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化一下就好
    self.handler = [[LJWKeyboardHandler alloc] init];
    
//    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
