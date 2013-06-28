//
//  GameMenu.h
//  MaoWar
//
//  Created by panda zheng on 13-6-26.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameMenu : CCLayer {
    bool issound;
    
    CCMenuItemImage *soundItem;

}

+(CCScene*) scene;
- (void) menuNewGameCallback: (id) sender;
- (void) menuContinueCallback: (id) sender;
- (void) menuAboutCallback: (id) sender;
- (void) menuSoundCallback: (id) sender;

@end
