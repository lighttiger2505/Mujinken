//
//  UserInput.h
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/10/09.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class TouchTrack;
@class SneakyButton;

@interface UserInput : CCNode
{
    @private
    CCArray* touchTracks;
    int touchDuration;
    UIAcceleration* acceleration;
    NSMutableDictionary* buttons;
}

+(UserInput*)sharedUserInput;

-(TouchTrack*)getTouchTrack;
-(void)touchBegin:(CGPoint)toPoint;
-(void)touchMove:(CGPoint)toPoint previousPoint:(CGPoint)previousPoint;
-(void)touchEnd:(CGPoint)toPoint previousPoint:(CGPoint)previousPoint;

-(BOOL)isHoldTouchTracks;

-(void)addSneakyButton:(SneakyButton*)button Key:(NSString*)key;
-(BOOL)isButtonTouch:(NSString*)key;

@property(nonatomic, retain)CCArray* touchTracks;
@property(readwrite)int touchDuration;
@property(nonatomic, retain)UIAcceleration* acceleration;
@property(nonatomic, retain)NSMutableDictionary* buttons;

@end
