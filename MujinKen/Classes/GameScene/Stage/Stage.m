//
//  Stage.m
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/01/14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Stage.h"

#import "GameScene.h"
#import "Player.h"
#import "Entity.h"
#import "DebugLayer.h"

@implementation Stage

@synthesize screenSize;
@synthesize stageSize;

#pragma mark - init

-(void)dealloc
{
    [super dealloc];
}

-(id) init
{
	if ((self = [super init]))
	{
        CCLayer* debugLayer = [DebugLayer node];
        [self addChild:debugLayer z:2 tag:GameSceneLayerTagDebug];
        
		screenSize = [GameScene screenRect].size;
        stageSize = CGSizeMake(screenSize.width * 5, screenSize.height);
		
		spriteBatch = [CCSpriteBatchNode batchNodeWithFile:@"Spreadsheet_default.png"];
		[self addChild:spriteBatch];
        
        [self addBackGroundPart:@"floor.png"];
        [self addBackGroundPart:@"kazari.png"];
		
		[self scheduleUpdate];
	}
	
	return self;
}

-(void)addBackGroundPart:(NSString*)spriteFrameName
{
    CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
    CGSize spriteFrameSize = tempSprite.contentSize;
    for (int i = 0; i * spriteFrameSize.width <= stageSize.width; i++) {
        CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
        sprite.anchorPoint = ccp(0, 0.5f);
        sprite.position = ccp(spriteFrameSize.width * i, screenSize.height / 2);
        if (i % 2 == 1) {
            sprite.flipX = YES;
        }
        [spriteBatch addChild:sprite];
    }
}


#pragma mark - update

-(void) update:(ccTime)delta{
    Player* player = [[GameScene sharedGameScene] player];
    CGPoint newCurrentPoint = ccp(-(player.position.x - screenSize.width / 2), self.position.y);
    self.position = newCurrentPoint;
}

#pragma mark - getter

-(float)getGroundHeight
{
    return 60.0f;
}

@end
