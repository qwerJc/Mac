//
//  MyTriangleView.m
//  Ruler (For Mac)
//
//  Created by 贾辰 on 16/11/20.
//  Copyright © 2016年 贾辰. All rights reserved.
//

#import "MyTriangleView.h"
#import "focusPointView.h"

#define X_SAME_Y_SAME 0;
#define X_SAME_Y_DONTSAME 1;
#define X_DONTSAME_Y_SAME 2;
#define X_DONTSAME_Y_DONTSAME 3;

@implementation MyTriangleView

-(id)initWithFrame:(NSRect)frameRect{
    self =[super initWithFrame:frameRect];
    
    _focusLD=[[focusPointView alloc] init];
    _focusRD=[[focusPointView alloc] init];
    _focusRU=[[focusPointView alloc] init];
    
    _pLDown=NSMakePoint(30,30);
    _pRDown=NSMakePoint(frameRect.size.width-30,30);
    _pRUp=NSMakePoint(frameRect.size.width-30, frameRect.size.height-53);
    
    [_focusRU setFrame:NSMakeRect(_pRUp.x-5, _pRUp.y-5, 11, 11)];
    [_focusLD setFrame:NSMakeRect(_pLDown.x-5, _pLDown.y-5, 11, 11)];
    [_focusRD setFrame:NSMakeRect(_pRDown.x-5, _pRDown.y-5, 11, 11)];
    
    [self addSubview:_focusRU];
    [self addSubview:_focusLD];
    [self addSubview:_focusRD];
    return self;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    self.frameRotation =0*M_PI;
    [self.layer setBackgroundColor:[NSColor lightGrayColor].CGColor];
    // Drawing code here.
    
    _border=[NSBezierPath bezierPath];
    _bigDial=[NSBezierPath bezierPath];


    [_border setLineWidth:3.0];
    

    [_bigDial setLineWidth:2.0];
    
    [_border moveToPoint:_pLDown];
    
    [_border lineToPoint:_pRDown];
    [_border lineToPoint:_pRUp];
    [_border lineToPoint:_pLDown];
    

    
    [_border closePath];
    
    [[NSColor blueColor]set];
    [_border stroke];
    
    [self setBigDial:_pRDown andEndP:_pRUp];
    [self setBigDial:_pLDown andEndP:_pRDown];
    [self setBigDial:_pRUp andEndP:_pLDown];
}
-(void)setFrame:(NSRect)frame{
    [super setFrame:frame];
    
    _pLDown=NSMakePoint(30,30);
    _pRDown=NSMakePoint(frame.size.width-30,30);
    _pRUp=NSMakePoint(frame.size.width-30, frame.size.height-53);

    [_focusRU setFrame:NSMakeRect(_pRUp.x-5, _pRUp.y-5, 11, 11)];
    [_focusLD setFrame:NSMakeRect(_pLDown.x-5, _pLDown.y-5, 11, 11)];
    [_focusRD setFrame:NSMakeRect(_pRDown.x-5, _pRDown.y-5, 11, 11)];
    

}

