//
//  StateDetector.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/09/02.
//
//

#import "PlayerStateFactory.h"

#import "UserInput.h"
#import "TouchTrack.h"
#import "PlayerStateReader.h"

@implementation PlayerStateFactory


#pragma mark - init

-(void)dealloc
{
    states = nil;
    [super dealloc];
}

-(id)init
{
    if (self = [super init]) {
        PlayerStateReader* reader = [[PlayerStateReader alloc] initWithFileName:@"player_state"];
        states= [reader getParsedData];
    }
    return self;
}

#pragma mark - get state

-(State*)getState:(NSString*)stateName
{
    State *changeAction = nil;
    
    for (State* stateAction in states) {
        if ([stateAction isState:stateName]) {
            changeAction = stateAction;
        }
    }

    NSAssert2(changeAction != nil, @"%@: unsupported State %@", NSStringFromSelector(_cmd), stateName);

    return changeAction;
}

#pragma mark - player handle

-(State*)getStateForInput:(UserInput*)userInput
{
    State* newState = nil;
    for (State* state in states) {
        Precondition* condition = state.condition;
        if ([condition isChangeState:userInput]) {
            if (newState != nil) {
                if (state.condition.priority > newState.condition.priority) {
                    newState = state;
                }
            }
            else {
                newState = state;
            }
        }
    }
    if (newState != nil) {
        return newState;
    }
    else {
        return [self getStateDefault];
    }
}

-(State*)getStateDefault
{
    State* changeState = [self getState:@"Stand"];
    return changeState;
}

@end
