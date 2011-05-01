//
//  MacGameExampleAppDelegate.h
//  MacGameExample
//
//  Created by Nicholas Chen on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AsyncUdpSocket.h"

@interface MacGameExampleAppDelegate : NSObject <NSApplicationDelegate> {
  // UDP Interface
  AsyncUdpSocket* listenSocket;
  
  // UI
  NSWindow* window;
  NSTextView* logPanel;
}

@property (assign) IBOutlet NSWindow* window;
@property (assign) IBOutlet NSTextView* logView;

@end
