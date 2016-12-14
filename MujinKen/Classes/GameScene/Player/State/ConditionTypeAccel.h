//
//  InputAccel.h
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/03/24.
//
//

#import <Foundation/Foundation.h>

#import "PreconditionType.h"

enum ACCEL_TYPE {
    X = 1,
    Y = 2,
    Z = 3,
}typedef AccelType;

@interface ConditionTypeAccel : PreconditionType
{
    AccelType accelType;
    float degree;
    BOOL above;
}

@property(readwrite) AccelType accelType;
@property(readwrite) float degree;
@property(readwrite) BOOL above;

@end
