//
//  Enemy.h
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/08/18.
//
//

#import "cocos2d.h"
#import "Entity.h"
#import "Definition.h"

@class State;
@class EnemyStateFactory;

@interface Enemy : Entity {
    EnemyStateFactory* stateFactory;
}

-(void)spawnWithLocation:(CGPoint)location;
-(void)damage;
-(void)remove;

@end
