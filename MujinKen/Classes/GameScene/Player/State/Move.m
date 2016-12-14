//
//  Move.m
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/01/14.
//
//

#import "Move.h"

@implementation Move

@synthesize velocity;
@synthesize direction;

#pragma mark - init

-(void)dealloc
{
    [super dealloc];
}

-(id)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end