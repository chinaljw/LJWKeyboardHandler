//
//  ViewController.m
//  LJWKeyboardHandlerExample
//
//  Created by ljw on 15/5/18.
//  Copyright (c) 2015年 ljw. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+LJWKeyboardHandlerHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化一下就好
    self.ljwKeyboardHandler = [[LJWKeyboardHandler alloc] init];
    
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
