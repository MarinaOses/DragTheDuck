//
//  MGSound.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSound.h"

#import "MGOpenALSoundController.h"

@implementation MGSound
@synthesize loopPropertyCurrentlyEnabled;


- (id)initWithFileName:(NSString *)file_name LoopProperty:(BOOL)loop_property {
    self = [super init];
    if (self) {
        //solo creamos un source. Si queremos más de uno:
        //ALuint sources_array[32];
        //alGenSources(32, sources_array);
        alGenSources(1, &outputSource);
        
        //El 0 no es un ID válido
        //alGetError() : para detectar errores
        //alIsSource(source_id) : para determinar si un source id es válido 
        alGenBuffers(1, &outputBuffer);
        ALsizei data_size;
        ALenum al_format;
        ALsizei sample_rate;
        NSURL *file_url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:file_name ofType:@"wav"]];
        PCMData = MyGetOpenALAudioDataAll((CFURLRef)file_url, &data_size, &al_format, &sample_rate);
        alBufferDataStatic(outputBuffer, al_format, PCMData, data_size, sample_rate);
        [file_url release];
        
        //outputSource es el ID del source que queremos manipular
        //AL_BUFFER especifica que tipo de operación queremos hacer. En este caso se quiere conectar el buffer con el source
        //quakOutputBuffer es el ID del buffer
        alSourcei(outputSource, AL_BUFFER, outputBuffer);
        loopProperty = loop_property;
        loopPropertyCurrentlyEnabled = NO;
        loopPlaying = NO;
    }
    return self;
}


- (void)playWithVolume:(ALfloat)volume {
    if ([MGOpenALSoundController sharedSoundController].soundEnabled) {
        if (loopProperty && !loopPlaying) {
            alSourcei(outputSource, AL_LOOPING, AL_TRUE);
            loopPropertyCurrentlyEnabled = YES;
            loopPlaying = YES;
        }
        alSourcef(outputSource, AL_GAIN, volume);
        alSourcePlay(outputSource);
    }
    
}


- (void)stop {
    if ([MGOpenALSoundController sharedSoundController].soundEnabled) {
        alSourceStop(outputSource);
        if (loopProperty && loopPlaying) {
            alSourcei(outputSource, AL_LOOPING, AL_FALSE);
            loopPropertyCurrentlyEnabled = NO;
            loopPlaying = NO;
        }
    }
}

- (void)pause {
    if ([MGOpenALSoundController sharedSoundController].soundEnabled) {
        alSourcePause(outputSource);
        if (loopProperty) {
            alSourcei(outputSource, AL_LOOPING, AL_FALSE);
        }
    }
    
}

- (void)restart {
    if ([MGOpenALSoundController sharedSoundController].soundEnabled) {
        if (loopProperty) {
            alSourcei(outputSource, AL_LOOPING, AL_TRUE);
        }
        alSourcePlay(outputSource);
    }
}

- (void)dealloc {
    alDeleteSources(1, &outputSource);
    alDeleteBuffers(1, &outputBuffer);
    if (PCMData) {
        free(PCMData);
        PCMData = NULL;
    }
    [super dealloc];
}


@end
