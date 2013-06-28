//
//  GameMain.m
//  MaoWar
//
//  Created by panda zheng on 13-6-27.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameMain.h"
#import "GameMenu.h"
#import "GameAbout.h"
#import "GameObjHero.h"
#import "GameObjEnemy.h"
#import "GameHeroBullet.h"
#import "GameEnemyBullet.h"

@implementation GameMain

+ (CCScene*) scene
{
    CCScene *scene = [CCScene node];
    GameMain *layer = [GameMain node];
    [scene addChild:layer];
    return scene;
}

- (void) releaseenemyBullet:(int) x :(int) y
{
    //遍历子弹数组，不在使用的子弹释放
    for (int i = 0 ; i < [enemybullets capacity] ; i++)
    {
        if (![(GameEnemyBullet*)[enemybullets objectAtIndex:i] getIsvisable])
        {
            //设置位置，并设置为显示
            [(GameEnemyBullet*)[enemybullets objectAtIndex:i] setPosition:ccp(x,y)];
            [(GameEnemyBullet*)[enemybullets objectAtIndex:i] setIsVisable];
            break;
        }
    }
}

- (void) releaseheroBullet: (int) x : (int) y
{
    //遍历子弹数组，不在使用的子弹释放
    for (int i = 0 ; i < [bullets capacity] ; i++)
    {
        if (![(GameHeroBullet*)[bullets objectAtIndex:i] getIsvisable])
        {
            //设置位置，并设置为显示
            [(GameHeroBullet*)[bullets objectAtIndex:i] setPosition:ccp(x,y)];
            [(GameHeroBullet*)[bullets objectAtIndex:i] setIsVisable];
            break;
        }
    }
}

- (id) init
{
    self = [super init];
    if (self)
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //创建背景
        bg1 = [CCSprite spriteWithFile:@"bg.png"];
        [bg1 setScale:0.5];
        bg2 = [CCSprite spriteWithFile:@"bg.png"];
        [bg2 setScale:0.5];
        [bg1 setAnchorPoint:ccp(0,0)];
        [bg2 setAnchorPoint:ccp(0,0)];
        [bg1 setPosition:ccp(0,size.height)];
        [self addChild:bg1 z:0];
        [self addChild:bg2 z:0];
        
        //创建主角
        hero = [[GameObjHero alloc] init];
        [hero setPosition:ccp(size.width/2,-50)];
        [hero setScale:0.5];
        [self addChild:hero z:2 tag:1];
        [hero runAction:[CCMoveBy actionWithDuration:0.5 position:ccp(0,150)]];
        
        //创建敌人
        enemys = [CCArray array];
        for (int i = 0 ; i < 3 ; i++)
        {
            int type = i + 1;
            GameObjEnemy *enemy = [[GameObjEnemy alloc] init];
            [enemy setPosition:ccp(size.width/4 * type,size.height + 50)];
            [enemy setScale:0.5];
            [enemy setType:type];
            [enemys addObject:enemy];
            [self addChild:enemy z:1];
            [enemy movestart];
        }
        [enemys retain];
  
        //创建血量ui
        blood = 3;
        CCSpriteBatchNode *ui = [CCSpriteBatchNode batchNodeWithFile:@"cat.png"];
        blood1 = [CCSprite spriteWithTexture:[ui texture]];
        [blood1 setPosition:ccp(20,size.height - 20)];
        [blood1 setScale:0.2];
        [ui addChild:blood1];
        blood2 = [CCSprite spriteWithTexture:[ui texture]];
        [blood2 setPosition:ccp(50,size.height - 20)];
        [blood2 setScale:0.2];
        [ui addChild:blood2];
        blood3 = [CCSprite spriteWithTexture:[ui texture]];
        [blood3 setPosition:ccp(80,size.height - 20)];
        [blood3 setScale:0.2];
        [ui addChild:blood3];
        [self addChild:ui z:4];
        
        //初始化主角子弹
        bullets = [CCArray array];
        for (int i = 0 ; i < 10 ; i++)
        {
            GameHeroBullet *mybullet = [[GameHeroBullet alloc] init];
            [mybullet setIsNotVisable];
            [mybullet setScale:0.5];
            [bullets addObject:mybullet];
            [self addChild:mybullet z:3];
        }
        [bullets retain];
        
        //初始化敌人子弹
        enemybullets = [CCArray array];
        for (int i = 0 ; i < 10 ; i++)
        {
            GameEnemyBullet *mybullet = [[GameEnemyBullet alloc] init];
            [mybullet setIsNotVisable];
            [mybullet setScale:0.5];
            [enemybullets addObject:mybullet];
            [self addChild:mybullet z:3];
        }
        [enemybullets retain];
        gamemark = [[GameMark alloc] init];
        [self addChild:gamemark z:4];
        
        //初始化游戏结束反弹板及按钮
        gameover = [CCSprite spriteWithFile:@"gameover.png"];
        [gameover setAnchorPoint:ccp(0.5,0.5)];
        [gameover setPosition:ccp(size.width/2,size.height/2 + 70)];
        [gameover setVisible:NO];
        [gameover setScale:0.5];
        [self addChild:gameover z:5];
        
        //返回按钮
        CCMenuItemImage *pCloseItem = [CCMenuItemImage itemWithNormalImage:@"back.png" selectedImage:@"back.png" target:self selector:@selector(menuBackCallback)];
        [pCloseItem setPosition:ccp(size.width/2,size.height/2 - 50)];
        [pCloseItem setScale:0.5];
        CCMenu *pMenu = [CCMenu menuWithItems:pCloseItem, nil];
        [pMenu setPosition:CGPointZero];
        [self addChild:pMenu z:5 tag:25];
        [pMenu setVisible:NO];
        [pMenu setEnabled:NO];
        isreduce = NO;
        isover = NO;
        [self scheduleUpdate];
    }
    
    return self;
}

