//
//  StateAction.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/10/02.
//
//

#import "State.h"
#import "UserInput.h"

@implementation State

@synthesize stateName;
@synthesize animation;
@synthesize move;
@synthesize attack;
@synthesize condition;

#pragma mark - init

-(id)init {
    if (self = [super init]) {

    }
    return self;
}

-(void)dealloc
{
    animation = nil;
    move = nil;
    attack = nil;
    condition = nil;
    
    [super dealloc];
}

-(BOOL)isState:(NSString*)compareStateName
{
    if ([stateName compare:compareStateName] == NSOrderedSame) {
        return YES;
    }
    return NO;
}

-(BOOL)compare:(State*)stateAction
{
    if ([stateName compare:stateAction.stateName] == NSOrderedSame) {
        return YES;
    }
    return NO;
}

@end
