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
    ALuint outputSourceSavedDuck;
    ALuint outputSourceButtonClick;
    ALuint outputSourceLeaveTaking;
    ALuint outputSourceBirdKilling;
    ALuint outputSourceLeavesButtonActive;
    ALuint outputSourceTransformerFlying;
    
    ALuint outputBufferDuck;
    ALuint outputBufferKilledDuck;
    ALuint outputBufferBrokenEgg;
    ALuint outputBufferFriedEgg;
    ALuint outputBufferBackground;
    ALuint outputBufferSavedDuck;
    ALuint outputBufferButtonClick;
    ALuint outputBufferLeaveTaking;
    ALuint outputBufferBirdKilling;
    ALuint outputBufferLeavesButtonActive;
    ALuint outputBufferTransformerFlying;

    
    void *duckPCMData;
    void *killedDuckPCMData;
    void *brokenEggPCMData;
    void *friedEggPCMData;
    void *backgroundPCMData;
    void *savedDuckPCMData;
    void *buttonClickPCMData;
    void *leaveTakingPCMData;
    void *birdKillingPCMData;
    void *leavesButtonActivePCMData;
    void *transformerFlyingPCMData;
    
}

@property (nonatomic, assign) ALCcontext *openALContext;

+ (MGOpenALSoundController *) sharedSoundController;
- (void)initOpenAL;
- (void)playDuck;
- (void)playKilledDuck;
- (void)playBrokenEgg;
- (void)playFriedEgg;
- (void)playSavedDuck;
- (void)playButtonClick;
- (void)playLeaveTaking;
- (void)playBirdKilling;
- (void) playBackground;
- (void) stopBackground;
- (void) playLeavesButtonActive;
- (void) stopLeavesButtonActive;
- (void) playTransformerFlying;
- (void) stopTransformerFlying;
- (void)loading;

@end
