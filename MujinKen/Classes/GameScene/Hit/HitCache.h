//
//  HitCache.h
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/09/20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Hit.h"

#define MAX_HIT 200

@interface HitCache : CCNode {
    @private
    CCArray* hits;
}

-(void)hitFrom:(CGRect)rect isPlayerHit:(bool)isPlayerHit;
-(bool)isPlayerHitCollidingWithRect:(CGRect)rect;
-(bool)isEnemyHitCollidingWithRect:(CGRect)rect;
  
@end
