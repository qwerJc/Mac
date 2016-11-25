//
//  MyWindow.h
//  Ruler (For Mac)
//
//  Created by 贾辰 on 16/11/20.
//  Copyright © 2016年 贾辰. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MyTriangleView.h"
#import "MyProtractorView.h"

@interface MyWindow : NSWindow
@property(retain)MyTriangleView *triangle;
@end
