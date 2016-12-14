//
//  UserInput.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/10/09.
//
//

#import "UserInput.h"

#import "Swipe.h"
#import "TouchTrack.h"
#import "SneakyButton.h"
#import "GameScene.h"
#import "DebugLayer.h"
#import "Stage.h"

@implementation UserInput

@synthesize touchTracks;
@synthesize touchDuration;
@synthesize acceleration;
@synthesize buttons;

#pragma mark - shared instance

static UserInput* instanceOfUserInput;

+(UserInput*)sharedUserInput
{
	if (instanceOfUserInput == nil) {
        instanceOfUserInput = [[UserInput alloc] init];
    }
    return instanceOfUserInput;
}

#pragma mark - init

-(void)dealloc
{
    touchTracks = nil;
    acceleration = nil;
    buttons = nil;
    [super dealloc];
}


-(id)init
{
    if (self = [super init]) {
        touchTracks = [[CCArray alloc] init];
        touchDuration = 0;
        buttons = [[NSMutableDictionary alloc] init];
        [self scheduleUpdate];
    }
    return self;
}

#pragma mark - input of touches

-(void)touchBegin:(CGPoint)toPoint
{
    TouchTrack* touchTrack = [[TouchTrack alloc] init];
    
    touchTrack.previousPoint = toPoint;
    touchTrack.duration = 0;
    NSValue* value = [NSValue valueWithCGPoint:toPoint];
    [touchTrack.touches addObject:value];
    
    [touchTracks addObject:touchTrack];
}

-(void)touchMove:(CGPoint)toPoint previousPoint:(CGPoint)previousPoint
{
    TouchTrack* touchTrack = [self getNearTouchTrackToPoint:previousPoint];
    
    touchTrack.previousPoint = toPoint;
    touchTrack.duration ++;
    NSValue* value = [NSValue valueWithCGPoint:toPoint];
    [touchTrack.touches addObject:value];
}

-(void)touchEnd:(CGPoint)toPoint previousPoint:(CGPoint)previousPoint
{
    TouchTrack* touchTrack = [self getNearTouchTrackToPoint:toPoint];
    NSAssert(touchTrack != nil, @"タッチの追跡に失敗しました。");
    [touchTracks removeObject:touchTrack];
}

-(TouchTrack*)getTouchTrack
{
    TouchTrack* touchTrack = nil;
    if ([touchTracks count] > 0) {
        touchTrack = [touchTracks objectAtIndex:0];
    }
    return touchTrack;
}

-(TouchTrack*)getNearTouchTrackToPoint:(CGPoint)previousPoint
{
    TouchTrack* nearTouchTrack = nil;
    float minDistance = 10000;
    
    for (TouchTrack*  touchTrack in touchTracks) {
        float distance = ccpDistance(touchTrack.previousPoint, previousPoint);
        if (distance < minDistance) {
            nearTouchTrack = touchTrack;
            minDistance = distance;
        }
    }
    return nearTouchTrack;
}

-(BOOL)isHoldTouchTracks
{
    for (TouchTrack* touchtrack in touchTracks) {
        if ([touchtrack isHold]) {
            return YES;
        }
    }
    return NO;
}

-(void)update:(ccTime)delta
{    
    for (TouchTrack* touchTrack in touchTracks) {
        CCArray *touches = touchTrack.touches;
        if ([touches count] >= 2) {
            CCArray* relativePointOfTouches = [[CCArray alloc] init];
            
            for(NSValue* value in touches) {
                CGPoint relativePoint = [self convertRelativePoint:value.CGPointValue];
                NSValue* relativeValue = [NSValue valueWithCGPoint:relativePoint];
                [relativePointOfTouches addObject:relativeValue];
            }
            [[DebugLayer sharedDebugLayer] addLine:relativePointOfTouches];
        }
    }
}

-(CGPoint)convertRelativePoint:(CGPoint)point
{
    Stage* stage = [[GameScene sharedGameScene] stage];
    CGPoint stagePoint = stage.position;
    CGPoint relativePoint = ccpSub(point, stagePoint);
    return relativePoint;
}

#pragma mark - input of button

-(void)addSneakyButton:(SneakyButton*)button Key:(NSString*)key
{
    [buttons setObject:button forKey:key];
}

-(BOOL)isButtonTouch:(NSString*)key
{
    SneakyButton* button = [buttons objectForKey:key];
    return button.active;
}

@end
