//
//  MenuSence.h
//  Hockey
//
//  Created by  on 3/10/11.
//  Copyright 2011 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SoundFx.h"

@interface MenuSence : CCLayer {
	
	CCSprite *background;
	CCMenu *play;
	CCMenu *score;
	SoundFx *click;
	
	CCSprite *part_bg;
	CCMenu *easy;
	CCMenu *medium;
	CCMenu *hard;
	CCMenu *main;
	
	BOOL   button_click;
}

+(id) scene;
- (void) startgame: (id) sender;
- (void) loadscore: (id) sender;

-(void) easyGame: (id) sender;
-(void) mediumGame: (id) sender;
-(void) hardGame: (id) sender;
-(void) mainMenu: (id) sender;

@end
