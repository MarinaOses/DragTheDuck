//
//  MGOpenALSoundController.h
//  MyGame
//
//  Created by Marina Osés Merino on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



#import "MGAudioSessionSupport.h"
#import "MGSound.h"

//ALC: Audio Library Context
@interface MGOpenALSoundController : NSObject {
    ALCdevice *openALDevice;
    ALCcontext *openALContext;
    
    MGSound *_duckSound;
    MGSound *_killedDuckSound;
    MGSound *_brokenEggSound;
    MGSound *_friedEggSound;
    MGSound *_backgroundSound;
    MGSound *_savedDuckSound;
    MGSound *_buttonClickSound;
    MGSound *_leaveTakingSound;
    MGSound *_birdKillingSound;
    MGSound *_leavesButtonActiveSound;
    MGSound *_transformerFlyingSound;
    
}

@property (nonatomic, assign) ALCcontext *openALContext;
@property (nonatomic, retain) MGSound *duckSound;
@property (nonatomic, retain) MGSound *killedDuckSound;
@property (nonatomic, retain) MGSound *brokenEggSound;
@property (nonatomic, retain) MGSound *friedEggSound;
@property (nonatomic, retain) MGSound *backgroundSound;
@property (nonatomic, retain) MGSound *savedDuckSound;
@property (nonatomic, retain) MGSound *buttonClickSound;
@property (nonatomic, retain) MGSound *leaveTakingSound;
@property (nonatomic, retain) MGSound *birdKillingSound;
@property (nonatomic, retain) MGSound *leavesButtonActiveSound;
@property (nonatomic, retain) MGSound *transformerFlyingSound;



+ (MGOpenALSoundController *) sharedSoundController;
- (void)initOpenAL;
- (void)pauseAllSounds;
- (void)stopAllSounds;
- (void)restartAllSounds;
- (void)loading;

@end
