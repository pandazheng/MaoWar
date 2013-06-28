//
//  GameObjHero.m
//  MaoWar
//
//  Created by panda zheng on 13-6-27.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameObjHero.h"
#import "GameMain.h"


@implementation GameObjHero

- (CGRect) rect
{
    CGSize s = CGSizeMake(85, 90);
    return CGRectMake(-s.width/2, -s.height/2, s.width, s.height);
}

- (bool) containsTouchLocation:(UITouch*) touch
{
    return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (void) onEnter
{
    [super onEnter];
    [self setContentSize:CGSizeMake(85, 90)];
    //注册触摸事件
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    
    CCSprite *mainsprite = [CCSprite spriteWithFile:@"catBody1.png"];
    //主体动画
    CCAnimation *animation = [[CCAnimation alloc] init];
    [animation addSpriteFrameWithFilename:@"catBody1.png"];
    [animation addSpriteFrameWithFilename:@"catBody2-4.png"];
    [animation addSpriteFrameWithFilename:@"catBody3.png"];
    [animation addSpriteFrameWithFilename:@"catBody2-4.png"];
    [animation setDelayPerUnit:0.1f];
    [animation setRestoreOriginalFrame:YES];
    [mainsprite runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]]];
    [self addChild:mainsprite];
    
    //添加尾巴
    CCSprite *tail = [CCSprite spriteWithFile:@"catTail.png"];
    [tail setAnchorPoint:ccp(0.5,1)];
    [tail setPosition:ccp(-5,-29)];
    [tail setScale:0.5];
    [tail setRotation:20];
    [tail runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCRotateBy actionWithDuration:0.5 angle:-40],[CCRotateBy actionWithDuration:0.5 angle:40], nil]]];
    [self addChild:tail];
    
    //添加手
    lefthand = [CCSprite spriteWithFile:@"catHand1.png"];
    [lefthand setAnchorPoint:ccp(1,0.5)];
    [lefthand setPosition:ccp(-18,-20)];
    [self addChild:lefthand];
    righthand = [CCSprite spriteWithFile:@"catHand2.png"];
    [righthand setPosition:ccp(18,-20)];
    [righthand setAnchorPoint:ccp(0,0.5)];
    [self addChild:righthand];
    offset = ccp(0,0);
    iscontrol = NO;
    
    //设置定时器，每隔一秒调用releasebullet
    [self schedule:@selector(releasebullet) interval:1.0f];
}

- (void) releasebullet
{
    //释放子弹
    if (iscontrol)
    {
        CGPoint pos = [self position];
        GameMain *p = (GameMain*)[self parent];
        [p releaseheroBullet:pos.x :pos.y];
    }
}

- (void) onExit
{
    //注销触摸代理
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    if (![self containsTouchLocation:touch])
    {
        return NO;
    }
    else
    {
        //获得触摸偏移位置
        iscontrol = YES;
        CGPoint touchPoint = [touch locationInView:[touch view]];
        touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
        offset.x = touchPoint.x - [self position].x;
        offset.y = touchPoint.y - [self position].y;
    }
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    //设置左右手上下
    float x = touchPoint.x - offset.x;
    float y = touchPoint.y - offset.y;
    if (x < [self position].x)
    {
        [lefthand setFlipY:YES];
        [righthand setFlipY:NO];
    }
    else
    {
        [lefthand setFlipY:NO];
        [righthand setFlipY:YES];
    }
    [self setPosition:ccp(x,y)];
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (iscontrol)
    {
        iscontrol = NO;
        [lefthand setFlipY:NO];
        [righthand setFlipY:NO];
    }
}

@end
