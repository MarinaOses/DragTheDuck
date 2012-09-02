//
//  MGOpenALSoundController.h
//  MyGame
//
//  Created by Marina Osés Merino on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

#import "MGAudioSessionSupport.h"
#import "MGOpenALSupport.h"

//ALC: Audio Library Context
@interface MGOpenALSoundController : NSObject {
    ALCdevice *openALDevice;
    ALCcontext *openALContext;
    
    ALuint outputSourceDuck;
    ALuint outputSourceKilledDuck;
    ALuint outputSourceBrokenEgg;
    ALuint outputSourceFriedEgg;
    ALuint outputSourceBackground;
    
    ALuint outputBufferDuck;
    ALuint outputBufferKilledDuck;
    ALuint outputBufferBrokenEgg;
    ALuint outputBufferFriedEgg;
    ALuint outputBufferBackground;
    
    void *duckPCMData;
    void *killedDuckPCMData;
    void *brokenEggPCMData;
    void *friedEggPCMData;
    void *backgroundPCMData;
}

+ (MGOpenALSoundController *) sharedSoundController;
- (void)initOpenAL;
- (void)playDuck;
- (void)playKilledDuck;
- (void)playBrokenEgg;
- (void)playFriedEgg;
- (void) playBackground;
- (void) stopBackground;
- (void)loading;

@end
