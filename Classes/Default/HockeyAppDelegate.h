//
//  HockeyAppDelegate.h
//  Hockey
//
//  Created by  on 3/10/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCenterManager.h"
#import "GCViewController.h"
#import <GameKit/GameKit.h>
#import "AppSpecificValues.h"

@class RootViewController;

@interface HockeyAppDelegate : NSObject <UIApplicationDelegate,
	GameCenterManagerDelegate, GKLeaderboardViewControllerDelegate
	,GKAchievementViewControllerDelegate> {
		
	UIWindow			*window;
	RootViewController	*viewController;
	
	IBOutlet GCViewController* gcviewController;
	GameCenterManager* gameCenterManager;
	NSString* currentLeaderBoard;
	
	int num;
	int level;//1 easy,2 medium, 3 hard
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) GameCenterManager* gameCenterManager;
@property (nonatomic, retain) NSString* currentLeaderBoard;
@property (readwrite) int num;
@property (nonatomic, readwrite) int level;

- (void) addOne;
- (void) submitScore:(int)nScore;
- (void) showLeaderboard;
- (void) showAchievements;

- (void) abrirLDB;
- (void) abrirACHV;
- (void) initGameCenter;

@end
