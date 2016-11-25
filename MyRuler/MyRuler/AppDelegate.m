//
//  AppDelegate.m
//  MyRuler
//
//  Created by 贾辰 on 16/11/21.
//  Copyright © 2016年 贾辰. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application

    [NSApp setApplicationIconImage:[NSImage imageNamed:@"Icon"]];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
}

@end
