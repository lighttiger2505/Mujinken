//
//  HitCache.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/09/20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "HitCache.h"


@implementation HitCache

#pragma mark - instance

+(HitCache*)hitCache
{
    return [[[HitCache alloc] init] autorelease];
}

#pragma mark - init

-(void)dealloc
{
    [hits release];
    [super dealloc];
}

-(id)init
{
    if(self = [super init]) {
        hits = [[CCArray alloc] initWithCapacity:MAX_HIT];
        
        for (int i = 0; i < MAX_HIT; i++) {
            Hit *hit = [[Hit alloc] init];
            [hits addObject:hit];
            [self addChild:hit];
        }
        
        [self scheduleUpdate];
    }
    return self;
}

#pragma mark - update

-(void)update:(ccTime)delta
{
    
}

#pragma mark - add hit

-(void)hitFrom:(CGRect)rect isPlayerHit:(bool)isPlayerHit
{
    for (Hit* hit in hits) {
        if (hit.visible == NO) {
            [hit hitAt:rect isPlayerHit:isPlayerHit];
            break;
        }
    }
}

#pragma mark - judg colliding

-(bool)isPlayerHitCollidingWithRect:(CGRect)rect
{
    return [self isHitCollidingWithRect:rect isPlayerHit:NO];
}

-(bool)isEnemyHitCollidingWithRect:(CGRect)rect
{
    return [self isHitCollidingWithRect:rect isPlayerHit:YES];
}

-(bool) isHitCollidingWithRect:(CGRect)rect isPlayerHit:(bool)isPlayerHit
{
	bool isColliding = NO;
	
	for (Hit* hit in hits) {
		if (hit.visible && isPlayerHit == hit.isPlayerHit)
		{
			if (CGRectIntersectsRect([hit boundingBox], rect))
			{
				isColliding = YES;
                break;
			}
		}
	}
	
	return isColliding;
}

@end
