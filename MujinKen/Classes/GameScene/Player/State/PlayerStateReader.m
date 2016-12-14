//
//  PlayerStateReader.m
//  MujinKen
//
//  Created by ohashi tosikazu on 2013/02/14.
//
//

#import "PlayerStateReader.h"

#import "DDXML.h"
#import "State.h"
#import "PreconditionType.h"
#import "ConditionTypeSwipe.h"
#import "ConditionTypeAccel.h"
#import "ConditionTypeButton.h"

@implementation PlayerStateReader

- (id)initWithFileName:(NSString*)aFileName
{
    if ((self = [super init])) {
        fileName = aFileName;
    }
    return self;
}

- (CCArray *)getParsedData{
    
    CCLOGINFO("プレイヤーステータス読み込み開始");
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

    NSData *data = [self getFile];
    
    //返すデータの配列を作成・初期化
    CCArray *parsedData=[[CCArray alloc]initWithCapacity:0];
    
    //xmlファイルを取得
    DDXMLDocument *doc=
    [[DDXMLDocument alloc]initWithData:data options:0 error:nil];
    
    //要素を抜き出す時のルートパスの設定
    DDXMLElement *root=[doc rootElement];
    NSArray *items=[root nodesForXPath:@"/states/state" error:nil];
    
    //高速列挙を使用してfor文を回す
    for (DDXMLElement *item in items) {
        [parsedData addObject:[self getState:item]];
    }
    
    //xmlファイルをリリース
    [doc release];
    
    CCLOGINFO("プレイヤーステータス読み込み終了");

    //取得データを返す
    return parsedData;
}

- (NSData*)getFile
{
    NSBundle* mainBundle=[NSBundle mainBundle];
    NSString* path = [mainBundle pathForResource:fileName ofType:@"xml"];
    
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:path options:NSDataReadingMapped error:&error];
    
    if (error != nil) {
        NSLog(@"error: %@", error);
    }
    
    return data;
}

- (State*)getState:(DDXMLElement*)element
{
    State* state = [[State alloc] init];
    state.stateName = [self valueStringForElement:element Name:@"name"];
    
    DDXMLElement *animationElement = [self getChildElement:element Name:@"animation"];
    if (animationElement != nil)
    {
        Animation* animation = [self parseAnimation:animationElement];
        state.animation =  animation;
    }

    DDXMLElement *moveElement = [self getChildElement:element Name:@"move"];
    if (moveElement != nil) {
        Move* move = [self parseMove:moveElement];
        state.move = move;
    }
    
    DDXMLElement *attackElement = [self getChildElement:element Name:@"attack"];
    if (attackElement != nil) {
        Attack* attack = [self parseAttack:attackElement];
        state.attack = attack;
    }
    
    DDXMLElement *conditionElement= [self getChildElement:element Name:@"condition"];
    if (conditionElement != nil) {
        Precondition* condition = [self parseCondition:conditionElement];
        state.condition = condition;
    }

    return state;
}

#pragma mark - ParseObject

- (Animation*)parseAnimation:(DDXMLElement*)element
{
    Animation* animation = [[Animation alloc] init];
    animation.frames = [self arrayForElement:element ParentName:@"frames" ChildrenName:@"name"];
    animation.delay = [self valueIntForElement:element Name:@"delay"];
    animation.repeat = [self valueBoolForElement:element Name:@"repeat"];
    return animation;
}

- (Move*)parseMove:(DDXMLElement*)element
{
    Move* move = [[Move alloc] init];
    move.velocity = [self pointForElement:element Name:@"velocity"];
    move.direction = [self valueIntForElement:element Name:@"direction"];
    return move;
}

- (Attack*)parseAttack:(DDXMLElement*)element
{
    Attack* attack = [[Attack alloc] init];
    attack.rect = [self rectForElement:element Name:@"rect"];
    attack.hitTime = [self valueIntForElement:element Name:@"hit_time"];
    return attack;
}

- (Precondition*)parseCondition:(DDXMLElement*)element
{
    Precondition* condition = [[Precondition alloc] init];
    condition.priority = [self valueIntForElement:element Name:@"priority"];
    condition.conditionType = [self getConditionType:element];

    return condition;
}

- (PreconditionType*)getConditionType:(DDXMLElement*)element
{
    DDXMLElement* swipeElement = [self getChildElement:element Name:@"condition_type_swipe"];
    DDXMLElement* accelElement = [self getChildElement:element Name:@"condition_type_accel"];
    DDXMLElement* buttonElement = [self getChildElement:element Name:@"condition_type_button"];
    if (swipeElement != nil) {
        return [self parseConditionTypeSwipe:swipeElement];
    }
    if (accelElement != nil) {
        return [self parseConditionTypeAccel:accelElement];
    }
    if (buttonElement != nil) {
        return [self parseConditionTypeButton:buttonElement];
    }
    else {
        CCLOGERROR(@"存在しない入力条件形式です。");
        return nil;
    }
}

