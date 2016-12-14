//
//  PlayerStateReaderTest.m
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/02/14.
//
//

#import "PlayerStateReaderTest.h"

#import "PlayerStateReader.h"
#import "State.h"
#import "Animation.h"
#import "Attack.h"
#import "Move.h"
#import "Precondition.h"
#import "PreconditionType.h"
#import "ConditionTypeAccel.h"
#import "ConditionTypeButton.h"
#import "ConditionTypeSwipe.h"

@implementation PlayerStateReaderTest

- (void)test
{
    PlayerStateReader* reader = [[PlayerStateReader alloc] initWithFileName:@"player_state_test"];
    CCArray* result = [reader getParsedData];
    
    STAssertNotNil(result, @"");

    State* state = [result objectAtIndex:0];
    STAssertEqualObjects(state.stateName, @"StateName", @"");
    
    Animation* animation = state.animation;
    Move* move = state.move;
    Attack* attack = state.attack;
    Precondition* precondition = state.condition;
    STAssertNotNil(animation,  @"");
    STAssertNotNil(move,  @"");
    STAssertNotNil(attack,  @"");
    STAssertNotNil(precondition,  @"");
    
    CCArray* frames = animation.frames;
    STAssertEqualObjects([frames objectAtIndex:0], @"Image1.png", @"");
    STAssertEqualObjects([frames objectAtIndex:1], @"Image2.png", @"");
    STAssertEqualObjects([frames objectAtIndex:2], @"Image3.png", @"");
    STAssertEqualObjects([frames objectAtIndex:3], @"Image4.png", @"");
    STAssertEquals(animation.delay, 1, @"");
    STAssertEquals(animation.repeat, YES, @"");
    
    CGPoint velocity = move.velocity;
    STAssertEquals(velocity.x, 0.0f, @"");
    STAssertEquals(velocity.y, 1.0f, @"");
    STAssertEquals(move.direction, 2, @"");
    
    CGRect rect = attack.rect;
    STAssertEquals(rect.origin.x, 1.0f, @"");
    STAssertEquals(rect.origin.y, 2.0f, @"");
    STAssertEquals(rect.size.width, 3.0f, @"");
    STAssertEquals(rect.size.height, 4.0f, @"");
    STAssertEquals(attack.hitTime, 0, @"");
    
    STAssertEquals(precondition.priority, 0, @"");
    STAssertTrue([precondition.conditionType isKindOfClass:[ConditionTypeSwipe class]], @"");
    ConditionTypeSwipe* conditionTypeSwipe = (ConditionTypeSwipe*)precondition.conditionType;
    NSRange range = conditionTypeSwipe.range;
    STAssertEquals(range.location, (NSUInteger)0, @"");
    STAssertEquals(range.length, (NSUInteger)1, @"");
    STAssertEquals(conditionTypeSwipe.isHold, YES, @"");
    STAssertEquals(conditionTypeSwipe.degree, 1.0f, @"");
    
//    STAssertEquals([precondition.conditionType class], [ConditionTypeSwipe class], @"");
//    ConditionTypeAccel* conditionTypeAccel = (ConditionTypeAccel*)precondition.conditionType;
//    STAssertEquals(conditionTypeAccel.accelType, 0, @"");
//    STAssertEquals(conditionTypeAccel.degree, 0.0f, @"");
//    STAssertEquals(conditionTypeAccel.above, YES, @"");
//    
//    STAssertEquals([precondition class], [ConditionTypeButton class], @"");
//    ConditionTypeButton* conditionTypeButton = (ConditionTypeButton*)precondition.conditionType;
//    STAssertEquals(conditionTypeButton.buttonName, @"", @"");
    

}

@end
