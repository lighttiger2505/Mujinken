//
//  Stage.h
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/01/14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Stage : CCNode {
    CCSpriteBatchNode* spriteBatch;
    CCArray *parts;
	
    CGSize screenSize;
    CGSize stageSize;
}

@property(readonly)CGSize screenSize;
@property(readonly)CGSize stageSize;

-(float)getGroundHeight;

@end
