//
//  UILoggerView.h
//  UILogger
//
//  Created by Dimitris Bouzikas on 30/06/2017.
//  Copyright © 2017 Dimitris Bouzikas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileChangeObserver.h"

@protocol UILoggerViewDelegate<NSObject>
@required

- (void)logUpdated:(NSString *)content;

@end

@interface UILoggerView : NSObject <FileChangeObserverDelegate>

@property (strong, nonatomic) NSString *log;
@property (nonatomic, weak) id <UILoggerViewDelegate> delegate;

- (void)redirectLog;

@end
