//
//  MGSoundBufferData.h
//  MyGame
//
//  Created by Marina Osés Merino on 07/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenAL/al.h>
#import "MGOpenALSupport.h"


@interface MGSoundBufferData : NSObject {
    ALuint openALDataBuffer;
    void *pcmDataBuffer;
    ALenum openALFormat;
    ALsizei dataSize;
    ALsizei sampleRate;
}

@property(nonatomic, assign, readonly) ALuint openALDataBuffer;
- (void)bindDataBuffer:(void *)pcm_data_buffer WithFormat:(ALenum)al_format DataSize:(ALsizei)data_size SampleRate:(ALsizei)sample_rate;

@end
