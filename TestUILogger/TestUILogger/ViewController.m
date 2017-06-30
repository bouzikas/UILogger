//
//  ViewController.m
//  TestUILogger
//
//  Created by Dimitris Bouzikas on 30/06/2017.
//  Copyright © 2017 Bouzikas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILoggerView *logger = [[UILoggerView alloc] init];
    [logger redirectLog];
    logger.delegate = self;
}

- (void)logUpdated:(NSString *)content
{
    self.UITextLogger.text = content;
}
- (IBAction)writeToLog:(UIButton *)sender {
    NSLog(@"This is a test log");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
