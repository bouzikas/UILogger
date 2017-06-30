//
//  UILoggerView.m
//  UILogger
//
//  Created by Dimitris Bouzikas on 30/06/2017.
//  Copyright © 2017 Dimitris Bouzikas. All rights reserved.
//

#import "UILoggerView.h"

@implementation UILoggerView

- (NSString *)pathForFile:(NSString *)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *path = [documentsDir stringByAppendingPathComponent:filename];
    
    return path;
}

- (void)initLogFile
{
    self.log = [self pathForFile:@"UILogger.log"];
}

- (void)redirectLog
{
    [self initLogFile];
    
    NSString *logPath = [NSString stringWithFormat:self.log, [[NSBundle mainBundle] bundlePath]];
    
    NSURL *url = [NSURL URLWithString:logPath];
    
    // Runs your task on a background thread with default priority.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [FileChangeObserver observerForURL:url types:1 delegate:self];
    });
    
    NSLog(@"redirecting STDERR: %@", logPath);
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

- (void)fileChanged
{
    NSString *logPath = [NSString stringWithFormat:self.log, [[NSBundle mainBundle] bundlePath]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSString *content = [NSString stringWithContentsOfFile:logPath encoding:NSUTF8StringEncoding error:nil];
        if ([self.delegate respondsToSelector:@selector(logUpdated:)]) {
            [self.delegate logUpdated:content];
        }
    });
}

@end
