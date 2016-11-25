//
//  MyTriangleView.h
//  Ruler (For Mac)
//
//  Created by 贾辰 on 16/11/20.
//  Copyright © 2016年 贾辰. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "focusPointView.h"

@interface MyTriangleView : NSView

@property NSBezierPath *border;
@property NSBezierPath *bigDial;
@property (nonatomic)focusPointView* focusLD;
@property (nonatomic)focusPointView* focusRD;
@property (nonatomic)focusPointView* focusRU;
@property(nonatomic)NSPoint mousePos;
@property (nonatomic)int onWitchPoint;
@property NSPoint pLDown;
@property NSPoint pRDown;
@property NSPoint pRUp;
@end
