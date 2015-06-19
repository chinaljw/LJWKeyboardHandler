//
//  ViewController.m
//  LJWKeyboardHandlerExample
//
//  Created by ljw on 15/5/18.
//  Copyright (c) 2015年 ljw. All rights reserved.
//

#import "ViewController.h"
#import "LJWKeyboardHandlerHeaders.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *test;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //注册一下就好~
    [self registerLJWKeyboardHandler];
    
    self.test.assistantHeight = 50;
    
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
