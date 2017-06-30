//
//  FileChangeObserver.h
//  UILogger
//
//  Created by Dimitris Bouzikas on 30/06/2017.
//  Copyright © 2017 Dimitris Bouzikas. All rights reserved.
//

#import <Foundation/Foundation.h>

#define	NOTE_DELETE	0x00000001		/* data contents deleted */
#define	NOTE_WRITE	0x00000002		/* data contents changed */
#define	NOTE_WRITE	0x00000002		/* data contents changed */
#define	NOTE_EXTEND	0x00000004		/* size increased */
#define	NOTE_ATTRIB	0x00000008		/* attributes changed */
#define	NOTE_LINK	0x00000010		/* link count changed */
#define	NOTE_RENAME	0x00000020		/* vnode was renamed */
#define	NOTE_REVOKE	0x00000040		/* vnode access was revoked */
#define NOTE_NONE	0x00000080		/* No specific vnode event: to test for EVFILT_READ activation*/

enum FileChangeNotificationType
{
    kFileChangeType_Delete = NOTE_DELETE,
    kFileChangeType_Write = NOTE_WRITE,
    kFileChangeType_DirectoryContentsChanged = kFileChangeType_Write
};

@class FileChangeObserver ;

@protocol FileChangeObserverDelegate<NSObject>
@required

- (void)fileChanged;

@end

@interface FileChangeObserver : NSObject

@property (nonatomic, copy) NSURL *url;
@property (nonatomic, weak) id<FileChangeObserverDelegate> delegate;

- (void)stopObserving;
+ (instancetype)observerForURL:(NSURL*)url
                         types:(enum FileChangeNotificationType)types
                      delegate:(id<FileChangeObserverDelegate>)delegate;

@end
