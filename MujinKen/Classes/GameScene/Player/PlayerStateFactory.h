//
//  StateDetector.h
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/09/02.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"
#import "Precondition.h"
#import "Swipe.h"
#import "State.h"

@class Swipe;

@interface PlayerStateFactory : NSObject {
    @private 
    CCArray* states;
}

-(State*)getState:(NSString*)stateName;
-(State*)getStateForInput:(UserInput*)userInput;

@end
