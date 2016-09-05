//
//  GameSence.m
//  Hockey
//
//  Created by  on 3/10/11.
//  Copyright 2011 . All rights reserved.
//

#import "GameSence.h"
#import "GameOverSence.h"
#import "HockeyAppDelegate.h"
#import "MenuSence.h"


@implementation GameSence

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameSence *layer = [GameSence node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

#pragma mark -
#pragma mark Init and dealloc
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	
	if( (self=[super init] )) {
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		//value init
		xscale=1;
		goalnum=0;
		time=30;
		scaleFactor=1;
		arrowflag=FALSE;
		realshoot=FALSE;
		playershootindex=1;
		keeperflag=FALSE;
		middle_ball_position=size.height-size.height/3.5;
		goaltextflag=FALSE;
		width=1;
		keeper_movestep=0.5;
		title_index = 1;
		keeper_normal_index = 1;
		direction_status = FALSE;
		people_index = 1;
		player_normal_index = 1;
		playershootindex = 1;
		goal_status = FALSE;
		star_index = 1;
		button_flag = TRUE;
		
		HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
		if (appDelegate.level == 1) {
			level_time = 0.1;
		}
		if (appDelegate.level == 2) {
			level_time = 0.01;
		}
		if (appDelegate.level == 3) {
			level_time = 0.001;
		}
		for (int i = 1; i <= 9; i++) {
			NSString *str = [NSString stringWithFormat:@"screen%d.png",i];
			CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
			[background setTexture:texture];
		}
		
		arrow_middle=size.width/2-size.width/18;
		arrow_bound=size.width/15;
		
		//real background
		
		people_background = [CCSprite spriteWithFile:@"people_background.png"];
		people_background.position = ccp(size.width/2, size.height*3.6/4);
		[self addChild:people_background];
		
		people = [CCSprite spriteWithFile:@"people1.png"];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			people.position = ccp(size.width/2, size.height*3.55/4);
			people.scale = 1.05;
			people_background.scale = 1.05;
			scaleFactor = 2;
			width = 2;
		}
		else {
			people.position = ccp(size.width/2, size.height*3.5/4);
		}
		[self addChild:people];
		
		star = [CCSprite spriteWithFile:@"star_1.png"];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			star.position = ccp(size.width/2, size.height*3.6/4);
		}
		else {
			star.position = ccp(size.width/2, size.height*3.6/4);
		}
		[self addChild:star];
		star.visible = FALSE;
		
		wall = [CCSprite spriteWithFile:@"wall.png"];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			wall.position = ccp(size.width/2, size.height*3.18/4);
		}
		else {
			wall.position = ccp(size.width/2, size.height*3.15/4);
		}
		[self addChild:wall];
		
		sheet = [CCSprite spriteWithFile:@"sheet.png"];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			sheet.position = ccp(size.width/2, size.height*2.93/4);
		}
		else {
			sheet.position = ccp(size.width/2, size.height*2.9/4);
		}
		[self addChild:sheet];
		sheet.visible = TRUE;
		
		grass = [CCSprite spriteWithFile:@"grass.png"];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			grass.position = ccp(size.width/2, size.height*1.43/4);
		}
		else {
			grass.position = ccp(size.width/2, size.height*1.2/4);
		}
		[self addChild:grass];
		
		door = [CCSprite spriteWithFile:@"door.png"];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			door.position = ccp(size.width*1.065/2, size.height*2.9/4);
		}
		else {
			door.position = ccp(size.width*1.07/2, size.height*2.8/4);
		}
		[self addChild:door];
		
		
		shootsheet = [CCSprite spriteWithFile:@"shootbackground.png"];
		shootsheet.position = ccp(size.width/2,0);
		[self addChild:shootsheet];
		
		//background		
		background = [CCSprite spriteWithFile:@"screen1.png"];
		background.position = ccp(size.width/2, size.height/2);
		[self addChild:background];

		//board
		board = [CCSprite spriteWithFile:@"goal_sheet.png"];
		board.position = ccp(size.width*6.7/8,size.height+size.height/4);
		[self addChild:board];
			
		//time
		timeval = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", time] dimensions:CGSizeMake(60*scaleFactor, 60*scaleFactor) alignment:UITextAlignmentLeft fontName:@"Imagica" fontSize:10*scaleFactor];
		timeval.color = ccWHITE;
		timeval.position = ccp(size.width*4.7/5,size.height+size.height/10);
		[self addChild:timeval];
		
		//goal
		goalval = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", goalnum] dimensions:CGSizeMake(60*scaleFactor, 60*scaleFactor) alignment:UITextAlignmentLeft fontName:@"Imagica" fontSize:10*scaleFactor];
		goalval.color = ccWHITE;
		goalval.position = ccp(size.width*4.7/5,size.height+size.height/10);
		[self addChild:goalval];
		
		//ball
		ball = [CCSprite spriteWithFile:@"shootball.png"];
		ball.position = ccp(size.width/2, size.height*0.8/2);
		ball.visible=FALSE;
		[self addChild:ball];
		ball.scale = 0.8;
		
		
		//keeper normal
		keeper = [CCSprite spriteWithFile:@"keepernormal1.png"];
		keeper.position = ccp(size.width/2, size.height/2+size.height/6);
		keeper.visible=FALSE;
		keeper.scale = 0.8;
		[self addChild:keeper];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			keeper.scale = 1.05;
		}
		
		//keeper left under
		keeperleftunder = [CCSprite spriteWithFile:@"keeperleftunder1.png"];
		keeperleftunder.position = ccp(size.width/2-size.width/14, size.height/2+size.height/6);
		keeperleftunder.visible=FALSE;
		[self addChild:keeperleftunder];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			keeperleftunder.scale = 1.1;
		}
		
		//keeper left up
		keeperleftup = [CCSprite spriteWithFile:@"keeperleftup1.png"];
		keeperleftup.position = ccp(size.width/2-size.width/13, size.height/2+size.height/5);
		keeperleftup.visible=FALSE;
		keeperleftup.scale = 1.2;
		[self addChild:keeperleftup];
		
		//keeper right under
		keeperrightunder = [CCSprite spriteWithFile:@"keeperrightunder1.png"];
		keeperrightunder.position = ccp(size.width/2+size.width/14, size.height/2+size.height/6);
		keeperrightunder.visible=FALSE;
		[self addChild:keeperrightunder];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			keeperrightunder.scale = 1.08;
		}
		
		//keeper right up
		keeperrightup = [CCSprite spriteWithFile:@"keeperrightup1.png"];
		keeperrightup.position = ccp(size.width/2+size.width/13, size.height/2+size.height/5);
		keeperrightup.visible=FALSE;
		keeperrightup.scale = 1.2;
		[self addChild:keeperrightup];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			keeperrightunder.scale = 1.05;
		}
		
		//direction
		direction = [CCSprite spriteWithFile:@"direction1.png"];
		direction.position = ccp(size.width/2, size.height/6);
		direction.visible=FALSE;
		[self addChild:direction];
		
		//arrow
		arrow = [CCSprite spriteWithFile:@"direction1.png"];
		arrow.position = ccp(arrow_middle, size.height/2-size.height/5);
		arrow.visible=FALSE;
		[self addChild:arrow];
						
		//player
		player = [CCSprite spriteWithFile:@"playernormal1.png"];
		player.position = ccp(0,-size.height/5);
		[self addChild:player];
		
		//background move
		[self schedule:@selector(title_change:) interval:0.1];
		
		//main menu button
		CCMenuItemImage *menuitem = [CCMenuItemImage itemFromNormalImage:@"play_menu_n.png" selectedImage:@"play_menu_d.png" target:self selector:@selector(mainmenu:)];
		menu = [CCMenu menuWithItems: menuitem, nil];
		menu.position = ccp(size.width/10,size.height);
		[self addChild:menu];
		menu.visible = FALSE;
		
		title_ball = [CCSprite spriteWithFile:@"title_ball.png"];
		title_ball.position = ccp(size.width*4.1/5, size.height/6.5);
		[self addChild:title_ball];
		
		title = [CCSprite spriteWithFile:@"title_text.png"];
		title.position = ccp(size.width*4/5, size.height/8);
		[self addChild:title];
		
		//sound effect load
		NSBundle *mainBundle = [NSBundle mainBundle];
		end = [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"end" ofType:@"caf"]];	
		goal = [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"goal" ofType:@"caf"]];
		hit = [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"hit" ofType:@"caf"]];
		start= [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"start" ofType:@"caf"]];
		click= [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"click" ofType:@"caf"]];
		timeend= [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"timeend" ofType:@"caf"]];
		logo= [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"logo" ofType:@"caf"]];
		people1= [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"people1" ofType:@"caf"]];
		people2= [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"people2" ofType:@"caf"]];
		call_start= [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"call_start" ofType:@"caf"]];
		
		//goaltext
		goaltext = [CCSprite spriteWithFile:@"goal.png"];
		goaltext.position = ccp(size.width/2, size.height/2);
		goaltext.scale=0.5;
		goaltext.visible=FALSE;
		[self addChild:goaltext];
		goaltext.scale = 1.5;
		
		[logo play];
		[self schedule:@selector(ball_draw:) interval:0.05];
		
		//shoot button
		[self addShootButton];
	}
	return self;
}

