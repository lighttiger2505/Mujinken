//
//  Attack.h
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/01/14.
//
//

#import <Foundation/Foundation.h>

#define ANIMATION_FARME 8

@interface Attack : NSObject {
    CGRect rect;
    int hitTime;
}
@property(readwrite)CGRect rect;
@property(readwrite)int hitTime;

-(int)hitTimeFrame;
@end
