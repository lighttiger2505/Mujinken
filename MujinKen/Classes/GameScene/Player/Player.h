//
//  Player.h
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/08/18.
//
//

#import "Entity.h"
#import "DebugLayer.h"
#import "Precondition.h"
#import "State.h"
#import "Definition.h"
#import "MoveComponent.h"
#import "AttackComponent.h"

@class PlayerStateFactory;
@class Swipe;

@interface Player : Entity {
    @private
    PlayerStateFactory* stateFactory;
}

+(Player*)player;

@end
