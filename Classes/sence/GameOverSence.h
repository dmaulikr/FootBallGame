//
//  GameOverSence.h
//  Hockey
//
//  Created by  on 3/10/11.
//  Copyright 2011 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SoundFx.h"

@interface GameOverSence : CCLayer {

	CCMenu *retry;
	CCMenu *leaderboard;
	CCMenu *main;
	
	SoundFx *click;
	SoundFx *people;
	
	CCSprite *star;
	int      star_index;
	
	CCLabelTTF *goalval;
	float scaleFactor;
	
}

+(id) scene;
-(void) retryGame: (id) sender;
-(void) mainMenu: (id) sender;
-(void) leaderBoard: (id) sender;
-(void) star_move: (ccTime) dt;
-(void) people_sound: (ccTime) dt;


@end
