//
//  EnemyCache.h
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/08/20.
//
//

#import "cocos2d.h"
#import "Enemy.h"

#define MAX_ENEMY 10
#define SPAWN_INTERVAL 30

@interface EnemyCache : CCNode
{
    @private
    CCSpriteBatchNode* spriteBatch;
    CCArray* enemys;
    int spawnCount;
}

+(EnemyCache*)enemyCache;

-(void)enemyAt;

@end
