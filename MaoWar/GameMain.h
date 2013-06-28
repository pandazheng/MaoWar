//
//  GameMain.h
//  MaoWar
//
//  Created by panda zheng on 13-6-27.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObjHero.h"
#import "GameObjEnemy.h"
#import "GameMark.h"

@interface GameMain : CCLayer {
    CCSprite *blood1;
    CCSprite *blood2;
    CCSprite *blood3;
    CCSprite *bg1;
    CCSprite *bg2;
    short blood;
    CCArray *bullets;
    CCArray *enemybullets;
    bool isreduce;
    bool isover;
    GameObjHero *hero;
    CCSprite *gameover;
    CCArray *enemys;
    GameMark *gamemark;
}

+(CCScene*) scene;
- (void) menuBackCallback;
- (void) releaseheroBullet: (int) x : (int) y;
- (void) setover;
- (void) update: (ccTime) time;
- (void) releaseenemyBullet: (int) x : (int) y;
//检测是否碰撞
- (bool) isCollion: (CGPoint) p1 : (CGPoint) p2 : (int) w1 : (int) h1 : (int) w2 : (int) h2;
- (void) setherohurt;
- (void) resetreduce;


@end