- (void) dealloc
{	
	[self unschedule:@selector(sheet_move:)];
	[self unschedule:@selector(title_change:)];
	[self unschedule:@selector(ball_draw:)];
	[self unschedule:@selector(real_start:)];
	[self unschedule:@selector(people_move:)];
	[self unschedule:@selector(star_move:)];
	[self unschedule:@selector(timecount:)];
	[self unschedule:@selector(arrow_move:)];
	[self unschedule:@selector(player_normal_move:)];
	[self unschedule:@selector(player_shoot_move:)];
	[self unschedule:@selector(keeper_normalmove:)];
	[self unschedule:@selector(keeper_leftunder_move:)];
	[self unschedule:@selector(keeper_leftup_move:)];
	[self unschedule:@selector(keeper_rightunder_move:)];
	[self unschedule:@selector(keeper_rightup_move:)];
	[self unschedule:@selector(direction_move:)];
	[self unschedule:@selector(sheet_move:)];
	[self unschedule:@selector(player_shoot_move:)];
	[self unschedule:@selector(shoot_ball_move:)];
	[self unschedule:@selector(restart_shoot:)];
	[self unschedule:@selector(second_ball_move:)];
	[self unschedule:@selector(people_sound_play:)];
	
	[background removeFromParentAndCleanup:TRUE];
	[menu removeFromParentAndCleanup:TRUE];
	[people removeFromParentAndCleanup:TRUE];
	[people_background removeFromParentAndCleanup:TRUE];
	[wall removeFromParentAndCleanup:TRUE];
	[shootsheet removeFromParentAndCleanup:TRUE];
	[star removeFromParentAndCleanup:TRUE];
	
	[end release];
	[goal release];
	[hit release];
	[start release];
	[click release];
	[timeend release];
	[logo release];
	[people1 release];
	[people2 release];
	[call_start release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark Title change

-(void) title_change: (ccTime) dt
{
	if (title_index < 9) 
	{
		title_index++;
	}
	else 
	{
		[self unschedule:@selector(title_change:)];
		[self schedule:@selector(title_end:) interval:0.01];
	}
	
	NSString *str = [NSString stringWithFormat:@"screen%d.png",title_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[background setTexture:texture];
	
	[background visit];
}

-(void) title_end: (ccTime) dt
{
	if (background.opacity > 50) {
		background.opacity -= 25;
	}
	else {
		[self unschedule:@selector(title_end:)];
		[self board_move];
	}
}

-(void) background_move
{
	CGSize size = [[CCDirector sharedDirector] winSize];
	id action = [CCMoveTo actionWithDuration:3 position:ccp(size.width/2,-10)];
	[background runAction:action];
}

-(void) background_xscale: (ccTime) dt
{
	if (xscale<2)
	{
		background.scaleX=xscale;
		xscale=xscale+0.01;
	}
	else
	{
		[self unschedule:@selector(background_xscale:)];
		[self board_move];
	}
}

#pragma mark -
#pragma mark Shoot Button

-(void) addShootButton
{
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	
	SneakyButton *shootbutton = [SneakyButton buttonWithTarget:self Selector:@selector(shoot_start:)];
	shootbutton.isHoldable = YES;
	
	skinshootButton = [SneakyButtonSkinnedBase skinnedButton];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		skinshootButton.position = CGPointMake(screenSize.width/8.6, screenSize.height/19);
	}
	else {
		skinshootButton.position = CGPointMake(screenSize.width/8.6, screenSize.height/18);
	}
	skinshootButton.defaultSprite = [CCSprite spriteWithFile:@"shootbutton_n.png"];
	skinshootButton.pressSprite = [CCSprite spriteWithFile:@"shootbutton_d.png"];
	skinshootButton.button = shootbutton;
	skinshootButton.visible=FALSE;
	[self addChild:skinshootButton];
	
}

#pragma mark -
#pragma mark Board move on first
-(void) board_move
{
	[self schedule:@selector(start_change:) interval:3];
	
	CGSize size = [[CCDirector sharedDirector] winSize];
	id action1 = [CCMoveTo actionWithDuration:1 position:ccp(size.width*6.7/8,size.height-size.height/10)];
	id real_action1 = [CCEaseBounceOut actionWithAction:action1];
	[board runAction:real_action1];
		
	id action5;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		action5 = [CCMoveTo actionWithDuration:1 position:ccp(size.width*4.9/5,size.height-size.height*0.91/6)];
	}
	else {
		action5 = [CCMoveTo actionWithDuration:1 position:ccp(size.width*4.9/5,size.height-size.height*0.99/6)];
	}
	id real_action5 = [CCEaseBounceOut actionWithAction:action5];
	[timeval runAction:real_action5];
	
	id action6;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		action6 = [CCMoveTo actionWithDuration:1 position:ccp(size.width*4.9/5,size.height-size.height*1.12/6)];
	}
	else {
		action6 = [CCMoveTo actionWithDuration:1 position:ccp(size.width*4.9/5,size.height-size.height*1.2/6)];
	}
	id real_action6 = [CCEaseBounceOut actionWithAction:action6];
	[goalval runAction:real_action6];
	
	id action7;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		action7 = [CCMoveTo actionWithDuration:1 position:ccp(size.width/10,size.height-size.height/29)];
	}
	else 
	{
		action7 = [CCMoveTo actionWithDuration:1 position:ccp(size.width/10,size.height-size.height/27)];
	}
	id real_action7 = [CCEaseBounceOut actionWithAction:action7];
	[menu runAction:real_action7];
	
	id action8 = [CCMoveTo actionWithDuration:1 position:ccp(size.width/2,size.height/20)];
	id real_action8 = [CCEaseBounceOut actionWithAction:action8];
	[shootsheet runAction:real_action8];
	
	menu.visible = TRUE;
	background.visible = FALSE;
	sheet.visible = TRUE;
	
	//keeper move start
	[self schedule:@selector(real_start:) interval:1];
	[people2 play];
	[self schedule:@selector(people_sound_play:) interval:6];
	[self schedule:@selector(sheet_move:) interval:2.5];
	
}

