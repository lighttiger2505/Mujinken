//
//  InputButton.m
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/03/24.
//
//

#import "ConditionTypeButton.h"

#import "UserInput.h"

@implementation ConditionTypeButton

@synthesize buttonName;

#pragma mark -init

-(void)dealloc
{
    [super dealloc];
}

-(id)init
{
    if ((self = [super init])) {
        
    }
    return self;
}

-(BOOL)isChangeState:(UserInput*)userInput
{
    BOOL result = [userInput isButtonTouch:buttonName];
    return result;
}

@end
