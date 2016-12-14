//
//  Animation.h
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/01/14.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define ANIMATION_FARME 8

@interface Animation : NSObject {
    CCArray* frames;
    int delay;
    BOOL repeat;
}
@property(nonatomic, retain)CCArray* frames;
@property(readwrite)int delay;
@property(readwrite)BOOL repeat;

-(int)duration;
-(int)delayDuration;

@end