-(void) real_start: (ccTime) dt
{
	[self unschedule:@selector(real_start:)];
	
	[self keeper_status_change];
	[self direction_show];
	[self ball_show];
	[self shootbutton_show];
	[self player_move];
	
	[call_start play];
	
	[self schedule:@selector(timecount:) interval:1];
	[self schedule:@selector(keeper_normalmove:) interval:0.01];
	[self schedule:@selector(direction_move:) interval:0.001];
	[self schedule:@selector(people_move:) interval:0.1];
	[self schedule:@selector(star_move:) interval:0.25];
	[self schedule:@selector(player_normal_move:) interval:0.1];
}


-(void) shootbutton_show
{
	skinshootButton.visible=TRUE;
}

-(void) keeper_status_change
{
	keeper.visible=TRUE;
	arrow.visible=FALSE;
}

-(void) direction_show
{
	direction.visible=TRUE;
}

-(void) ball_show
{
	ball.visible=TRUE;
}

#pragma mark -
#pragma mark Main action

-(void) button_click_status_change: (ccTime) dt
{
	button_flag = FALSE;
	[self unschedule:@selector(button_click_status_change:)];
}

-(void) start_change: (ccTime) dt
{
	button_flag = FALSE;
	[self unschedule:@selector(start_change:)];
}
-(void) goaltext_move
{
	CGSize size = [[CCDirector sharedDirector] winSize];
	goaltext.position = ccp(-size.width/2,size.height/2);
	id action1 = [CCMoveTo actionWithDuration:1 position:ccp(size.width*3/2,size.height/2)];
	[goaltext runAction:action1];
}

