//
//  Attack.m
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/01/14.
//
//

#import "Attack.h"

@implementation Attack

@synthesize rect;
@synthesize hitTime;

#pragma mark - init

-(void)dealloc
{
    [super dealloc];
}

-(id)init {
    if (self = [super init]) {
        
    }
    return self;
}

-(int)hitTimeFrame
{
    return hitTime * ANIMATION_FARME;
}

@end

