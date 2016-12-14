//
//  Animation.m
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/01/14.
//
//

#import "Animation.h"

@implementation Animation

@synthesize frames;
@synthesize repeat;
@synthesize delay;


#pragma mark - init

-(id)init {
    if (self = [super init]) {
        frames = [[CCArray alloc] init];
    }
    return self;
}

-(void)dealloc
{
    frames = nil;
    
    [super dealloc];
}

-(int)duration
{
    return [frames count] * ANIMATION_FARME;
}

-(int)delayDuration
{
    return delay * ANIMATION_FARME;
}

@end

