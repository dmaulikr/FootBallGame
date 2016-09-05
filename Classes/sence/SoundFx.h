//
//  SoundFx.h
//  OneToNine
//
//  Created by kim hyok chol on 2011 03 011
//  Copyright OSD Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface SoundFx : NSObject {
    SystemSoundID _soundID;
}

+ (id)soundFxWithContentsOfFile:(NSString *)aPath;
- (id)initWithContentsOfFile:(NSString *)path;
- (void)play;

@end