-(ConditionTypeSwipe*)parseConditionTypeSwipe:(DDXMLElement*)element
{
    ConditionTypeSwipe* conditionTypeSwipe = [[ConditionTypeSwipe alloc] init];
    conditionTypeSwipe.range = [self rangeForElement:element Name:@"angle"];
    conditionTypeSwipe.isHold = [self valueBoolForElement:element Name:@"hold"];
    conditionTypeSwipe.degree = [self valueFloatForElement:element Name:@"degree"];
    
    return conditionTypeSwipe;
}

-(ConditionTypeAccel*)parseConditionTypeAccel:(DDXMLElement*)element
{
    ConditionTypeAccel* conditionTypeAccel = [[ConditionTypeAccel alloc] init];
    conditionTypeAccel.accelType = [self valueIntForElement:element Name:@"accel_type"];
    conditionTypeAccel.degree = [self valueFloatForElement:element Name:@"degree"];
    conditionTypeAccel.above = [self valueBoolForElement:element Name:@"above"];
    
    return conditionTypeAccel;
}

-(ConditionTypeButton*)parseConditionTypeButton:(DDXMLElement*)element
{
    ConditionTypeButton* conditionTypeButton = [[ConditionTypeButton alloc] init];
    conditionTypeButton.buttonName = [self valueStringForElement:element Name:@"button_name"];
    
    return conditionTypeButton;
}

#pragma mark - GetElement

- (NSArray*)getChildrenElement:(DDXMLElement*)element Name:(NSString*)name
{
    NSError *error = nil;
    NSArray* childrenElement = [element nodesForXPath:name error:&error];
    
    if (error != nil) {
        NSLog(@"error: %@", error);
    }
    
    return childrenElement;
}

- (DDXMLElement*)getChildElement:(DDXMLElement*)element Name:(NSString*)name
{
    NSError *error = nil;
    NSArray* childrenElement = [element nodesForXPath:name error:&error];
    if (error != nil) {
        NSLog(@"error: %@", error);
    }
    
    if ([childrenElement count]) {
        DDXMLElement* childElement = [childrenElement objectAtIndex:0];
        return childElement;
    }
    return nil;
}

#pragma mark - GetValue

- (NSString*)valueStringForElement:(DDXMLElement*)element Name:(NSString*)name
{
    NSString* valueString = [[self getChildElement:element Name:name] stringValue];
    return valueString;
}

- (int)valueIntForElement:(DDXMLElement*)element Name:(NSString*)name
{
    int valueInt = [[self valueStringForElement:element Name:name] intValue];
    return valueInt;
}

- (BOOL)valueBoolForElement:(DDXMLElement*)element Name:(NSString*)name
{
    BOOL valueBool = [[self valueStringForElement:element Name:name] boolValue];
    return valueBool;
}

- (float)valueFloatForElement:(DDXMLElement*)element Name:(NSString*)name
{
    float floatValue = [[self valueStringForElement:element Name:name] floatValue];
    return floatValue;
}

#pragma mark - GetStract

- (CCArray*)arrayForElement:(DDXMLElement*)element ParentName:(NSString*)parentName ChildrenName:(NSString*)childrenName
{
    CCArray* array = [[CCArray alloc] init];
    DDXMLElement* parentElement = [self getChildElement:element Name:parentName];
    NSArray* children = [self getChildrenElement:parentElement Name:childrenName];
    for (DDXMLElement* value in children ) {
        [array addObject:[value stringValue]];
    }
    return array;
}

- (CGRect)rectForElement:(DDXMLElement*)element Name:(NSString*)name
{
    DDXMLElement* rectElement = [self getChildElement:element Name:name];
    float x = [self valueFloatForElement:rectElement Name:@"x"];
    float y = [self valueFloatForElement:rectElement Name:@"y"];
    float width = [self valueFloatForElement:rectElement Name:@"width"];
    float height = [self valueFloatForElement:rectElement Name:@"height"];
    CGRect rect = CGRectMake(x, y, width, height);
    return rect;
}

- (CGPoint)pointForElement:(DDXMLElement*)element Name:(NSString*)name
{
    DDXMLElement* pointElement = [self getChildElement:element Name:name];
    float x = [self valueFloatForElement:pointElement Name:@"x"];
    float y = [self valueFloatForElement:pointElement Name:@"y"];
    CGPoint point = CGPointMake(x, y);
    return point;
}

- (NSRange)rangeForElement:(DDXMLElement*)element Name:(NSString*)name
{
    DDXMLElement* rangeElement = [self getChildElement:element Name:name];
    int start = [self valueIntForElement:rangeElement Name:@"start"];
    int end = [self valueIntForElement:rangeElement Name:@"end"];
    NSRange range = NSMakeRange(start, end);
    return range;
}

@end
