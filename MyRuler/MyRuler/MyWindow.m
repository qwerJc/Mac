//
//  MyWindow.m
//  Ruler (For Mac)
//
//  Created by 贾辰 on 16/11/20.
//  Copyright © 2016年 贾辰. All rights reserved.
//
//  坑：
//      1、设置图片时
//
//
//
//
//
//
//

#import "MyWindow.h"
#import "MyTriangleView.h"
#import "MyProtractorView.h"

@implementation MyWindow
-(void)awakeFromNib {
    self.opaque=NO;
    self.backgroundColor=[NSColor clearColor];
    self.alphaValue=0.4;
    
    _triangle=[[MyTriangleView alloc] initWithFrame:NSMakeRect(0,0,self.frame.size.width,self.frame.size.height)];
   [self.contentView addSubview:_triangle];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResize:) name:NSWindowDidResizeNotification object:self];
}

-(void)close{
    [NSApp terminate:self];
}

- (void)windowDidResize:(NSNotification *)aNotification {
    // 调整NSWindow上NSView的frame
    [_triangle setFrame:NSMakeRect(0,0,self.frame.size.width,self.frame.size.height)];
}

@end
