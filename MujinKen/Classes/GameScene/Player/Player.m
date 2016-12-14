//
//  Player.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/08/18.
//
//

#import "Player.h"
#import "GameScene.h"
#import "PlayerStateFactory.h"
#import "DebugUtil.h"
#import "ComponentFactory.h"
#import "CCAnimation+CCAnimationHelper.h"
#import "UserInput.h"
#import "Stage.h"

#import "SimpleAudioEngine.h"

@implementation Player

#pragma mark - shared instance

+(Player*)player
{
    return [[[self alloc] init] autorelease];
}

#pragma mark - init

-(void)dealloc
{
    [super dealloc];
}

-(id)init
{
    CCLOGINFO(@"プレイヤー初期化開始");
    
    if ((self = [super initWithSpriteFrameName:@"Stand 1.png"])) {
        
        Stage* stage = [[GameScene sharedGameScene] stage];
        
        CGRect screenRect = [GameScene screenRect];
        CGSize imageSize = self.contentSize;
        float x = screenRect.size.width * 0.5f;
        float y = imageSize.height * 0.5f + [stage getGroundHeight];
        self.position = ccp(x, y);
        actionDuration = 0;
        
        stateFactory = [[PlayerStateFactory alloc] init];
        [self changeState:[stateFactory getState:@"Stand"]];
        
        self.direction = DIRECTION_RIGHT;
        
        MoveComponent* moveComponent = [ComponentFactory getMoveComponent];
        [self addComponent:moveComponent];
        
        AttackComponent *attackComponent= [ComponentFactory getAttackComponent];
        [self addComponent:attackComponent];
        
        [self scheduleUpdate];
    }
    
    CCLOGINFO(@"プレイヤー初期化終了");

    return self;
}

#pragma mark - update

-(void)update:(ccTime)delta
{
    [super update:delta];
}

#pragma mark - State

-(State*)getState
{
    UserInput* userInput = [UserInput sharedUserInput];
    State* state = [stateFactory getStateForInput:userInput];
    return state;
}

-(State*)getDefaultState
{
    State* state = [stateFactory getState:@"Stand"];
    return state;
}

@end
