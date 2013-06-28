//
//  GameHeroBullet.h
//  MaoWar
//
//  Created by panda zheng on 13-6-28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameHeroBullet : CCNode {
    bool isvisable;
}

- (void) setIsVisable;
- (void) setIsNotVisable;
- (bool) getIsvisable;

@end
