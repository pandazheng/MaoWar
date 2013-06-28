//
//  GameHeroBullet.m
//  MaoWar
//
//  Created by panda zheng on 13-6-28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameHeroBullet.h"


@implementation GameHeroBullet

- (void) setIsNotVisable
{
    [self setVisible:NO];
    isvisable = NO;
    [self stopAllActions];
}

- (void) setIsVisable
{
    //子弹移动，运行动作
    [self setVisible:YES];
    isvisable = YES;
    CCActionInterval *move = [CCMoveTo actionWithDuration:(-[self position].y + 550)/150 position:ccp([self position].x,550)];
    CCCallFunc *funCall = [CCCallFunc actionWithTarget:self selector:@selector(setIsNotVisable)];
    [self runAction:[CCSequence actions:move,funCall, nil]];
}

- (bool) getIsvisable
{
    return isvisable;
}

- (void) onEnter
{
    [super onEnter];
    //初始化主体
    [self setContentSize:CGSizeMake(21, 52)];
    CCSprite *mainbody = [CCSprite spriteWithFile:@"YuGuZD.png"];
    [self addChild:mainbody];
}

- (void) onExit
{
    [super onExit];
}

@end
