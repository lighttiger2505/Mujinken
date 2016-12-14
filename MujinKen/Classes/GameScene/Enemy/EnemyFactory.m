//
//  EnemyFactory.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/08/18.
//
//

#import "EnemyFactory.h"

#import "Enemy.h"

@implementation EnemyFactory

#pragma mark - init

-(void)dealloc
{
    [super dealloc];
}

-(id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - create enemy

-(Enemy*)createEnemy
{
    Enemy* enemy = [[Enemy alloc] init];
    
    return enemy;
}

@end
