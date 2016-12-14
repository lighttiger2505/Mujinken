//
//  Bullet.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/09/20.
//
//

#import "Hit.h"

@implementation Hit

@synthesize isPlayerHit;

#pragma mark - instance

+(id)Hit
{
    return [[self alloc] init];
}

#pragma mark - init

-(void)dealloc
{
    [super dealloc];
}

-(id)init
{
    if (self = [super init])
    {
        self.visible = NO;
    }
    return self;
}

#pragma mark - update

-(void)update:(ccTime)delta
{
    duration --;
    if (duration < 0){
        [self remove];
    }
    
    [[DebugLayer sharedDebugLayer] addRect:[CalUtil getCollisionRectWithNode:self]];
}

#pragma mark - action

-(void)remove
{
    self.visible = NO;
    [self stopAllActions];
    [self unscheduleAllSelectors];
}

-(void)hitAt:(CGRect)rect isPlayerHit:(BOOL)aIsPlayerHit
{
    self.position = rect.origin;
    self.contentSize = rect.size;
    isPlayerHit = aIsPlayerHit;
    duration = 1;
    self.visible = YES;
    [self scheduleUpdate];
}

@end
