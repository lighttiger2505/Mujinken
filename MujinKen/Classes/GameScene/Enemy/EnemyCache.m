//
//  EnemyCache.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/08/20.
//
//

#import "EnemyCache.h"

#import "GameScene.h"
#import "CalUtil.h"
#import "Stage.h"

@implementation EnemyCache

#pragma mark - instance

+(EnemyCache*)enemyCache
{
    return [[[EnemyCache alloc] init] autorelease];
}

#pragma mark - init 

-(void)dealloc
{
    [spriteBatch release];
    [enemys release];
    [super dealloc];
}

-(id)init
{
    if (self = [super init]) {
        CCSpriteFrame* spriteFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Stand 1.png"];
        spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:spriteFrame.texture];
        [self addChild:spriteBatch];
        
        enemys = [[CCArray alloc] initWithCapacity:MAX_ENEMY];
        spawnCount = 0;
        
        for (int i = 0; i < MAX_ENEMY; i++) {
            Enemy* enemy = [[Enemy alloc] init];
            [enemys addObject:enemy];
            [spriteBatch addChild:enemy];
        }
        
        [self scheduleUpdate];
    }
    return self;
}

#pragma mark - update

-(void)update:(ccTime)delta
{
    spawnCount ++;
    if (spawnCount % SPAWN_INTERVAL == 0) {
        [self enemyAt];
    }
}

#pragma mark - action

-(void)enemyAt
{
    for (Enemy* enemy in enemys) {
        if (enemy.visible == NO) {
            CGPoint spawnLocation = [self getSpawnLocation:enemy];
            [enemy spawnWithLocation:spawnLocation];
            break;
        }
    }
}

-(CGPoint)getSpawnLocation:(Enemy*)enemy
{
    if ([CalUtil rundomBool]) {
        return [self getSpawnLocationLeft:enemy];
    }
    else {
        return [self getSpawnLocationRight:enemy];
    }
}

-(CGPoint)getSpawnLocationLeft:(Enemy*)enemy
{
    CGSize textureSize = enemy.contentSize;
    Stage* stage = [[GameScene sharedGameScene] stage];
    
    float x = -textureSize.width * 0.5f;
    float y = textureSize.height * 0.5f + [stage getGroundHeight];
    CGPoint position = CGPointMake(x, y);
    return position;
}

-(CGPoint)getSpawnLocationRight:(Enemy*)enemy

{
    CGSize textureSize = enemy.contentSize;
    CGSize screenSize = [GameScene screenRect].size;
    Stage* stage = [[GameScene sharedGameScene] stage];
    
    float x = screenSize.width + textureSize.width * 0.5f;
    float y = textureSize.height * 0.5f + [stage getGroundHeight];
    CGPoint position = CGPointMake(x, y);
    return position;
}

@end
