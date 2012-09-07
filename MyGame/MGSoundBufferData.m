//
//  MGSoundBufferData.m
//  MyGame
//
//  Created by Marina Osés Merino on 07/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSoundBufferData.h"

#define USE_BUFFER_DATA_STATIC_EXTENSION

@implementation MGSoundBufferData
@synthesize openALDataBuffer;

- (id)init {
    ALenum al_error;
    self = [super init];
    if (self) {
        //Limpiar los errores
        alGetError();
        alGenBuffers(1, &openALDataBuffer);
        al_error = alGetError();
        if (al_error != AL_NO_ERROR) {
            NSLog(@"Error al generar el buffer de datos openAL: %s\n", alGetString(al_error));
            [self release];
            return nil;
        }
    }
    return self;
}

- (void)bindDataBuffer:(void *)pcm_data_buffer WithFormat:(ALenum)al_format DataSize:(ALsizei)data_size SampleRate:(ALsizei)sample_rate {
    pcmDataBuffer = pcm_data_buffer;
    openALFormat = al_format;
    dataSize = data_size;
    sampleRate = sample_rate;
#ifdef USE_BUFFER_DATA_STATIC_EXTENSION
    alBufferDataStatic(openALDataBuffer, al_format, pcm_data_buffer, data_size, sample_rate);
#else
    //Se especifican los datos que se copiarán en un buffer
    alBufferData(openALDataBuffer, al_format, pcm_data_buffer, data_size, sample_rate);
    free(pcmDataBuffer);
    pcmDataBuffer = NULL;
#endif
}

- (void)dealloc {
    if (alIsBuffer(openALDataBuffer)) {
        alDeleteBuffers(1, &openALDataBuffer);
    }
    if (pcmDataBuffer != NULL) {
        free(pcmDataBuffer);
    }
    [super dealloc];
}

@end
