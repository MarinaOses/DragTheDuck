//
//  MGOpenALSoundController.m
//  MyGame
//
//  Created by Marina Osés Merino on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGOpenALSoundController.h"

#define PREFERRED_SAMPLE_OUTPUT_RATE 22050.0
#define MAX_NUMBER_OF_ALSOURCES 32


static void MyInterruptionCallback(void *user_data, UInt32 interruption_state) {
    MGOpenALSoundController *openALSoundController = (MGOpenALSoundController *)user_data;
    OSStatus the_error = noErr;
    if (kAudioSessionBeginInterruption == interruption_state) {
        //Suspende el estado del contexto
        alcSuspendContext(openALSoundController.openALContext);
        alcMakeContextCurrent(NULL);
    }
    else if (kAudioSessionEndInterruption == interruption_state) {
        //Reactivamos la sesión de audio
        the_error = AudioSessionSetActive(true);
        if (noErr != the_error) {
            printf("Error setting audio session active! %ld\n", the_error);
        }
        //Hacemos un contexto actual
        alcMakeContextCurrent(openALSoundController.openALContext);
        //Reanudamos el procesado del estado del contexto
        alcProcessContext(openALSoundController.openALContext);
    }
}

@implementation MGOpenALSoundController
@synthesize openALContext;
@synthesize soundEnabled;

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
        soundEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"soundEnabled"];
        initAudioSession(kAudioSessionCategory_AmbientSound, MyInterruptionCallback, self, PREFERRED_SAMPLE_OUTPUT_RATE);
        soundFileDictionary = [[NSMutableDictionary alloc] init]; 
        [self initOpenAL];
    }
    return self;
}

- (void)loading {
    
}


- (void)initOpenAL {
    //Con el parámetro a null abre el dispositivo por defecto elegido por el sistema operativo
    openALDevice = alcOpenDevice(NULL);
    if (openALDevice) {
        // 0 -> ALC_MONO_SOURCES
        // 1 -> ALC_STEREO_SOURCES
        alcMacOSXMixerOutputRate(PREFERRED_SAMPLE_OUTPUT_RATE);
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
    //calloc() inicializa la memoria a 0
    allSourcesArray = (ALuint *)calloc(MAX_NUMBER_OF_ALSOURCES, sizeof(ALuint));
    alGenSources(MAX_NUMBER_OF_ALSOURCES, allSourcesArray);
    availableSourcesCollection = [[NSMutableSet alloc] initWithCapacity:MAX_NUMBER_OF_ALSOURCES];
    inUseSourcesCollection = [[NSMutableSet alloc] initWithCapacity:MAX_NUMBER_OF_ALSOURCES];
    playingSourcesCollection = [[NSMutableSet alloc] initWithCapacity:MAX_NUMBER_OF_ALSOURCES];
    
    for (NSUInteger i = 0; i < MAX_NUMBER_OF_ALSOURCES; i++) {
        [availableSourcesCollection addObject:[NSNumber numberWithUnsignedInt:allSourcesArray[i]]];
    }
}

//Reserva fuentes para usar. Las borra de las fuentes disponibles introduciéndolas en las fuentes en uso.
//Devuelve el puntero al identificador de la fuente.

- (BOOL)reserveSource:(ALuint *)source_id {
    NSNumber *source_number;
    BOOL didSourcesBeReserved = NO;
    if ([availableSourcesCollection count] != 0) {
        source_number = [availableSourcesCollection anyObject];
        [inUseSourcesCollection addObject:source_number];
        [availableSourcesCollection removeObject:source_number];
        *source_id = [source_number unsignedIntValue];
        didSourcesBeReserved = YES;
    }
    return didSourcesBeReserved;
}

- (void)recycleSource:(ALuint)source_id {
    NSNumber *source_number = [NSNumber numberWithUnsignedInt:source_id];
    
    [inUseSourcesCollection removeObject:source_number];
    [availableSourcesCollection addObject:source_number];
    
}


- (void)playSound:(ALuint)source_id {
    [playingSourcesCollection addObject:[NSNumber numberWithUnsignedInt:source_id]];
    alSourcePlay(source_id);
    //alSourcei(source_id, AL_GAIN, 1.0f);
    //alSourcei(source_id, AL_LOOPING, TRUE);
}

- (void)stopSound:(ALuint)source_id {
    alSourceStop(source_id);
    //Separamos el buffer de la fuente
    alSourcei(source_id, AL_BUFFER, AL_NONE); 
    //Se hace que el sonido esté de nuevo disponible
    [playingSourcesCollection removeObject:[NSNumber numberWithUnsignedInt:source_id]];
    [self recycleSource:source_id];
}



//El método de stop() sólo sirve para aquellos sonidos que tengan activada la propiedad LOOP. Los sonidos cortos se paran por sí mismos automáticamente y como no ejecutan el método stop() siguen en "uso" y no pasan a estar disponibles.
//El siguiente método quita esos sonidos cortos del set de "uso" y los pone en el set de disponibles.

- (void)update {
    NSMutableSet *itemsToBePurgeCollection = [[NSMutableSet alloc] initWithCapacity:[playingSourcesCollection count]];
    for (NSNumber *current_number in playingSourcesCollection) {
        ALuint source_id = [current_number unsignedIntValue];
        ALenum source_state;
        alGetSourcei(source_id, AL_SOURCE_STATE, &source_state);
        if (source_state == AL_STOPPED) {
            alSourcei(source_id, AL_BUFFER, AL_NONE);
            [itemsToBePurgeCollection addObject:current_number];
        }
    }
    
    for (NSNumber *current_number in itemsToBePurgeCollection) {
        [playingSourcesCollection removeObject:current_number];
        [self recycleSource:[current_number unsignedIntValue]];
    }
    
    [itemsToBePurgeCollection release];
}




//- (void)pauseAllSounds {
//    [self.backgroundSound pause];
//    
//    if ([self.leavesButtonActiveSound loopPropertyCurrentlyEnabled]) {
//        [self.leavesButtonActiveSound pause];
//    }
//    if ([self.transformerFlyingSound loopPropertyCurrentlyEnabled]) {
//        [self.transformerFlyingSound pause];
//    }
//}
//
//- (void)stopAllSounds {
//    [self.backgroundSound stop];
//
//    if ([self.leavesButtonActiveSound loopPropertyCurrentlyEnabled]) {
//        [self.leavesButtonActiveSound stop];
//    }
//    if ([self.transformerFlyingSound loopPropertyCurrentlyEnabled]) {
//        [self.transformerFlyingSound stop];
//    }
//}
//
//- (void)restartAllSounds {
//    [self.backgroundSound restart];
//    
//    if ([self.leavesButtonActiveSound loopPropertyCurrentlyEnabled]) {
//        [self.leavesButtonActiveSound restart];
//    }
//    if ([self.transformerFlyingSound loopPropertyCurrentlyEnabled]) {
//        [self.transformerFlyingSound restart];
//    }
//}

- (void)goodTouchOfSoundButtonIsDone {
    self.soundEnabled = !self.soundEnabled;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:self.soundEnabled forKey:@"soundEnabled"];
    [userDefaults synchronize];
}

