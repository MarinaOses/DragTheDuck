//
//  MGOpenALSupport.h
//  MyGame
//
//  Created by Marina Osés Merino on 24/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef MyGame_MGOpenALSupport_h
#define MyGame_MGOpenALSupport_h

    
#include <stdbool.h>
// OpenAL header locations are not defined by the spec.
#ifdef __APPLE__
#include <OpenAL/al.h>
#include <OpenAL/alc.h>
#elif defined(_WIN32)
#include "al.h"
#include "alc.h"
#else
#include <AL/al.h>
#include <AL/alc.h>
#endif
    
#import <AudioToolbox/AudioToolbox.h>
typedef ALvoid AL_APIENTRY (*alBufferDataStaticProcPtr) (ALint buffer_id, ALenum al_format, ALvoid *pcm_data, ALsizei buffer_size, ALsizei sample_rate);
ALvoid alBufferDataStatic(ALint buffer_id, ALenum al_format, ALvoid *pcm_data, ALsizei buffer_size, ALsizei sample_rate);

ExtAudioFileRef MyGetExtAudioFileRef(CFURLRef file_url, AudioStreamBasicDescription *audio_description);
OSStatus MyGetDataFromExtAudioRef(ExtAudioFileRef ext_file_ref, const AudioStreamBasicDescription *restrict output_format, ALsizei max_buffer_size, void **data_buffer, ALsizei *data_bufer_size, ALenum *al_format, ALsizei *sample_rate);
void *MyGetOpenALAudioDataAll(CFURLRef file_url, ALsizei *data_buffer_size, ALenum *al_format, ALsizei *sample_rate);
#endif
