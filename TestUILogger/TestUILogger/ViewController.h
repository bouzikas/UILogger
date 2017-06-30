//
//  ViewController.h
//  TestUILogger
//
//  Created by Dimitris Bouzikas on 30/06/2017.
//  Copyright © 2017 Bouzikas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UILogger/UILogger.h>

@interface ViewController : UIViewController <UILoggerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *UITextLogger;

@end

