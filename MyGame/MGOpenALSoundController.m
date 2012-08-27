//
//  MGOpenALSoundController.m
//  MyGame
//
//  Created by Marina Osés Merino on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGOpenALSoundController.h"

@implementation MGOpenALSoundController


+ (MGOpenALSoundController *) sharedSoundController {
    static MGOpenALSoundController *shared_sound_controller;
    @synchronized(self) {
        if (shared_sound_controller == nil) {
            shared_sound_controller = [[MGOpenALSoundController alloc] init];
        }
        return shared_sound_controller;
    }
    return shared_sound_controller;
}

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
    alGenBuffers(1, &quakOutputBuffer);
    
    ALsizei data_size;
    ALenum al_format;
    ALsizei sample_rate;
    NSURL *file_url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"quak" ofType:@"wav"]];
    quakPCMData = MyGetOpenALAudioDataAll((CFURLRef)file_url, &data_size, &al_format, &sample_rate);
    alBufferDataStatic(quakOutputBuffer, al_format, quakPCMData, data_size, sample_rate);
    [file_url release];
    
    
    //outputSource es el ID del source que queremos manipular
    //AL_BUFFER especifica que tipo de operación queremos hacer. En este caso se quiere conectar el buffer con el source
    //quakOutputBuffer es el ID del buffer
    alSourcei(outputSource, AL_BUFFER, quakOutputBuffer);
    
    //OpenAL copia el contenido de quakPCMData en su buffer de memoria, de modo que si OpenAL ya tiene los datos debemos liberar la memoria que hemos alojado para dicha variable en MyGetOpenALAudioDataAll().
//    alBufferData(quakOutputBuffer, al_format, quakPCMData, data_size, sample_rate);
//    free(quakPCMData);
//    quakPCMData = NULL;
}



- (void)playQuak {
    alSourcePlay(outputSource);
}

- (void)tearDownOpenAL {
    alDeleteSources(1, &outputSource);
    alDeleteBuffers(1, &quakOutputBuffer);
    
    alcMakeContextCurrent(NULL);
    if (openALContext) {
        alcDestroyContext(openALContext);
        openALContext = NULL;
    }
    
    if (openALDevice) {
        alcCloseDevice(openALDevice);
        openALDevice = NULL;
    }
    
    if (quakPCMData) {
        free(quakPCMData);
        quakPCMData = NULL;
    }
}

- (void)dealloc {
    [self tearDownOpenAL];
    [super dealloc];
}

@end
