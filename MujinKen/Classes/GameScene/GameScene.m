//
//  GameScene.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/08/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"

#import "SimpleAudioEngine.h"

#import "InputLayer.h"
#import "DebugLayer.h"
#import "SoundLoader.h"

#import "EnemyCache.h"
#import "HitCache.h"
#import "Stage.h"


@implementation GameScene

#pragma mark - static num

static CGRect screenRect;

#pragma mark - shared instance

static GameScene* instanceOfGameScene;

+(GameScene*) sharedGameScene
{
	NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
	return instanceOfGameScene;
}

#pragma mark - init

+(id)scene
{
    CCScene* scene = [CCScene node];
    
    CCLayer* gameScene = [GameScene node];
    [scene addChild:gameScene z:0 tag:GameSceneLayerTagGame];
    
    CCLayer* inputLayer = [InputLayer node];
    [scene addChild:inputLayer z:1 tag:GameSceneLayerTagInput];
    
//    CCLayer* debugLayer = [DebugLayer node];
//    [scene addChild:debugLayer z:2 tag:GameSceneLayerTagDebug];
    
    return scene;
}

-(void)dealloc
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
    [super dealloc];
}

-(id)init
{
    CCLOGINFO(@"ゲームシーン初期化開始");
    
    if ((self = [super init])) {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        
        [self initScene];
        [self initTexture];
        [self initSound];
        [self initEntity];
        
        [self scheduleUpdate];
    }
    
    CCLOGINFO(@"ゲームシーン初期化終了");
    
    return self;
}

-(void)initScene
{
    instanceOfGameScene = self;
    self.isTouchEnabled = YES;
}

-(void)initTexture
{
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"Spreadsheet_default.plist"];
}

-(void)initSound
{
    soundLoader = [[SoundLoader alloc] init];
    soundLoader.backGroundMusic = @"Quick pipes.mp3";
    CCArray* soundEffects = [[CCArray alloc] init];
    [soundEffects addObject:@"m2_swing001.wav"];
    [soundEffects addObject:@"tm2_hit004.wav"];
    soundLoader.soundEffects = soundEffects;
}

-(void)initEntity
{
    Stage* stage = [[Stage alloc] init];
    [self addChild:stage z:0 tag:GameSceneNodeTagStage];
    
    Player* player = [Player player];
    [stage addChild:player z:0 tag:GameSceneNodeTagPlayer];
    
    EnemyCache* enemyCache = [[EnemyCache alloc] init];
    [stage addChild:enemyCache z:0 tag:GameSceneNodeTagEnemyCache];
    
    HitCache* hitCache = [[HitCache alloc] init];
    [stage addChild:hitCache z:0 tag:GameSceneNodeTagHitCache];
}

#pragma mark - scene enter

-(void)onEnter
{
    [super onEnter];
    
    [soundLoader preloadSoundEffects];
    
    SimpleAudioEngine* simpleAudioEngine = [SimpleAudioEngine sharedEngine];
    [simpleAudioEngine playBackgroundMusic:soundLoader.backGroundMusic loop:YES];
    
    //CGSize screenSize = [[CCDirector sharedDirector] winSize];
    //screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
}

-(void)onExit
{
    [super onExit];
    
    [soundLoader unloadSoundEffects];
    
    SimpleAudioEngine* simpleAudioEngine = [SimpleAudioEngine sharedEngine];
    [simpleAudioEngine stopBackgroundMusic];
}

#pragma mark - update

-(void)update:(ccTime)delta
{
}

-(void)addEffect:(CGPoint)location
{
    CCParticleSystem * ps = [CCParticleSystemQuad particleWithFile:@"exploding_ring.plist"];;
    ps.sourcePosition = location;
    ps.autoRemoveOnFinish = YES;
    [self addChild:ps];
}

#pragma mark - GameSceneProp

-(Player*)player
{
    CCNode* stage = [self stage];
	CCNode* node =  [stage getChildByTag:GameSceneNodeTagPlayer];
	NSAssert([node isKindOfClass:[Player class]], @"node is not a Player!");
	return (Player*)node;
}

-(EnemyCache*)enemyCache
{
    CCNode* stage = [self stage];
	CCNode* node = [stage getChildByTag:GameSceneNodeTagEnemyCache];
	NSAssert([node isKindOfClass:[EnemyCache class]], @"node is not a EnemyCache!");
	return (EnemyCache*)node;
}

-(HitCache*)hitCache
{
    CCNode* stage = [self stage];
    CCNode* node = [stage getChildByTag:GameSceneNodeTagHitCache];
    NSAssert([node isKindOfClass:[HitCache class]], @"node is not a EnemyCache!");
    return (HitCache*)node;
}

-(Stage*)stage
{
    CCNode* node = [self getChildByTag:GameSceneNodeTagStage];
    NSAssert([node isKindOfClass:[Stage class]], @"node is not a Stage!");
    return (Stage*)node;
}

+(CGRect)screenRect
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    if (screenSize.width == 0) {
        screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
    }
    else {
        screenRect = CGRectMake(0, 0, 480, 320);
    }
    return screenRect;
}

@end
