//
//  MGSoundSourceObject.m
//  MyGame
//
//  Created by Marina Osés Merino on 10/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSoundSourceObject.h"

@implementation MGSoundSourceObject


- (id)init {
    self = [super init];
    if (self) {
        audioLooping = AL_FALSE;
        pitchShift = 1.0f;
    }
    return self;
}

- (void)applyState {
    [super applyState];
    if (hasSourceID) {
        if (![[MGOpenALSoundController sharedSoundController] inInterruption]) {
            alSourcef(sourceID, AL_GAIN, self.gainLevel);
            alSourcei(sourceID, AL_LOOPING, audioLooping);
            alSourcef(sourceID, AL_PITCH, pitchShift);
        }
    }
}

- (void)update {
    [super update];
    [self applyState];
}

- (BOOL)playSound:(MGSoundBufferData *)sound_buffer_data {
    MGOpenALSoundController *openALSoundController = [MGOpenALSoundController sharedSoundController];
    ALuint buffer_id = sound_buffer_data.openALDataBuffer;
    ALuint source_id;
    BOOL played = NO;
    BOOL is_source_available = [openALSoundController reserveSource:&source_id];
    if (is_source_available) {
        sourceID = source_id;
        hasSourceID = YES;
        
        alSourcei(source_id, AL_BUFFER, buffer_id);
        [self applyState];
        [openALSoundController playSound:source_id];
        played = YES;
    }
    return played;
                            
}

- (void)stopSound {
    MGOpenALSoundController *openALSoundController = [MGOpenALSoundController sharedSoundController];
    if (hasSourceID) {
        [openALSoundController stopSound:sourceID];
        hasSourceID = NO;
    }
}



@end
