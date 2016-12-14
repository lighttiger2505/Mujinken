//
//  PlayerStateReader.h
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/02/14.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PlayerStateReader : NSObject
{
    NSString* fileName;
}
- (id)initWithFileName:(NSString*)aFileName;
- (CCArray *)getParsedData;

@end
