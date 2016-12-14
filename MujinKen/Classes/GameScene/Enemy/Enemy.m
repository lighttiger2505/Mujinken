//
//  Enemy.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/08/18.
//
//

#import "Enemy.h"

#import "CalUtil.h"
#import "DebugLayer.h"
#import "ComponentFactory.h"
#import "CCAnimation+CCAnimationHelper.h"
#import "State.h"
#import "GameScene.h"
#import "EnemyStateFactory.h"


@implementation Enemy

#pragma mark - init

-(void)dealloc
{
    [super dealloc];
}

-(id)init
{
    if ((self = [super initWithSpriteFrameName:@"Stand 1.png"])) {
        self.visible = NO;
        [self setDirection:DIRECTION_LEFT];
                        
        MoveComponent* moveComponent = [ComponentFactory getMoveComponent];
        [self addComponent:moveComponent];
        
        AttackComponent* attackComponent = [ComponentFactory getAttackComponent];
        [self addComponent:attackComponent];
        
        CollisionComponent* collisionComponent = [ComponentFactory getCollisionComponent];
        [self addComponent:collisionComponent];
    }
    return self;
}

#pragma mark - Update

-(void)update:(ccTime)delta
{
    [super update:delta];
}

#pragma mark - Interface

-(void)spawnWithLocation:(CGPoint)location
{
    actionDuration ++;

    self.position = location;
    self.visible = YES;

    actionDuration = 0;
    stateFactory = [[EnemyStateFactory alloc] init];
    [self changeState:[stateFactory getState:@"Stand"]];
    
    self.direction = DIRECTION_RIGHT;
    
    [self scheduleUpdate];
}

-(void)damage
{
    [self remove];
}

-(void)remove
{
    self.visible = NO;
    [self stopAllActions];
    [self unscheduleAllSelectors];
}

#pragma mark - change state

#pragma mark - State

-(State*)getState
{
    State* state = [stateFactory getStateForPlayer:self];
    return state;
}

-(State*)getDefaultState
{
    State* state = [stateFactory getState:@"Stand"];
    return state;
}

#pragma mark - Field

-(void)CheckOutOfScreen
{
    if (CGRectIntersectsRect([self boundingBox], [GameScene screenRect]) == NO)
	{
        [self damage];
	}
}

@end
