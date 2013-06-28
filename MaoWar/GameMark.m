//
//  GameMark.m
//  MaoWar
//
//  Created by panda zheng on 13-6-28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameMark.h"


@implementation GameMark

- (void) onExit
{
    [super onExit];
}

- (void) onEnter
{
    [super onEnter];
    CGSize size = [[CCDirector sharedDirector] winSize];
    [self setContentSize:size];
    bits = [CCArray array];
    //分数标题
    CCSprite *title = [CCSprite spriteWithFile:@"score.png"];
    [title setPosition:ccp(size.width/2 + 40,size.height - 15)];
    [title setScale:0.5];
    [self addChild:title];
    //数字按位设置
    for (int i = 0 ; i < 5 ; i++)
    {
        CCSprite *shu = [CCSprite spriteWithFile:@"shu.png"];
        ui = [shu texture];
        [shu setScale:0.5];
        [shu setTextureRect:CGRectMake(234, 0, 26, 31)];
        [shu setPosition:ccp(size.width - 15 - i*15,size.height - 15)];
        [bits addObject:shu];
        [self addChild:shu];
    }
    [bits retain];
    mark = 0;
}

- (void) addnumber:(int)var
{
    //分数，按位置设置数字
    mark += var;
    int temp = mark % 10;
    if (temp > 0)
    {
        [(CCSprite*)[bits objectAtIndex:0] setTexture:ui];
        [(CCSprite*)[bits objectAtIndex:0] setTextureRect:CGRectMake((temp -1)*26, 0, 26, 31)];
    }
    else
    {
        [(CCSprite*)[bits objectAtIndex:0] setTexture:ui];
        [(CCSprite*)[bits objectAtIndex:0] setTextureRect:CGRectMake(234, 0, 26, 31)];
    }
    
    temp = (mark % 100) / 10;
    if (temp > 0)
    {
        [(CCSprite*)[bits objectAtIndex:0] setTexture:ui];
        [(CCSprite*)[bits objectAtIndex:1] setTextureRect:CGRectMake((temp -1)*26, 0, 26, 31)];
    }
    else
    {
        [(CCSprite*)[bits objectAtIndex:0] setTexture:ui];
        [(CCSprite*)[bits objectAtIndex:1] setTextureRect:CGRectMake(234, 0, 26, 31)];
    }

    temp = (mark % 1000) / 100;
    if (temp > 0)
    {
        [(CCSprite*)[bits objectAtIndex:0] setTexture:ui];
        [(CCSprite*)[bits objectAtIndex:2] setTextureRect:CGRectMake((temp -1)*26, 0, 26, 31)];
    }
    else
    {
        [(CCSprite*)[bits objectAtIndex:0] setTexture:ui];
        [(CCSprite*)[bits objectAtIndex:2] setTextureRect:CGRectMake(234, 0, 26, 31)];
    }

    temp = (mark % 10000) / 1000;
    if (temp > 0)
    {
        [(CCSprite*)[bits objectAtIndex:0] setTexture:ui];
        [(CCSprite*)[bits objectAtIndex:3] setTextureRect:CGRectMake((temp -1)*26, 0, 26, 31)];
    }
    else
    {
        [(CCSprite*)[bits objectAtIndex:0] setTexture:ui];
        [(CCSprite*)[bits objectAtIndex:3] setTextureRect:CGRectMake(234, 0, 26, 31)];
    }

    temp = mark / 10000;
    if (temp > 0)
    {
        [(CCSprite*)[bits objectAtIndex:0] setTexture:ui];
        [(CCSprite*)[bits objectAtIndex:4] setTextureRect:CGRectMake((temp -1)*26, 0, 26, 31)];
    }
    else
    {
        [(CCSprite*)[bits objectAtIndex:0] setTexture:ui];
        [(CCSprite*)[bits objectAtIndex:4] setTextureRect:CGRectMake(234, 0, 26, 31)];
    }
}

@end
