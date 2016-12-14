//
//  InputAccel.m
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/03/24.
//
//

#import "ConditionTypeAccel.h"
#import "UserInput.h"

@implementation ConditionTypeAccel

@synthesize above;
@synthesize degree;
@synthesize accelType;

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
    float value = [self getAccel:userInput.acceleration];
    BOOL result = [self valueCondition:value];
    return result;
}

-(float)getAccel:(UIAcceleration*)accel
{
    float value;
    switch (accelType) {
        case X:
            value = accel.x;
            break;
        case Y:
            value = accel.y;
            break;
        case Z:
            value = accel.z;
            break;
        default:
            CCLOGERROR(@"対応する入力が見つかりません。");
            break;
    }
    return value;
}

-(BOOL)valueCondition:(float)value
{
    if (above) {
        if (value > degree) {
            return YES;
        }
    }
    else {
        if (value < degree) {
            return YES;
        }
    }
    return NO;
}

@end