- (void) menuBackCallback
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSplitCols transitionWithDuration:0.5 scene:[GameMenu scene]]];
}

- (bool) isCollion:(CGPoint)p1 :(CGPoint)p2 :(int)w1 :(int)h1 :(int)w2 :(int)h2
{
    //判断两个矩形是否碰撞
    if (abs(p1.x - p2.x) < w1 + w2 && abs(p1.y - p2.y) < h1 + h2)
    {
        return YES;
    }
    
    return NO;
}

- (void) setover
{
    //设置游戏结束
    CCMenu *pMenu = (CCMenu*)[self getChildByTag:25];
    [pMenu setVisible:YES];
    [pMenu setEnabled:YES];
    [gameover setVisible:YES];
    [gameover setScale:0];
    [pMenu setScale:0];
    [pMenu runAction:[CCScaleTo actionWithDuration:0.5 scale:1]];
    [gameover runAction:[CCScaleTo actionWithDuration:0.5 scale:0.5]];
}

- (void) setherohurt
{
    //主角受伤，减血
    [hero stopAllActions];
    switch (blood) {
        case 3:
            [blood1 setVisible:NO];
            blood--;
            break;
        case 2:
            [blood2 setVisible:NO];
            blood--;
            break;
        case 1:
            [blood3 setVisible:NO];
            blood--;
            break;
        case 0:
            if (!isover)
            {
                isover = YES;
                [self setover];
            }
            break;
    }
    CCActionInterval *action = [CCBlink actionWithDuration:5 blinks:10];
    [hero runAction:action];
    [self schedule:@selector(resetreduce) interval:5.0f];
    isreduce = true;
}

- (void) resetreduce
{
    isreduce = NO;
}

- (void) update:(ccTime)time
{
    //背景移动逻辑
    [bg1 setPosition:ccp([bg1 position].x,[bg1 position].y -2)];
    [bg2 setPosition:ccp([bg1 position].x,[bg2 position].y -2)];
    if ([bg2 position].y < 0)
    {
        float temp = [bg2 position].y + 480;
        [bg1 setPosition:ccp([bg2 position].x,temp)];
    }
    if ([bg1 position].y < 0)
    {
        float temp = [bg1 position].y + 480;
        [bg2 setPosition:ccp([bg1 position].x,temp)];
    }
    
    CGPoint hpos = [hero position];
    //敌人和子弹碰撞检测
    for (int i = 0 ; i < 3 ; i++)
    {
        GameObjEnemy *enemy = (GameObjEnemy*)[enemys objectAtIndex:i];
        CGPoint epos = [enemy position];
        if ([enemy getlife])
        {
            if ([enemy getlife])
            {
                for (int i = 0 ; i < 10 ; i++)
                {
                    if ([(GameHeroBullet*)[bullets objectAtIndex:i] getIsvisable])
                    {
                        if ([self isCollion:[(GameHeroBullet*)[bullets objectAtIndex:i] position] :epos :5 :13 :21 :28])
                        {
                            [enemy setdie];
                            [gamemark addnumber:200];
                            break;
                        }
                    }
                }
            }
        }
        
        //主角与敌人子弹碰撞,同时销毁
        if (!isreduce && [enemy getlife] && [self isCollion:hpos :epos :21 :22.5 :21 :28])
        {
            [enemy setdie];
            [self setherohurt];
        }
    }
    
    //主角与敌人子弹碰撞
    if (!isreduce)
    {
        for (int i = 0 ; i < 10 ; i++)
        {
            if ([self isCollion:hpos :[(GameEnemyBullet*)[enemybullets objectAtIndex:i] position] :21 :22.5 :5 :13])
            {
                [self setherohurt];
            }
        }
    }
}

@end
