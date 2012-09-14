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



@protocol MGSoundCallBackDelegate <NSObject>
@optional

- (void)soundDidFinishPlaying:(NSNumber *)source_number;

@end


//ALC: Audio Library Context
@interface MGOpenALSoundController : NSObject {
    ALCdevice *openALDevice;
    ALCcontext *openALContext;
    
    BOOL inInterruption;
    
    NSMutableDictionary *soundFileDictionary;
    
    ALuint *allSourcesArray;
    NSMutableSet *availableSourcesCollection;
    NSMutableSet *inUseSourcesCollection;
    NSMutableSet *playingSourcesCollection;
    
    
    BOOL soundEnabled;
    
    id<MGSoundCallBackDelegate> soundCallBackDelegate;
    
}

@property (nonatomic, assign) ALCcontext *openALContext;
@property (nonatomic, assign) BOOL inInterruption;
@property (nonatomic, assign) BOOL soundEnabled;
@property (nonatomic, assign) id<MGSoundCallBackDelegate> soundCallBackDelegate;


+ (MGOpenALSoundController *) sharedSoundController;
- (void)initOpenAL;
//- (void)pauseAllSounds;
//- (void)stopAllSounds;
//- (void)restartAllSounds;
- (void)loading;
- (void)update;
- (BOOL)reserveSource:(ALuint *)source_id;
- (void)playSound:(ALuint)source_id;
- (void)stopSound:(ALuint)source_id;
- (void)pauseSound:(ALuint)source_id;
- (void)restartSound:(ALuint)source_id;
- (void)stopALLPlayingSounds;
- (void)pauseALLPlayingSounds;
- (void)restartALLPlayingSounds;
- (MGSoundBufferData *)soundBufferDataFromFileBaseName:(NSString *)sound_file_basename;

@end
