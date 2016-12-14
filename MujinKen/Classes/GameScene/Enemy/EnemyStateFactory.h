//
//  PaturnFactory.h
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/10/21.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class State;
@class Enemy;

@interface EnemyStateFactory : NSObject {
    CCArray* states;
}

-(State*)getState:(NSString*)stateName;
-(State*)getStateForPlayer:(Enemy*)enemy;

@end
