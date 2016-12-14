//
//  InputType.m
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/03/24.
//
//

#import "PreconditionType.h"

#import "UserInput.h"
#import "ConditionTypeSwipe.h"
#import "ConditionTypeAccel.h"
#import "ConditionTypeButton.h"

@implementation PreconditionType

-(BOOL)isChangeState:(UserInput*)userInput
{
    return YES;
}

@end
