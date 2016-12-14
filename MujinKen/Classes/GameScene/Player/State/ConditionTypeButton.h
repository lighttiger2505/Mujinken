//
//  InputButton.h
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/03/24.
//
//

#import <Foundation/Foundation.h>

#import "PreconditionType.h"

@interface ConditionTypeButton : PreconditionType
{
    NSString* buttonName;
}

@property(retain, nonatomic)NSString* buttonName;

@end
