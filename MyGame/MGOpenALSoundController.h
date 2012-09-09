//
//  MGOpenALSoundController.h
//  MyGame
//
//  Created by Marina Osés Merino on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



#import "MGAudioSessionSupport.h"
#import "MGSoundBufferData.h"
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

//ALC: Audio Library Context
@interface MGOpenALSoundController : NSObject {
    ALCdevice *openALDevice;
    ALCcontext *openALContext;
    
    NSMutableDictionary *soundFileDictionary;
    
    ALuint *allSourcesArray;
    NSMutableSet *availableSourcesCollection;
    NSMutableSet *inUseSourcesCollection;
    NSMutableSet *playingSourcesCollection;
    
    
    BOOL soundEnabled;
    
}

@property (nonatomic, assign) ALCcontext *openALContext;

@property (nonatomic, assign) BOOL soundEnabled;


+ (MGOpenALSoundController *) sharedSoundController;
- (void)initOpenAL;
//- (void)pauseAllSounds;
//- (void)stopAllSounds;
//- (void)restartAllSounds;
- (void)loading;

@end
