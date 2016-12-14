//
//  InputSwipe.h
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/03/24.
//
//

#import <Foundation/Foundation.h>
#import "PreconditionType.h"

@interface ConditionTypeSwipe : PreconditionType
{
    NSRange range;
    float degree;
    BOOL isHold;
}

@property(readwrite)NSRange range;
@property(readwrite)float degree;
@property(readwrite)BOOL isHold;
@end