-(void) sheet_move: (ccTime) dt
{
	if (sheet_index < 5) 
	{
		sheet_index++;
	}
	else 
	{
		sheet_index = 1;
	}
	
	NSString *str = [NSString stringWithFormat:@"banner%d.png",sheet_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[sheet setTexture:texture];
	
	[sheet visit];
}

-(void) ball_draw: (ccTime) dt
{
	title_ball.rotation += 5;
}

-(void) people_move: (ccTime) dt
{
	star.visible = TRUE;
	
	if (people_index < 5) 
	{
		people_index++;
	}
	else 
	{
		people_index = 1;
	}
	
	NSString *str = [NSString stringWithFormat:@"people%d.png",people_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[people setTexture:texture];
	
	[people visit];
}

-(void) star_move: (ccTime) dt
{
	if (star_index < 5) 
	{
		star_index++;
	}
	else 
	{
		star_index = 1;
	}
	
	NSString *str = [NSString stringWithFormat:@"star_%d.png",star_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[star setTexture:texture];
	
	[star visit];
}

-(void) player_move
{
	CGSize size = [[CCDirector sharedDirector] winSize];
	id playeraction = [CCMoveTo actionWithDuration:0.3 position:ccp(size.width/2-size.width/6, size.height*0.995/2)];
	[player runAction:playeraction];
}

- (void) shoot_start: (id) sender
{
	if (button_flag == TRUE) {
		return;
	}
	
	button_flag = TRUE;
	[self schedule:@selector(button_click_status_change:) interval:1];
	
	if (realshoot==FALSE)//shoot start condition
	{		
		realshoot=TRUE;
		keeper_leftunder_index = 1;
		keeper_leftup_index = 1;
		keeper_rightunder_index = 1;
		keeper_rightup_index = 1;
		goal_status = FALSE;
		
		ball.scale = 0.8;

		//direction move stop
		[self unschedule:@selector(direction_move:)];
		
		//player normal stop
		[self unschedule:@selector(player_normal_move:)];
		[self schedule:@selector(player_shoot_move:) interval:0.01];
				
	}
}

-(void) arrow_move: (ccTime) dt
{
}


/*important function*/
-(void) shoot_ball_move: (ccTime) dt
{
	//keeper move stop
	[self unschedule:@selector(keeper_normalmove:)];
	keeper.visible = FALSE;
	
	[self unschedule:@selector(shoot_ball_move:)];
	CGSize size = [[CCDirector sharedDirector] winSize];
	
	//Ball position caculation
	float rate;
	
	rate = direction_index / 20.0f;
	
	xposition = size.width*rate;
	yposition = middle_ball_position;
	/*--------------------------------*/
		
	//Left
	if (xposition < size.width*1.2/4)
	{
		//keeper status change
		[self schedule:@selector(keeper_leftup_move:) interval:0.01];

	}
	
	if ((xposition >=size.width*1.2/4)&&(xposition < size.width*1.25/4))
	{
		//keeper status change
		int val = rand() % 2;
		if (val == 0) {
			[self schedule:@selector(keeper_leftunder_move:) interval:0.01];
		}
		else {
			[self schedule:@selector(keeper_leftup_move:) interval:0.01];
		}
		
	}
	
	if ((xposition >= size.width*1.25/4)&&(xposition < size.width/2))
	{
		//keeper status change

		[self schedule:@selector(keeper_leftunder_move:) interval:0.01];
		
	}
	
	//Right
	if ((xposition >= size.width/2)&&(xposition < size.width*2.73/4))
	{
		//keeper status change
		[self schedule:@selector(keeper_rightunder_move:) interval:0.01];
	}
	
	if ((xposition >= size.width*2.73/4)&&(xposition < size.width*2.77/4))
	{
		//keeper status change
		int val = rand() % 2;
		if (val == 0) {
			[self schedule:@selector(keeper_rightunder_move:) interval:0.01];
		}
		else {
			[self schedule:@selector(keeper_rightup_move:) interval:0.01];
		}
	}
	
	if (xposition >= size.width*2.77/4)
	{
		//keeper status change
		[self schedule:@selector(keeper_rightup_move:) interval:0.01];
	}
}

-(void) second_ball_move: (ccTime) dt
{
	[self unschedule:@selector(second_ball_move:)];
	
	if (goal_status == FALSE) {//no goal
		id ballscale = [CCScaleTo actionWithDuration:0.2 scale:0.8];
		[ball runAction:ballscale];
	}
	else
	{
		id ballscale = [CCScaleTo actionWithDuration:0.2 scale:0.4];
		[ball runAction:ballscale];
	}
	

	id ballaction1 = [CCMoveTo actionWithDuration:0.2 position:ccp(second_ball_position.x, second_ball_position.y)];
	[ball runAction:ballaction1];
	
	if (goaltextflag==TRUE) 
	{
		[self goaltext_move];
		goaltext.visible=TRUE;
		goaltextflag=FALSE;
	}
}

-(void) player_ready
{
	CGSize size = [[CCDirector sharedDirector] winSize];
	
	//Put ball first place
	ball.position = ccp(size.width/2, size.height*0.85/2);
	
	//Put player first place
	player.position = ccp(0,-size.height/5);
	NSString *str = [NSString stringWithFormat:@"playernormal1.png"];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[player setTexture:texture];
}

-(void) restart_shoot: (ccTime) dt
{
	if (realshoot == FALSE)
	{
		//keeper first status change
		keeper.visible = TRUE;
		keeperleftunder.visible = FALSE;
		keeperleftup.visible = FALSE;
		keeperrightunder.visible = FALSE;
		keeperrightup.visible = FALSE;
		
		[self schedule:@selector(keeper_normalmove:) interval:0.01];
		[self unschedule:@selector(player_shoot_move:)];
		[self schedule:@selector(player_normal_move:) interval:0.1];
		
		playershootindex=1;
		[self unschedule:@selector(restart_shoot:)];	
		[self player_ready];
		[self player_move];	
		realshoot=FALSE;
		
		goaltextflag=FALSE;
		
		[call_start play];
		
		[self schedule:@selector(direction_move:) interval:0.001];
	}
}

-(void) direction_move: (ccTime) dt
{
	if ((direction_index < 20) && (direction_status == FALSE))
	{
		direction_index++;
	}
	else if ((direction_index == 20) && (direction_status == FALSE))
	{
		direction_index = 20;
		direction_status = TRUE; //down
	}
	
	if ((direction_index > 1) && (direction_status == TRUE))
	{
		direction_index--;
	}
	else if ((direction_index == 1) && (direction_status == TRUE))
	{
		direction_index = 1;
		direction_status = FALSE; //down
	}
	
	NSString *str = [NSString stringWithFormat:@"direction%d.png",direction_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[direction setTexture:texture];
	
	[direction visit];
}

-(void) ball_trace1//easy
{
	NSLog(@"ball_trace1 call\n");
	CGSize size = [[CCDirector sharedDirector] winSize];
	
	//Ball position caculation
	float rate;
	
	rate = direction_index / 20.0f;
	
	xposition = size.width*rate;
	yposition = middle_ball_position;
	
	id ballscale = [CCScaleTo actionWithDuration:0.3 scale:0.4];
	[ball runAction:ballscale];
	
	//Left
	if (xposition < size.width*1.2/4)
	{
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
		[ball runAction:ballaction];
		
		second_ball_position.x=-size.width/10;
		second_ball_position.y=size.height/3;
		
		[end play];
		[self schedule:@selector(second_ball_move:) interval:0.3];
	}
	
	if ((xposition >=size.width*1.2/4)&&(xposition < size.width*1.25/4))
	{
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, keeper.position.y+size.height/50)];
		[ball runAction:ballaction];
		
		second_ball_position.x=size.width/8;
		second_ball_position.y=size.height/3;
		
		[hit play];
		[self schedule:@selector(second_ball_move:) interval:0.3];
	}
	
	if ((xposition >= size.width*1.25/4)&&(xposition < size.width/2))
	{
		xposition = size.width*0.75/2;
		
		//goal
		goal_status = TRUE;
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
		[ball runAction:ballaction];
		
		second_ball_position.x=size.width/2;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			second_ball_position.y=size.height/2+size.height/6;
		}
		else {
			second_ball_position.y=size.height/2+size.height/6.7;
		}
		
		
		
		[goal play];
		goaltextflag=TRUE;
		[self schedule:@selector(second_ball_move:) interval:0.3];
		
		goalnum++;
		[goalval setString:[NSString stringWithFormat:@"%i",goalnum]];
		
	}
	
	//Right
	if ((xposition >= size.width/2)&&(xposition < size.width*2.73/4))
	{
		xposition = size.width*1.25/2;

		goal_status = TRUE;
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
		[ball runAction:ballaction];
		
		second_ball_position.x=size.width/2;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			second_ball_position.y=size.height/2+size.height/6;
		}
		else {
			second_ball_position.y=size.height/2+size.height/6.7;
		}
		
		[goal play];
		goaltextflag=TRUE;
		[self schedule:@selector(second_ball_move:) interval:0.3];
		
		goalnum++;
		[goalval setString:[NSString stringWithFormat:@"%i",goalnum]];
		
	}
	
	if ((xposition >= size.width*2.73/4)&&(xposition < size.width*2.77/4))
	{
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, keeper.position.y)];
		[ball runAction:ballaction];
		
		second_ball_position.x=size.width*7/8;
		second_ball_position.y=size.height/3;
		
		[hit play];
		[self schedule:@selector(second_ball_move:) interval:0.3];		
	}
	
	if (xposition >= size.width*2.77/4)
	{
		
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
		[ball runAction:ballaction];
		
		second_ball_position.x=size.width + size.width/10;
		second_ball_position.y=size.height/3;
		
		[end play];
		[self schedule:@selector(second_ball_move:) interval:0.3];		
	}
}

