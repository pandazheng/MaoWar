//
//  GameObjEnemy.m
//  MaoWar
//
//  Created by panda zheng on 13-6-28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameObjEnemy.h"
#import "GameMain.h"

@implementation GameObjEnemy

- (void) onEnter
{
    [super onEnter];
    [self setContentSize:CGSizeMake(99, 111)];
    mainbody = [CCSprite spriteWithFile:@"DrDog1.png"];
    //初始化动画
    CCAnimation *animation = [[CCAnimation alloc] init];
    [animation addSpriteFrameWithFilename:@"DrDog1.png"];
    [animation addSpriteFrameWithFilename:@"DrDog2.png"];
    [animation setDelayPerUnit:0.1f];
    [animation setRestoreOriginalFrame:YES];
    [mainbody runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]]];
    [self addChild:mainbody];
    
    boom = [CCSprite spriteWithFile:@"boom1.png"];
    [self addChild:boom];
    [boom setVisible:NO];
    islife = YES;
}

- (void) setdie
{
    islife = false;
    [mainbody setVisible: NO];
    [boom setVisible:YES];
    [self stopAllActions];
    
    //爆炸动画
    CCAnimation *boomAnimation = [[CCAnimation alloc] init];
    [boomAnimation addSpriteFrameWithFilename:@"boom1.png"];
    [boomAnimation addSpriteFrameWithFilename:@"boom2.png"];
    [boomAnimation addSpriteFrameWithFilename:@"boom3.png"];
    [boomAnimation addSpriteFrameWithFilename:@"boom4.png"];
    [boomAnimation addSpriteFrameWithFilename:@"boom5.png"];
    [boomAnimation setDelayPerUnit:0.1f];
    [boomAnimation setRestoreOriginalFrame:YES];
    [boom runAction:[CCSequence actions:[CCAnimate actionWithAnimation:boomAnimation],[CCCallFunc actionWithTarget:self selector:@selector(restart)], nil]];
}

- (void) releasebullet
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CGPoint pos = [self position];
    if (pos.y > 20 && pos.y < size.height && islife)
    {
        GameMain *p = (GameMain*)[self parent];
        [p releaseenemyBullet:pos.x :pos.y - 30];
    }
}

- (void) onExit
{
    [super onExit];
}

- (void) setType:(short)var
{
    type = var;
}

- (void) restart
{
    [mainbody setVisible:YES];
    [boom setVisible:NO];
    CGSize size = [[CCDirector sharedDirector] winSize];
    [self setPosition:ccp(size.width/4 * type,size.height + 50)];
    islife = YES;
    [mainbody setVisible:YES];
    [boom setVisible:NO];
    [self movestart];
}

- (void) movestart
{
    islife = true;
     type = CCRANDOM_0_1() * 4;
    //贝塞尔曲线移动
    ccBezierConfig bezier2;
    bezier2.controlPoint_1 = CGPointMake([self position].x - 400, 330);
    bezier2.controlPoint_2 = CGPointMake([self position].x + 400, 280);
    bezier2.endPosition = CGPointMake([self position].x, -70);
    CCBezierTo *bezierBy2 = [CCBezierTo actionWithDuration:6 bezier:bezier2];
    
    ccBezierConfig bezier1;
    bezier1.controlPoint_1 = CGPointMake([self position].x + 400, 330);
    bezier1.controlPoint_2 = CGPointMake([self position].x - 400, 280);
    bezier1.endPosition = CGPointMake([self position].x, -70);
    CCBezierTo *bezierBy1 = [CCBezierTo actionWithDuration:6 bezier:bezier1];
    
    switch (type) {
        case 0:
        case 1:
            [self runAction:[CCSequence actions:[CCMoveBy actionWithDuration:6 position:ccp(0,-600)],[CCCallFunc actionWithTarget:self selector:@selector(restart)], nil]];
            break;
        case 2:
            [self runAction:[CCSequence actions:bezierBy2,[CCCallFunc actionWithTarget:self selector:@selector(restart)], nil]];
            break;
        case 3:
            [self runAction:[CCSequence actions:bezierBy1,[CCCallFunc actionWithTarget:self selector:@selector(restart)], nil]];
            break;
        default:
            break;
    }
    
    //设置定时器，释放子弹
    [self schedule:@selector(releasebullet) interval:1.2f];
}

- (bool) getlife
{
    return islife;
}

@end
