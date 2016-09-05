//
//  LogoSence.h
//  SpaceTravel
//
//  Created by  on 2011 03 011
//  Copyright . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SoundFx.h"

typedef enum
{
	ParticleTypeExplosion = 0,
	ParticleTypeFire,
	ParticleTypeFireworks,
	ParticleTypeFlower,
	ParticleTypeGalaxy,
	ParticleTypeMeteor,
	ParticleTypeRain,
	ParticleTypeSmoke,
	ParticleTypeSnow,
	ParticleTypeSpiral,
	ParticleTypeSun,
	
	ParticleTypes_MAX,
} ParticleTypes;


@interface LogoSence : CCLayer {
	
	CCSprite *footballtitle;
	CCSprite *challege;
	CCSprite *ball;
	
	CCMenu	 *keeper;
	int width,height;
	ParticleTypes particleType;
	
	SoundFx *keepermove_sound;
	
}

+(id)scene;
-(void) loadmenu: (ccTime) dt;
-(void) ball_draw: (ccTime) dt;
-(void) keeper_action: (id) sender;

@end