-(void) ball_trace2//medium
{
	NSLog(@"ball_trace2 call\n");
	CGSize size = [[CCDirector sharedDirector] winSize];
	
	//Ball position caculation
	float rate;
	
	rate = direction_index / 20.0f;
	
	xposition = size.width*rate;
	yposition = middle_ball_position;
	
	id ballscale = [CCScaleTo actionWithDuration:0.3 scale:0.4];
	[ball runAction:ballscale];
	
	//Left
	if (xposition < size.width*1.2/4)
	{
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
		[ball runAction:ballaction];
		
		second_ball_position.x=-size.width/10;
		second_ball_position.y=size.height/3;
		
		[end play];
		[self schedule:@selector(second_ball_move:) interval:0.3];
	}
	
	if ((xposition >=size.width*1.2/4)&&(xposition < size.width*1.25/4))
	{
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, keeper.position.y+size.height/50)];
		[ball runAction:ballaction];
		
		second_ball_position.x=size.width/8;
		second_ball_position.y=size.height/3;
		
		[hit play];
		[self schedule:@selector(second_ball_move:) interval:0.3];
	}
	
	if ((xposition >= size.width*1.25/4)&&(xposition < size.width/2))
	{
		xposition = size.width*0.75/2;
		//Goal/No
		if (rand()%10 > 5)//goal
		{
			goal_status = TRUE;
			//first ball move
			id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
			[ball runAction:ballaction];
			
			second_ball_position.x=size.width/2;
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{
				second_ball_position.y=size.height/2+size.height/6;
			}
			else {
				second_ball_position.y=size.height/2+size.height/6.7;
			}

			
			
			[goal play];
			goaltextflag=TRUE;
			[self schedule:@selector(second_ball_move:) interval:0.3];
			
			goalnum++;
			[goalval setString:[NSString stringWithFormat:@"%i",goalnum]];
			
		}
		else //no goal
		{
			//keeper move
			id keeperaction = [CCMoveTo actionWithDuration:0.01 position:ccp(xposition, keeper.position.y)];
			[keeper runAction:keeperaction];	
			
			//first ball move
			id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, keeper.position.y+size.height/50)];
			[ball runAction:ballaction];
			
			second_ball_position.x=-rand()%100;
			second_ball_position.y=size.height/2.7;
			
			[end play];
			[self schedule:@selector(second_ball_move:) interval:0.3];
		}		
	}
	
	//Right
	if ((xposition >= size.width/2)&&(xposition < size.width*2.73/4))
	{
		xposition = size.width*1.25/2;
		//Goal/No
		if (rand()%10 > 5)//goal
		{
			goal_status = TRUE;
			//first ball move
			id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
			[ball runAction:ballaction];
			
			second_ball_position.x=size.width/2;
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{
				second_ball_position.y=size.height/2+size.height/6;
			}
			else {
				second_ball_position.y=size.height/2+size.height/6.7;
			}
			
			[goal play];
			goaltextflag=TRUE;
			[self schedule:@selector(second_ball_move:) interval:0.3];
			
			goalnum++;
			[goalval setString:[NSString stringWithFormat:@"%i",goalnum]];
			
		}
		else //no goal
		{
			//keeper move
			id keeperaction = [CCMoveTo actionWithDuration:0.01 position:ccp(xposition, keeper.position.y)];
			[keeper runAction:keeperaction];	
			
			//first ball move
			id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, keeper.position.y+size.height/50)];
			[ball runAction:ballaction];
			
			second_ball_position.x=size.width+rand()%100;
			second_ball_position.y=size.height/2.7;
			
			[end play];
			[self schedule:@selector(second_ball_move:) interval:0.3];
		}		
	}
	
	if ((xposition >= size.width*2.73/4)&&(xposition < size.width*2.77/4))
	{
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, keeper.position.y)];
		[ball runAction:ballaction];
		
		second_ball_position.x=size.width*7/8;
		second_ball_position.y=size.height/3;
		
		[hit play];
		[self schedule:@selector(second_ball_move:) interval:0.3];		
	}
	
	if (xposition >= size.width*2.77/4)
	{

		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
		[ball runAction:ballaction];
		
		second_ball_position.x=size.width + size.width/10;
		second_ball_position.y=size.height/3;
		
		[end play];
		[self schedule:@selector(second_ball_move:) interval:0.3];		
	}
}

