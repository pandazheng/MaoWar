//
//  GameEnemyBullet.m
//  MaoWar
//
//  Created by panda zheng on 13-6-28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameEnemyBullet.h"


@implementation GameEnemyBullet

- (void) onEnter
{
    [super onEnter];
    //初始化主体
    isvisable = NO;
    [self setContentSize:CGSizeMake(21, 52)];
    CCSprite *mainbody = [CCSprite spriteWithFile:@"DrDogZD.png"];
    [mainbody runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:360]]];
    [self addChild:mainbody];
}

- (void) onExit
{
    [super onExit];
}

- (bool) getIsvisable
{
    return isvisable;
}

- (void) setIsVisable
{
    //运行动作
    [self setVisible:YES];
    isvisable = YES;
    [self runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:360]]];
    [self runAction:[CCSequence actions:[CCMoveTo actionWithDuration:([self position].y + 50)/150 position:ccp([self position].x,-50)],[CCCallFunc actionWithTarget:self selector:@selector(setIsNotVisable)],nil]];
}

- (void) setIsNotVisable
{
    [self setVisible:NO];
    isvisable = NO;
    [self stopAllActions];
}

@end
