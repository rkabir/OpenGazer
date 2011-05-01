//
//  MacGameExampleAppDelegate.m
//  MacGameExample
//
//  Created by Nicholas Chen on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MacGameExampleAppDelegate.h"

// See OpenGazer's OutputMethods.h
#define PORT_NUMBER 20320

#define FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]

@interface MacGameExampleAppDelegate (Private)
- (void)_logError:(NSString *)msg;
- (void)_logInfo:(NSString *)msg;
- (void)_logMessage:(NSString *)msg;
- (void)_scrollToBottom;
@end

@implementation MacGameExampleAppDelegate

@synthesize window;
@synthesize logView;

- (void)applicationDidFinishLaunching : (NSNotification *)aNotification {
  [listenSocket setRunLoopModes:[NSArray arrayWithObject:NSDefaultRunLoopMode]];
  [listenSocket moveToRunLoop:[NSRunLoop currentRunLoop]];
  
  NSError *error = nil;
  if(![listenSocket bindToPort:PORT_NUMBER error:&error]){
    [self _logError:FORMAT(@"Error starting server: %@", error)];
    return;
  }
  
  [self _logInfo:FORMAT(@"Listening on port %hu", [listenSocket localPort])];
  
  [listenSocket receiveWithTimeout:-1 tag:-1];
}

- (id)init {
	if((self = [super init])) {
		listenSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
	}
	return self;
}

- (void)awakeFromNib {
	[logView setString:@""];
}

- (void)_logError:(NSString *)msg {
	NSString *paragraph = [NSString stringWithFormat:@"%@\n", msg];
	
	NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:1];
	[attributes setObject:[NSColor redColor] forKey:NSForegroundColorAttributeName];
	
	NSAttributedString *as = [[NSAttributedString alloc] initWithString:paragraph attributes:attributes];
	[as autorelease];
	
	[[logView textStorage] appendAttributedString:as];
	[self _scrollToBottom];
}

- (void)_logInfo:(NSString *)msg {
	NSString *paragraph = [NSString stringWithFormat:@"%@\n", msg];
	
	NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:1];
	[attributes setObject:[NSColor purpleColor] forKey:NSForegroundColorAttributeName];
	
	NSAttributedString *as = [[NSAttributedString alloc] initWithString:paragraph attributes:attributes];
	[as autorelease];
	
	[[logView textStorage] appendAttributedString:as];
	[self _scrollToBottom];
}

- (void)_logMessage:(NSString *)msg {
  NSString *paragraph = [NSString stringWithFormat:@"%@\n", msg];

  NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:1];

  [attributes setObject:[NSColor purpleColor] forKey:NSForegroundColorAttributeName];

  NSAttributedString *as = [[NSAttributedString alloc] initWithString:paragraph attributes:attributes];
  [as autorelease];

  [[logView textStorage] appendAttributedString:as];
  [self _scrollToBottom];
}

- (void)_scrollToBottom {
  NSScrollView *scrollView = [logView enclosingScrollView];
  NSPoint newScrollOrigin;

  if([[scrollView documentView] isFlipped]) newScrollOrigin =
      NSMakePoint( 0.0F, NSMaxY([[scrollView documentView] frame]) );
  else
    newScrollOrigin = NSMakePoint(0.0F, 0.0F);

  [[scrollView documentView] scrollPoint:newScrollOrigin];
}

#pragma mark - UDP Delegate -

- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port {
  NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length] - 2)];
	NSString *msg = [[[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding] autorelease];
	if(msg) {
		[self _logMessage:msg];
	} else {
		[self _logError:@"Error converting received data into UTF-8 String"];
	}
  
  [listenSocket receiveWithTimeout:-1 tag:-1];
  return YES;
}

- (void)dealloc {
  [listenSocket release];
  [super dealloc];
}

@end