- (void)badTouchOfSoundButtonIsDone {
    //Podría ampliarse la funcionalidad
}


/**
 * Carga un fichero de sonido de la carpeta de recursos y lo almacena en un diccionario global.
 * Las extensiones de fichero que se van a buscar son: caf, wav, aac, mp3, aiff, mp4, m4a.
 * @param sound_file_basename Es el nombre base del fichero. No debe llevar la extensión.
 * @return Devuelve un objeto MGSoundBufferData que es una simple estructura de datos la cual contiene todos los datos relevantes que se necesitan.
 **/

- (MGSoundBufferData *)soundBufferDataFromFileBaseName:(NSString *)sound_file_basename {
    ALsizei data_size;
    ALenum al_format;
    ALsizei sample_rate;
    NSURL *file_url = nil;
    
    //Primero debe asegurarse que el fichero no ha sido previamente cargado
    MGSoundBufferData *sound_data = [soundFileDictionary valueForKey:sound_file_basename];
    if (sound_data != nil) {
        return sound_data;
    }
    else {
        //Crear un array temporal que contenga todas las posibles extensiones.
        //Esta no es una lista completa de todos los tipos que puede reconocer Core Audio
        NSArray *file_extension_array = [[NSArray alloc] initWithObjects:@"caf", @"wav", @"aac", @"mp3", @"aiff", @"mp4", @"m4a", nil];
        for (NSString *file_extension in file_extension_array) {
            //Se debe comprobar primero si el fichero existe. Por el contrario, initFileURLWithPath:ofType fallará.
            NSString *full_file_name = [NSString stringWithFormat:@"%@/%@.%@", [[NSBundle mainBundle] resourcePath], sound_file_basename, file_extension];
            if ([[NSFileManager defaultManager] fileExistsAtPath:full_file_name]) {
                file_url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:sound_file_basename ofType:file_extension]];
                break;
            }
        }
        [file_extension_array release];
        
        if (file_url == nil) {
            NSLog(@"Error al localizar el fichero con nombre base: %@", sound_file_basename);
            return nil;
        }
        else {
            void *pcm_data_buffer = MyGetOpenALAudioDataAll((CFURLRef)file_url, &data_size, &al_format, &sample_rate);
            [file_url release];
            if (pcm_data_buffer == NULL) {
                NSLog(@"Error al cargar los datos de audio del fichero: %@", sound_file_basename);
                return nil;
            }
            else {
                sound_data = [[MGSoundBufferData alloc] init];
                //Meter los datos pcm en el buffer de openAL
                [sound_data bindDataBuffer:pcm_data_buffer WithFormat:al_format DataSize:data_size SampleRate:sample_rate];
                
                //Poner los datos en el diccionario de manera que podamos encontrarlo por el nombre del fichero
                [soundFileDictionary setValue:sound_data forKey:sound_file_basename];
                return [sound_data autorelease];
            }
        }
    }
}

- (void)tearDownOpenAL {
    alcMakeContextCurrent(NULL);
    if (openALContext) {
        alcDestroyContext(openALContext);
        openALContext = NULL;
    }
    
    if (openALDevice) {
        alcCloseDevice(openALDevice);
        openALDevice = NULL;
    }
    [availableSourcesCollection release];
    [inUseSourcesCollection release];
    [playingSourcesCollection release];
}

- (void)dealloc {
    [self tearDownOpenAL];
    [soundFileDictionary release];
    [super dealloc];
}

@end