-(void) ball_trace3//hard
{
	NSLog(@"ball_trace2 call\n");
	CGSize size = [[CCDirector sharedDirector] winSize];
	
	//Ball position caculation
	float rate;
	
	rate = direction_index / 20.0f;
	
	xposition = size.width*rate;
	yposition = middle_ball_position;
	
	id ballscale = [CCScaleTo actionWithDuration:0.3 scale:0.4];
	[ball runAction:ballscale];
	
	//Left
	if (xposition < size.width*1.2/4)
	{
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
		[ball runAction:ballaction];
		
		second_ball_position.x=-size.width/10;
		second_ball_position.y=size.height/3;
		
		[end play];
		[self schedule:@selector(second_ball_move:) interval:0.3];
	}
	
	if ((xposition >=size.width*1.2/4)&&(xposition < size.width*1.25/4))
	{
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, keeper.position.y+size.height/50)];
		[ball runAction:ballaction];
		
		second_ball_position.x=size.width/8;
		second_ball_position.y=size.height/3;
		
		[hit play];
		[self schedule:@selector(second_ball_move:) interval:0.3];
	}
	
	if ((xposition >= size.width*1.25/4)&&(xposition < size.width/2))
	{
		xposition = size.width*0.75/2;
		//Goal/No
		if (rand()%10 > 8)//goal
		{
			goal_status = TRUE;
			//first ball move
			id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
			[ball runAction:ballaction];
			
			second_ball_position.x=size.width/2;
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{
				second_ball_position.y=size.height/2+size.height/6;
			}
			else {
				second_ball_position.y=size.height/2+size.height/6.7;
			}
			
			
			
			[goal play];
			goaltextflag=TRUE;
			[self schedule:@selector(second_ball_move:) interval:0.3];
			
			goalnum++;
			[goalval setString:[NSString stringWithFormat:@"%i",goalnum]];
			
		}
		else //no goal
		{
			//keeper move
			id keeperaction = [CCMoveTo actionWithDuration:0.01 position:ccp(xposition, keeper.position.y)];
			[keeper runAction:keeperaction];	
			
			//first ball move
			id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, keeper.position.y+size.height/50)];
			[ball runAction:ballaction];
			
			second_ball_position.x=-rand()%100;
			second_ball_position.y=size.height/2.7;
			
			[end play];
			[self schedule:@selector(second_ball_move:) interval:0.3];
		}		
	}
	
	//Right
	if ((xposition >= size.width/2)&&(xposition < size.width*2.73/4))
	{
		xposition = size.width*1.25/2;
		//Goal/No
		if (rand()%10 > 7)//goal
		{
			goal_status = TRUE;
			//first ball move
			id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
			[ball runAction:ballaction];
			
			second_ball_position.x=size.width/2;
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{
				second_ball_position.y=size.height/2+size.height/6;
			}
			else {
				second_ball_position.y=size.height/2+size.height/6.7;
			}
			
			[goal play];
			goaltextflag=TRUE;
			[self schedule:@selector(second_ball_move:) interval:0.3];
			
			goalnum++;
			[goalval setString:[NSString stringWithFormat:@"%i",goalnum]];
			
		}
		else //no goal
		{
			//keeper move
			id keeperaction = [CCMoveTo actionWithDuration:0.01 position:ccp(xposition, keeper.position.y)];
			[keeper runAction:keeperaction];	
			
			//first ball move
			id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, keeper.position.y+size.height/50)];
			[ball runAction:ballaction];
			
			second_ball_position.x=size.width+rand()%100;
			second_ball_position.y=size.height/2.7;
			
			[end play];
			[self schedule:@selector(second_ball_move:) interval:0.3];
		}		
	}
	
	if ((xposition >= size.width*2.73/4)&&(xposition < size.width*2.77/4))
	{
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, keeper.position.y)];
		[ball runAction:ballaction];
		
		second_ball_position.x=size.width*7/8;
		second_ball_position.y=size.height/3;
		
		[hit play];
		[self schedule:@selector(second_ball_move:) interval:0.3];		
	}
	
	if (xposition >= size.width*2.77/4)
	{
		
		//first ball move
		id ballaction = [CCMoveTo actionWithDuration:0.3 position:ccp(xposition, yposition)];
		[ball runAction:ballaction];
		
		second_ball_position.x=size.width + size.width/10;
		second_ball_position.y=size.height/3;
		
		[end play];
		[self schedule:@selector(second_ball_move:) interval:0.3];		
	}
}

