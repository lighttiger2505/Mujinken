//
//  StateAction.h
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/10/02.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Attack.h"
#import "Move.h"
#import "Animation.h"
#import "Precondition.h"

@class UserInput;
@class Attack;
@class Move;
@class Animation;
@class Precondition;

@interface State : NSObject {
    NSString* stateName;
    Animation* animation;
    Move* move;
    Attack* attack;
    Precondition* condition;
}
@property(nonatomic, retain)NSString* stateName;
@property(nonatomic, retain)Animation* animation;
@property(nonatomic, retain)Move* move;
@property(nonatomic, retain)Attack* attack;
@property(nonatomic, retain)Precondition* condition;

-(BOOL)isState:(NSString*)compareStateName;
-(BOOL)compare:(State*)stateAction;
@end
