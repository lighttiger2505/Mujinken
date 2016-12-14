//
//  PaturnFactory.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/10/21.
//
//

#import "EnemyStateFactory.h"

#import "GameScene.h"
#import "State.h"
#import "Player.h"
#import "Enemy.h"
#import "PlayerStateReader.h"

@implementation EnemyStateFactory

#pragma mark - init

-(void)dealloc
{
    [super dealloc];
}

-(id)init
{
    if ((self = [super init]))
        if (self = [super init]) {
            PlayerStateReader* reader = [[PlayerStateReader alloc] initWithFileName:@"player_state"];
            states= [reader getParsedData];
        }
    return self;
}

#pragma mark - get paturn

-(State*)getState:(NSString*)stateName
{
    State *changeAction = nil;
    
    for (State* stateAction in states) {
        if ([stateAction isState:stateName]) {
            changeAction = stateAction;
        }
    }
    
    NSAssert2(changeAction != nil, @"%@: unsupported State %@", NSStringFromSelector(_cmd), stateName);
    
    return changeAction;
}

-(State*)getStateForPlayer:(Enemy*)enemy;
{
    State* state;
    
    Player* player = [[GameScene sharedGameScene] player];
    float distance = ccpDistance(player.position, enemy.position);
    
    if (distance < 50) {
        state = [self getState:@"AttackMiddleFront"];
    }
    else {
        if (enemy.position.x > player.position.x) {
            state = [self getState:@"MoveSlowLeft"];
        }
        else {
            
            state = [self getState:@"MoveSlowRight"];
        }
    }

    return state;
}

@end
