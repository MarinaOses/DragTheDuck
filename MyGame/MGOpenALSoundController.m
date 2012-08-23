//
//  MGOpenALSoundController.m
//  MyGame
//
//  Created by Marina Osés Merino on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGOpenALSoundController.h"

@implementation MGOpenALSoundController

- (id)init {
    self = [super init];
    if (self) {
        initAudioSession(kAudioSessionCategory_AmbientSound, NULL, NULL);
    }
    [self initOpenAL];
    return self;
}

- (void)initOpenAL {
    //Con el parámetro a null abre el dispositivo por defecto elegido por el sistema operativo
    openALDevice = alcOpenDevice(NULL);
    if (openALDevice) {
        // 0 -> ALC_MONO_SOURCES
        // 1 -> ALC_STEREO_SOURCES
        openALContext = alcCreateContext(openALDevice, 0);
        if (openALContext) {
            alcMakeContextCurrent(openALContext);
        }
        else {
            NSLog(@"No se ha podido crear el contexto de audio.");
            return;
        }
    }
    else {
        NSLog(@"No se ha podido abrir el dispositivo para el audio.");
        return;
    }
    alGenSources(1, &outputSource);
    //solo creamos un source. Si queremos más de uno:
    //ALuint sources_array[32];
    //alGenSources(32, sources_array);
    
    //El 0 no es un ID válido
    //alGetError() : para detectar errores
    //alIsSource(source_id) : para determinar si un source id es válido 
    alGenBuffers(1, &laserOutputBuffer);
}

@end
