//
//  MGSoundSourceObject.h
//  MyGame
//
//  Created by Marina Osés Merino on 10/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSoundState.h"
#import "MGSoundBufferData.h"
#import "MGOpenALSoundController.h"

@interface MGSoundSourceObject : MGSoundState {
    ALuint sourceID;
    BOOL hasSourceID;
    ALboolean audioLooping;
    ALfloat pitchShift;
}


@property (nonatomic, assign) ALboolean audioLooping;

- (BOOL)playSound:(MGSoundBufferData *)sound_buffer_data;
- (void)stopSound;
- (void)pauseSound;
- (void)restartSound;
- (void)soundDidFinishPlaying:(NSNumber *)source_number;



@end
