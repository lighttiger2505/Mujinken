//
//  Bullet.h
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/09/20.
//
//

#import "CCNode.h"

#import "DebugLayer.h"
#import "CalUtil.h"

@interface Hit : CCNode {
    BOOL isPlayerHit;
    int duration;
}

@property(readonly) BOOL isPlayerHit;

-(void)hitAt:(CGRect)rect isPlayerHit:(BOOL)aIsPlayerHit;

@end
