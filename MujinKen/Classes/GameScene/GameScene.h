//
//  GameScene.h
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/08/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum
{
	GameSceneLayerTagGame = 1,
	GameSceneLayerTagInput,
    GameSceneLayerTagDebug = 99,
    
} GameSceneLayerTags;

typedef enum
{
    GameSceneNodeTagPlayer,
	GameSceneNodeTagEnemyCache,
    GameSceneNodeTagHitCache,
    GameSceneNodeTagStage,
    GameSceneNodeTagLevel,
    
} GameSceneNodeTags;

@class SoundLoader;
@class Player;
@class EnemyCache;
@class HitCache;
@class Stage;

@interface GameScene : CCLayer {
    SoundLoader* soundLoader;
}

+(GameScene*) sharedGameScene;

+(id)scene;

+(CGRect)screenRect;

-(Player*)player;
-(EnemyCache*)enemyCache;
-(HitCache*)hitCache;
-(Stage*)stage;

@end
