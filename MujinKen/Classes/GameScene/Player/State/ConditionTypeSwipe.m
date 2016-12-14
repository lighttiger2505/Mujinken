//
//  InputSwipe.m
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/03/24.
//
//

#import "ConditionTypeSwipe.h"

#import "TouchTrack.h"
#import "UserInput.h"
#import "Swipe.h"
#import "Player.h"
#import "GameScene.h"
#import "CalUtil.h"

@implementation ConditionTypeSwipe

@synthesize isHold;
@synthesize degree;
@synthesize range;

#pragma mark -init

-(void)dealloc
{
    [super dealloc];
}

-(id)init
{
    if ((self = [super init])) {
        
    }
    return self;
}

-(BOOL)isChangeState:(UserInput*)userInput
{
    BOOL result = NO;
    for (TouchTrack* touchTrack in [userInput touchTracks]) {
        result = [self isChangeStateForSwipe:touchTrack Hold:[userInput isHoldTouchTracks]];
    }
    return result;
}

-(BOOL)isChangeStateForSwipe:(TouchTrack*)touchTrack Hold:(BOOL)isHoldUserInput
{
    if ([touchTrack isHold]) {
        return NO;
    }
    
    if (isHoldUserInput != isHold) {
        return NO;
    }
    
    Swipe* swipe = [touchTrack getSwipe];
    if ([swipe distanceForFrame] > 1.0f) {
        Player* player = [[GameScene sharedGameScene] player];
        
        if (player.direction == DIRECTION_LEFT) {
            int flipDegree = swipe.degrees * -1;
            if ([CalUtil isInRange:flipDegree range:range]) {
                return YES;
            }
        }
        else if (player.direction == DIRECTION_RIGHT) {
            if ([CalUtil isInRange:swipe.degrees range:range]) {
                return YES;
            }
        }
    }
    return NO;
}

@end