-(void)setBigDial:(NSPoint)startP andEndP:(NSPoint)endP{
    NSPoint p1,p2;
    [[NSColor blackColor]set];
    float res=[self getLength:startP andEndP:endP];
    float n=res/25;
    p1=NSMakePoint(startP.x+1,startP.y);
    p2=p1;
    
    float addX,addY;
    switch ([self juedgeCollinear:startP andEndP:endP]) {
        case 0:
            break;
        case 1: //x same ; y dont
            res=endP.y-startP.y;
            res=res/n;
            for (int i=0; i<n-1; i++) {
                p1=NSMakePoint(p1.x,p1.y+res);
                [_bigDial moveToPoint:p1];
                
                p2=NSMakePoint(p1.x-14,p1.y);
                [_bigDial lineToPoint:p2];
            }
            break;
        case 2: //x dont ; y same
            res=endP.x-startP.x;
            res=res/n;
            for(int i =0;i<n-1;i++){
                p1=NSMakePoint(p1.x+res,p1.y);
                [_bigDial moveToPoint:p1];
                
                p2=NSMakePoint(p1.x,p1.y+14);
                [_bigDial lineToPoint:p2];
            }
            break;
        case 3: // x dont ; y dont
            res=[self getLength:startP andEndP:endP];
            addX=(endP.x-startP.x)/n;
            addY=(endP.y-startP.y)/n;
            for(int i =0;i<n-1;i++){
                p1=NSMakePoint(p1.x+addX,p1.y+addY);
                [_bigDial moveToPoint:p1];
                //          斜率为0或无穷！！！
                float a,b,sum;
                a=startP.x-endP.x;
                b=endP.y-startP.y;
                sum=a/b;
                NSLog(@"1: %f ;\n 2: %f ;\n sum:%f",(endP.y-startP.y),b,(startP.x-endP.x)/(endP.y-startP.y));
                if((startP.x-endP.x)/(endP.y-startP.y)>4||(startP.x-endP.x)/(endP.y-startP.y)<-4){
                    //联立方程
                    y=(startP.x-endP.x)/(endP.y-startP.y)*x;
                    
                    p2=NSMakePoint(p1.x,p1.y+14);
                }else if((startP.x-endP.x)/(endP.y-startP.y)<0.1&&(startP.x-endP.x)/(endP.y-startP.y)>-0.1){
                    p2=NSMakePoint(p1.x+14,p1.y);
                }else{
                    p2=NSMakePoint(p1.x+7,p1.y+(startP.x-endP.x)/(endP.y-startP.y)*7);
                }
                [_bigDial lineToPoint:p2];
            }
            
            break;
        default:
            break;
    }
    [_bigDial stroke];
}
-(int)juedgeCollinear:(NSPoint)startP andEndP:(NSPoint)endP{
    if(startP.x==endP.x)
    {
        if (startP.y==endP.y) {
            return X_SAME_Y_SAME;
        }
        else{
            return X_SAME_Y_DONTSAME;
        }
    }else{
        if(startP.y==endP.y){
            return X_DONTSAME_Y_SAME
        }else{
            return X_DONTSAME_Y_DONTSAME;
        }
    }
}
-(float)getLength:(NSPoint)startp andEndP:(NSPoint)endP{
    int xDValue,yDValue;
    xDValue=startp.x-endP.x;
    yDValue=startp.y-endP.y;
    float res=sqrt(xDValue*xDValue+yDValue*yDValue);
    return res;
}
-(void)mouseDown:(NSEvent *)event{
    NSLog(@"%hhd",[self isMuseInPoint:event andV:_focusRU]);
    if([self isMuseInPoint:event andV:_focusRU]){
        _onWitchPoint=1;
    }else if([self isMuseInPoint:event andV:_focusRD]){
        _onWitchPoint=2;
    }else if ([self isMuseInPoint:event andV:_focusLD]){
        _onWitchPoint=3;
    }else{
        _onWitchPoint=0;
    }
    
}
-(void)mouseDragged:(NSEvent *)event{
    switch (_onWitchPoint) {
        case 1:     //right and up
            _pRUp=[event locationInWindow];
            [_focusRU setFrame:NSMakeRect(_pRUp.x-5, _pRUp.y-5, 11, 11)];
            [self reDraw];
            break;
        case 2:     //right and down
            _pRDown=[event locationInWindow];
            [_focusRD setFrame:NSMakeRect(_pRDown.x-5, _pRDown.y-5, 11, 11)];
            [self reDraw];
            break;
        case 3:
            _pLDown=[event locationInWindow];
            [_focusLD setFrame:NSMakeRect(_pLDown.x-5, _pLDown.y-5, 11, 11)];
            [self reDraw];
            break;
        default:
            break;
    }
}
-(BOOL)isMuseInPoint:(NSEvent *)event andV:(focusPointView*)view{
    _mousePos=[event locationInWindow];
    if(_mousePos.x>view.frame.origin.x)
    {
        if(_mousePos.x<view.frame.origin.x+view.frame.size.width){
            if(_mousePos.y>view.frame.origin.y){
                if(_mousePos.y<view.frame.origin.y+view.frame.size.height){
                    return true;
                }
            }
        }
    }
    return false;
}
-(void)reDraw{
    [self setNeedsDisplay:YES];
    [self setBigDial:_pRDown andEndP:_pRUp];
    [self setBigDial:_pLDown andEndP:_pRDown];
    [self setBigDial:_pRUp andEndP:_pLDown];

}

@end
