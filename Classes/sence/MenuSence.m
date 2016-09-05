//
//  MenuSence.m
//  Hockey
//
//  Created by  on 3/10/11.
//  Copyright 2011 . All rights reserved.
//

#import "MenuSence.h"
#import "HockeyAppDelegate.h"
#import "HighScoreSence.h"
#import "LevelSelectSence.h"

@implementation MenuSence

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuSence *layer = [MenuSence node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	
	if( (self=[super init] )) {
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		button_click = TRUE;
		
		//background
		background = [CCSprite spriteWithFile:@"mainmenu_title.png"];
		background.position = ccp(size.width/2, size.height/2);
		[self addChild:background];
		
		CCSprite *title_up = [CCSprite spriteWithFile:@"title_up.png"];
		title_up.position = ccp(size.width/2, size.height*1.97/2);
		[self addChild:title_up];
		title_up.visible = FALSE;
		
		CCSprite *title_down = [CCSprite spriteWithFile:@"title_down.png"];
		title_down.position = ccp(size.width/2, size.height*0.05/2);
		[self addChild:title_down];
		title_down.visible = FALSE;
		
		//play button
		CCMenuItemImage *playbutton = [CCMenuItemImage itemFromNormalImage:@"playbutton_n.png" selectedImage:@"playbutton_d.png" target:self selector:@selector(startgame:)];
		play = [CCMenu menuWithItems: playbutton, nil];
		play.position = ccp(size.width*4.4/5, size.height*4.6/5);	
		[self addChild:play];
		
		playbutton.position = ccp(playbutton.position.x, playbutton.position.y-150);
		id dropTitle = [CCMoveBy actionWithDuration:1.5 position:ccp(0,150)];
		id easeDrop = [CCEaseBounceOut actionWithAction:dropTitle];
		[playbutton runAction:easeDrop];
		
		//score button
		CCMenuItemImage *scorebutton = [CCMenuItemImage itemFromNormalImage:@"leader_1.png" selectedImage:@"leader_2.png" target:self selector:@selector(loadscore:)];
		score = [CCMenu menuWithItems: scorebutton, nil];
		score.position = ccp(size.width*0.8/5, size.height*0.2/4);	
		[self addChild:score];
		
		scorebutton.position = ccp(scorebutton.position.x, scorebutton.position.y+150);
		dropTitle = [CCMoveBy actionWithDuration:1.5 position:ccp(0,-150)];
		easeDrop = [CCEaseBounceOut actionWithAction:dropTitle];
		[scorebutton runAction:easeDrop];
		
		
		/*add content*/
		
		//part background
		part_bg = [CCSprite spriteWithFile:@"bg_3.png"];
		part_bg.position = ccp(size.width*2.5/2, size.height/2);
		[self addChild:part_bg];
		
		//easy button
		CCMenuItemImage *easyitem = [CCMenuItemImage itemFromNormalImage:@"easy_button_n.png" selectedImage:@"easy_button_d.png" target:self selector:@selector(easyGame:)];
		easy = [CCMenu menuWithItems: easyitem, nil];
		easy.position = ccp(size.width*2.3/2, size.height*7/10);		
		[self addChild:easy];
				
		//medium button
		CCMenuItemImage *mediumitem = [CCMenuItemImage itemFromNormalImage:@"medium_button_n.png" selectedImage:@"medium_button_d.png" target:self selector:@selector(mediumGame:)];
		medium = [CCMenu menuWithItems: mediumitem, nil];
		medium.position = ccp(size.width*2.3/2, size.height*5.5/10);		
		[self addChild:medium];
		
		//hard button
		CCMenuItemImage *harditem = [CCMenuItemImage itemFromNormalImage:@"hard_button_n.png" selectedImage:@"hard_button_d.png" target:self selector:@selector(hardGame:)];
		hard = [CCMenu menuWithItems: harditem, nil];
		hard.position = ccp(size.width*2.3/2, size.height*4/10);		
		[self addChild:hard];
		
		//mainmenu button
		CCMenuItemImage *mainitem = [CCMenuItemImage itemFromNormalImage:@"mainmenu_n.png" selectedImage:@"mainmenu_d.png" target:self selector:@selector(mainMenu:)];
		main = [CCMenu menuWithItems: mainitem, nil];
		main.position = ccp(size.width*2.3/2, size.height*1.6/7);		
		[self addChild:main];
		
		NSBundle *mainBundle = [NSBundle mainBundle];
		click = [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"click" ofType:@"caf"]];
	}
	return self;
}

- (void) startgame: (id) sender
{
	if (button_click == TRUE) {
		[click play];
		[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[LevelSelectSence scene]]] ;
	}
}

- (void) loadscore: (id) sender
{
	if (button_click == TRUE) {
		[click play];
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		id bg_action = [CCMoveTo actionWithDuration:0.25 position:ccp(size.width*1.7/2, size.height/2)];
		id easy_action = [CCMoveTo actionWithDuration:0.5 position:ccp(size.width*1.7/2, size.height*7/10)];		
		id medium_action = [CCMoveTo actionWithDuration:0.5 position:ccp(size.width*1.7/2, size.height*5.5/10)];
		id hard_action = [CCMoveTo actionWithDuration:0.5 position:ccp(size.width*1.7/2, size.height*4/10)];
		id main_action = [CCMoveTo actionWithDuration:0.5 position:ccp(size.width*1.7/2, size.height*1.6/7)];		
		
		[part_bg runAction:bg_action];
		[easy runAction:easy_action];
		[medium runAction:medium_action];
		[hard runAction:hard_action];
		[main runAction:main_action];
		
		button_click = FALSE;
	}
}

- (void) easyGame: (id) sender
{
	[click play];
	HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
	appDelegate.level = 1;
	[appDelegate abrirLDB];
}

- (void) mediumGame: (id) sender
{
	[click play];
	HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
	appDelegate.level = 2;
	[appDelegate abrirLDB];
}

- (void) hardGame: (id) sender
{
	[click play];
	HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
	appDelegate.level = 3;
	[appDelegate abrirLDB];
}

- (void) mainMenu: (id) sender
{
	if (button_click == FALSE) {
		[click play];
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		id bg_action = [CCMoveTo actionWithDuration:0.5 position:ccp(size.width*2.5/2, size.height/2)];
		id easy_action = [CCMoveTo actionWithDuration:0.25 position:ccp(size.width*2.3/2, size.height*7/10)];		
		id medium_action = [CCMoveTo actionWithDuration:0.25 position:ccp(size.width*2.3/2, size.height*5.5/10)];
		id hard_action = [CCMoveTo actionWithDuration:0.25 position:ccp(size.width*2.3/2, size.height*4/10)];
		id main_action = [CCMoveTo actionWithDuration:0.25 position:ccp(size.width*2.3/2, size.height*1.6/7)];		
		
		[part_bg runAction:bg_action];
		[easy runAction:easy_action];
		[medium runAction:medium_action];
		[hard runAction:hard_action];
		[main runAction:main_action];
		
		button_click = TRUE;
	}
}
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[click release];
	[background removeFromParentAndCleanup:TRUE];
	[super dealloc];
}

@end
