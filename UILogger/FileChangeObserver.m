//
//  FileChangeObserver.m
//  UILogger
//
//  Created by Dimitris Bouzikas on 30/06/2017.
//  Copyright © 2017 Dimitris Bouzikas. All rights reserved.
//

#import "FileChangeObserver.h"

#include <errno.h>       // for errno
#include <fcntl.h>       // for O_RDONLY
#include <stdio.h>       // for fprintf()
#include <stdlib.h>      // for EXIT_SUCCESS
#include <string.h>      // for strerror()
#include <sys/event.h>   // for kqueue() etc.
#include <unistd.h>      // for close()

#include <stdio.h>
#include <string.h>

#undef Assert
#define Assert(COND) { if (!(COND)) { raise( SIGINT ) ; } }

@interface FileChangeObserver ()

@property (nonatomic, readonly)	int kqueue;
@property (nonatomic) enum FileChangeNotificationType typeMask;

@end

@implementation FileChangeObserver
@synthesize kqueue = _kqueue;

+ (instancetype)observerForURL:(NSURL*)url
                         types:(enum FileChangeNotificationType)types
                      delegate:(id<FileChangeObserverDelegate>)delegate
{
    if (!url) {
        return nil;
    }
    
    FileChangeObserver * result = [[[self class] alloc] init];
    result.url = url ;
    result.delegate = delegate;
    result.typeMask = types;
    
    [result startObserving];
    return result ;
}

- (void)dealloc
{
    printf("%s\n", __PRETTY_FUNCTION__);
    [self stopObserving] ;
}

static void (^kqueue_main)(FileChangeObserver *) = ^(__unsafe_unretained FileChangeObserver * self)
{
    int fd = open([[self.url path] fileSystemRepresentation], O_EVTONLY);
    Assert( fd >= 0 );
    
    int q = kqueue();
    {
        char *dirname = NULL;
        
        struct kevent event;
        EV_SET (&event, fd, EVFILT_VNODE, EV_ADD | EV_CLEAR | EV_ENABLE,
                NOTE_WRITE, 0, (void *)dirname);
        
        int error = kevent( q, &event, 1, NULL, 0, NULL);
        Assert(error == 0);
    }
    
    struct kevent event = {0} ;
    for(;;)
    {
        int nEvents = kevent( q, NULL, 0, &event, 1, NULL ) ;
        if ( nEvents != 1 ) { break ; }
        
        [self.delegate fileChanged];
    }
};

- (void)startObserving
{
    __unsafe_unretained id unsafe_self = self ;
    kqueue_main( unsafe_self ) ;
}

- (void)stopObserving
{
    @synchronized(self) {
        close(self.kqueue);
    }
}

- (int)kqueue
{
    if (!_kqueue) {
        _kqueue = kqueue();
    }
    return _kqueue ;
}

@end

