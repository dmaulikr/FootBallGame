//
//  GameSence.h
//  Hockey
//
//  Created by  on 3/10/11.
//  Copyright 2011 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SoundFx.h"

// SneakyInput headers
#import "ColoredCircleSprite.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"

#import "SneakyExtensions.h"


@interface GameSence : CCLayer {
	
	//background
	CCSprite *background,*gamebackground,*board;
	int		 title_index;
	CCSprite *direction;
	int		 direction_index;
	BOOL	 direction_status;//false: up true: down
	CCSprite *player;
	int		 player_normal_index;
	int		 player_shoot_index;
	CCSprite *example;
	
	//ball
	CCSprite *ball;
	float middle_ball_position;
	CGPoint second_ball_position;
	
	//keeper
	CCSprite *keeper;
	int		 keeper_normal_index;
	
	CCSprite *keeperleftunder;
	int		 keeper_leftunder_index;
	
	CCSprite *keeperleftup;
	int		 keeper_leftup_index;
	
	CCSprite *keeperrightunder;
	int		 keeper_rightunder_index;
	
	CCSprite *keeperrightup;
	int		 keeper_rightup_index;
	
	bool keeperflag;
	float keeper_movestep;
	
	//title
	CCLabelTTF *timeremain;
	CCLabelTTF *goals;
	CCSprite   *goalicon;
	CCLabelTTF *timeval;
	CCLabelTTF *goalval;
	CCMenuItemImage *shoot;
	
	SneakyButtonSkinnedBase* skinshootButton;
	
	//Arrow 
	CCSprite *arrow;
	bool arrowflag;
	float arrow_middle;
	float arrow_bound;
	
	int scaleFactor;
	int time;
	int goalnum;
	float xscale;
	
	//sound
	SoundFx *end;
	SoundFx *goal;
	SoundFx *hit;
	SoundFx *start;
	SoundFx *click;
	SoundFx *timeend;
	SoundFx *logo;
	SoundFx *people1;
	SoundFx *people2;
	SoundFx *call_start;
	
	
	//Real shoot
	bool realshoot;
	
	//player shoot index;
	int playershootindex;
	
	//Goal text
	CCSprite *goaltext;
	bool goaltextflag;

	//iPhone,iPad
	int width;
	
	CCMenu *menu;
	
	//real background
	CCSprite *people;
	int		 people_index;
	CCSprite *people_background;
	CCSprite *wall;
	CCSprite *sheet;
	int		 sheet_index;
	CCSprite *grass;
	CCSprite *door;
	CCSprite *shootsheet;
	CCSprite *star;
	int      star_index;
	
	CCSprite *title_ball;
	CCSprite *title;
	
	BOOL goal_status;
	
	float xposition,yposition;
	
	float level_time;
	//false : no click true : click
	BOOL  button_flag;
}

+(id) scene;
-(void) addShootButton;
-(void) background_move;
-(void) goaltext_move;

-(void) title_change: (ccTime) dt;
-(void) title_end: (ccTime) dt;

-(void) ball_draw: (ccTime) dt;
-(void) board_move;
-(void) background_xscale: (ccTime) dt;
-(void) real_start: (ccTime) dt;
-(void) keeper_status_change;
-(void) direction_show;
-(void) ball_show;
-(void) shootbutton_show;
-(void) player_move;
-(void) people_move: (ccTime) dt;
-(void) star_move: (ccTime) dt;

-(void) shoot_start: (id) sender;
-(void) timecount: (ccTime) dt;
-(void) arrow_move: (ccTime) dt;

-(void) player_normal_move: (ccTime) dt;
-(void) player_shoot_move: (ccTime) dt;

-(void) keeper_normalmove: (ccTime) dt;
-(void) keeper_leftunder_move: (ccTime) dt;
-(void) keeper_leftup_move: (ccTime) dt;
-(void) keeper_rightunder_move: (ccTime) dt;
-(void) keeper_rightup_move: (ccTime) dt;

-(void) direction_move: (ccTime) dt;
-(void) sheet_move: (ccTime) dt;

-(void) player_shoot_move: (ccTime) dt;
-(void) shoot_ball_move: (ccTime) dt;
-(void) restart_shoot: (ccTime) dt;
-(void) player_ready;
-(void) second_ball_move: (ccTime) dt;

-(void) people_sound_play: (ccTime) dt;

-(void) button_click_status_change: (ccTime) dt;
-(void) start_change: (ccTime) dt;

-(void) ball_trace1;
-(void) ball_trace2;
-(void) ball_trace3;

@end
