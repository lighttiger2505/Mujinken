//
//  State.h
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/10/01.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Swipe;
@class TouchTrack;
@class UserInput;
@class PreconditionType;

enum PRIORITY {
    PRIORITY_DEFAULT = 0,
    PRIORITY_MOVE = 10,
    PRIORITY_ATTACK = 20,
    PRIORITY_AVOID = 30,
}typedef Priority;

@interface Precondition : NSObject {
    @private
    PreconditionType* conditionType;
    Priority priority;
}

@property(retain, nonatomic)PreconditionType* conditionType;
@property(readwrite)Priority priority;

-(BOOL)isChangeState:(UserInput*)userInput;

@end