#pragma mark -
#pragma mark keeper action

-(void) keeper_normalmove: (ccTime) dt
{
	CGSize size = [[CCDirector sharedDirector] winSize];
	keeper.position = ccp(size.width/2, size.height/2+size.height/6);
	if (keeper_normal_index < 9) 
	{
		keeper_normal_index++;
	}
	else 
	{
		keeper_normal_index = 1;
	}
	
	ball.scale = 0.8;
	ball.position = ccp(size.width/2, size.height*0.85/2);
	
	NSString *str = [NSString stringWithFormat:@"keepernormal%d.png",keeper_normal_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[keeper setTexture:texture];
	
	[keeper visit];
}

-(void) keeper_leftunder_move: (ccTime) dt
{
	keeperleftunder.visible = TRUE;
	if (keeper_leftunder_index < 16) 
	{
		keeper_leftunder_index++;
		
		if (keeper_leftunder_index == 4) {
			HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
			if (appDelegate.level == 1) {
				[self ball_trace1];
			}
			if (appDelegate.level == 2) {
				[self ball_trace2];
			}
			if (appDelegate.level == 3) {
				[self ball_trace3];
			}
		}
	}
	else 
	{
		keeperleftunder.visible = FALSE;
		realshoot = FALSE;
		[self unschedule:@selector(keeper_leftunder_move:)];
		
		//restart 
		[self schedule:@selector(restart_shoot:) interval:0.01];
	}
	
	NSString *str = [NSString stringWithFormat:@"keeperleftunder%d.png",keeper_leftunder_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[keeperleftunder setTexture:texture];
	
	[keeperleftunder visit];
}

-(void) keeper_leftup_move: (ccTime) dt
{
	keeperleftup.visible = TRUE;
	
	if (keeper_leftup_index < 20) 
	{
		keeper_leftup_index++;
		if (keeper_leftup_index == 4) {
			HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
			if (appDelegate.level == 1) {
				[self ball_trace1];
			}
			if (appDelegate.level == 2) {
				[self ball_trace2];
			}
			if (appDelegate.level == 3) {
				[self ball_trace3];
			}
		}
	}
	else 
	{
		keeperleftup.visible = FALSE;
		realshoot = FALSE;
		[self unschedule:@selector(keeper_leftup_move:)];
		//restart 
		[self schedule:@selector(restart_shoot:) interval:0.01];
	}
	
	NSString *str = [NSString stringWithFormat:@"keeperleftup%d.png",keeper_leftup_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[keeperleftup setTexture:texture];
	
	[keeperleftup visit];
}

-(void) keeper_rightunder_move: (ccTime) dt
{
	keeperrightunder.visible = TRUE;
	if (keeper_rightunder_index < 16) 
	{
		keeper_rightunder_index++;
		if (keeper_rightunder_index == 4) {
			HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
			if (appDelegate.level == 1) {
				[self ball_trace1];
			}
			if (appDelegate.level == 2) {
				[self ball_trace2];
			}
			if (appDelegate.level == 3) {
				[self ball_trace3];
			}
		}
	}
	else 
	{
		keeperrightunder.visible = FALSE;
		realshoot = FALSE;
		[self unschedule:@selector(keeper_rightunder_move:)];
		//restart 
		[self schedule:@selector(restart_shoot:) interval:0.01];
	}
	
	NSString *str = [NSString stringWithFormat:@"keeperrightunder%d.png",keeper_rightunder_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[keeperrightunder setTexture:texture];
	
	[keeperrightunder visit];
}

-(void) keeper_rightup_move: (ccTime) dt
{
	keeperrightup.visible = TRUE;
	if (keeper_rightup_index < 20) 
	{
		keeper_rightup_index++;
		if (keeper_rightup_index == 4) {
			HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
			if (appDelegate.level == 1) {
				[self ball_trace1];
			}
			if (appDelegate.level == 2) {
				[self ball_trace2];
			}
			if (appDelegate.level == 3) {
				[self ball_trace3];
			}
		}
	}
	else 
	{
		keeperrightup.visible = FALSE;
		realshoot = FALSE;
		[self unschedule:@selector(keeper_rightup_move:)];
		//restart 
		[self schedule:@selector(restart_shoot:) interval:0.01];
	}
	
	NSString *str = [NSString stringWithFormat:@"keeperrightup%d.png",keeper_rightup_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[keeperrightup setTexture:texture];
	
	[keeperrightup visit];
}

#pragma mark -
#pragma mark Player Status
-(void) player_normal_move: (ccTime) dt
{
	if (player_normal_index < 2) 
	{
		player_normal_index++;
	}
	else 
	{
		player_normal_index = 1;
	}
	
	NSString *str = [NSString stringWithFormat:@"playernormal%d.png",player_normal_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[player setTexture:texture];
	
	[player visit];
}

-(void) player_shoot_move: (ccTime) dt
{
	if (playershootindex < 16)
	{
		playershootindex++;
		if (playershootindex == 4) {
			//sound start
			[start play];
			[self schedule:@selector(shoot_ball_move:) interval:0.01];
		}
	}
	else 
	{
		[self unschedule:@selector(player_shoot_move:)];
	}
	
	NSString *str = [NSString stringWithFormat:@"playershoot%i.png",playershootindex];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[player setTexture:texture];
	
	[player visit];
}

#pragma mark -
#pragma mark Sence change
- (void) mainmenu: (id) sender 
{
	[click play];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[MenuSence scene]]] ;	
}

-(void) timecount: (ccTime) dt
{
	time--;
	if (time < 10)
	{
		[timeend play];
		timeval.color = ccRED;
	}
	
	if (time<1) 
	{
		HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
		appDelegate.num=goalnum;
		
		[self unschedule:@selector(timecount:)];
		[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[GameOverSence scene]]] ;		
	}
	else 
	{
		[timeval setString:[NSString stringWithFormat:@"%i",time]];
	}	
}

#pragma mark -
#pragma mark People sound
-(void) people_sound_play: (ccTime) dt
{
	[people2 play];
}

@end
