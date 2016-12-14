//
//  State.m
//  Mujinken_Test
//
//  Created by ohashi tosikazu on 2012/10/01.
//
//

#import "Precondition.h"

#import "UserInput.h"
#import "PreconditionType.h"
#import "ConditionTypeSwipe.h"
#import "ConditionTypeAccel.h"
#import "ConditionTypeButton.h"

@implementation Precondition

@synthesize conditionType;
@synthesize priority;

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

#pragma mark - judg state condition

-(BOOL)isChangeState:(UserInput*)userInput
{
    NSAssert(conditionType != nil, @"条件タイプが設定されていません。");
    BOOL result = [conditionType isChangeState:userInput];
    return result;
}

@end
