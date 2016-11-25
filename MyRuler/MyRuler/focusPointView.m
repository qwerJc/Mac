//
//  focusPointView.m
//  MyRuler
//
//  Created by 贾辰 on 16/11/21.
//  Copyright © 2016年 贾辰. All rights reserved.
//

#import "focusPointView.h"

@implementation focusPointView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [self.layer setBackgroundColor:[NSColor blackColor].CGColor];
    [self.layer setCornerRadius:5.0];
}

@end
