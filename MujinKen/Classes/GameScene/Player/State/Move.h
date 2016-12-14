//
//  Move.h
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/01/14.
//
//

#import <Foundation/Foundation.h>
#import "Definition.h"

@interface Move : NSObject {
    CGPoint velocity;
    Direction direction;
}
@property(readwrite)CGPoint velocity;
@property(readwrite)Direction direction;
@end
