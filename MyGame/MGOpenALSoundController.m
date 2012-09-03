//
//  MGOpenALSoundController.m
//  MyGame
//
//  Created by Marina Osés Merino on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGOpenALSoundController.h"

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
        initAudioSession(kAudioSessionCategory_AmbientSound, MyInterruptionCallback, self);
        [self initOpenAL];
    }
    return self;
}

- (void)loading {
    
}

- (void)loadSoundWithOutputSource:(ALuint *)output_source OutputBuffer:(ALuint *)output_buffer PCMData:(void *)PCM_data FileName:(NSString *)file_name {
    
    //solo creamos un source. Si queremos más de uno:
    //ALuint sources_array[32];
    //alGenSources(32, sources_array);
    alGenSources(1, output_source);
    
    //El 0 no es un ID válido
    //alGetError() : para detectar errores
    //alIsSource(source_id) : para determinar si un source id es válido 
    alGenBuffers(1, output_buffer);
    
    
    
    ALsizei data_size;
    ALenum al_format;
    ALsizei sample_rate;
    NSURL *file_url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:file_name ofType:@"wav"]];
    PCM_data = MyGetOpenALAudioDataAll((CFURLRef)file_url, &data_size, &al_format, &sample_rate);
    alBufferDataStatic(*output_buffer, al_format, PCM_data, data_size, sample_rate);
    [file_url release];
    
    //outputSource es el ID del source que queremos manipular
    //AL_BUFFER especifica que tipo de operación queremos hacer. En este caso se quiere conectar el buffer con el source
    //quakOutputBuffer es el ID del buffer
    alSourcei(*output_source, AL_BUFFER, *output_buffer);
    
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
    
    [self loadSoundWithOutputSource:&outputSourceDuck OutputBuffer:&outputBufferDuck PCMData:duckPCMData FileName:@"duck"];
    [self loadSoundWithOutputSource:&outputSourceKilledDuck OutputBuffer:&outputBufferKilledDuck PCMData:killedDuckPCMData FileName:@"egg_falling"];
    [self loadSoundWithOutputSource:&outputSourceBrokenEgg OutputBuffer:&outputBufferBrokenEgg PCMData:brokenEggPCMData FileName:@"egg_crash"];
    [self loadSoundWithOutputSource:&outputSourceFriedEgg OutputBuffer:&outputBufferFriedEgg PCMData:friedEggPCMData FileName:@"fried_egg"];
    [self loadSoundWithOutputSource:&outputSourceBackground OutputBuffer:&outputBufferBackground PCMData:backgroundPCMData FileName:@"background"];
    [self loadSoundWithOutputSource:&outputSourceSavedDuck OutputBuffer:&outputBufferSavedDuck PCMData:savedDuckPCMData FileName:@"saved_duck"];
    [self loadSoundWithOutputSource:&outputSourceButtonClick OutputBuffer:&outputBufferButtonClick PCMData:buttonClickPCMData FileName:@"button_click"];
    [self loadSoundWithOutputSource:&outputSourceLeaveTaking OutputBuffer: &outputBufferLeaveTaking PCMData:leaveTakingPCMData FileName:@"leave_taking"];
    [self loadSoundWithOutputSource:&outputSourceBirdKilling OutputBuffer:&outputBufferBirdKilling PCMData:birdKillingPCMData FileName:@"bird_killing"];
    [self loadSoundWithOutputSource:&outputSourceLeavesButtonActive OutputBuffer:&outputBufferLeavesButtonActive PCMData:leavesButtonActivePCMData FileName:@"leaves_button_active"];
    [self loadSoundWithOutputSource:&outputSourceTransformerFlying OutputBuffer:&outputBufferTransformerFlying PCMData:transformerFlyingPCMData FileName:@"transformer_flying"];

}



- (void)playDuck {
    alSourcePlay(outputSourceDuck);
}

- (void)playKilledDuck {
    alSourcePlay(outputSourceKilledDuck);
}

- (void)playBrokenEgg {
    alSourcePlay(outputSourceBrokenEgg);
}

- (void)playFriedEgg {
    alSourcePlay(outputSourceFriedEgg);
}

- (void)playSavedDuck {
    alSourcePlay(outputSourceSavedDuck);
}

- (void)playButtonClick {
    alSourcePlay(outputSourceButtonClick);
}

- (void)playLeaveTaking {
    alSourcePlay(outputSourceLeaveTaking);
}


- (void)playBirdKilling {
    alSourcePlay(outputSourceBirdKilling);
}

//Si queremos hacer un bucle con un determinado sonido:
- (void) playBackground
{
    alSourcei(outputSourceBackground, AL_LOOPING, AL_TRUE);
    alSourcef(outputSourceBackground, AL_GAIN, 0.3f);
    alSourcePlay(outputSourceBackground);
}

- (void) playLeavesButtonActive
{
    alSourcei(outputSourceLeavesButtonActive, AL_LOOPING, AL_TRUE);
    alSourcePlay(outputSourceLeavesButtonActive);
}

- (void) playTransformerFlying
{
    alSourcei(outputSourceTransformerFlying, AL_LOOPING, AL_TRUE);
    alSourcePlay(outputSourceTransformerFlying);
}

//Para pararlo:
- (void) stopBackground
{
    alSourceStop(outputSourceBackground);
    alSourcei(outputSourceBackground, AL_LOOPING, AL_FALSE);
}

- (void) stopLeavesButtonActive
{
    alSourceStop(outputSourceLeavesButtonActive);
    alSourcei(outputSourceLeavesButtonActive, AL_LOOPING, AL_FALSE);
}

- (void) stopTransformerFlying
{
    alSourceStop(outputSourceTransformerFlying);
    alSourcei(outputSourceTransformerFlying, AL_LOOPING, AL_FALSE);
}


- (void)tearDownOpenAL {
    alDeleteSources(1, &outputSourceDuck);
    alDeleteBuffers(1, &outputBufferDuck);
    
    alDeleteSources(1, &outputSourceKilledDuck);
    alDeleteBuffers(1, &outputBufferKilledDuck);
    
    alDeleteSources(1, &outputSourceBrokenEgg);
    alDeleteBuffers(1, &outputBufferBrokenEgg);
    
    alDeleteSources(1, &outputSourceFriedEgg);
    alDeleteBuffers(1, &outputBufferFriedEgg);
    
    alDeleteSources(1, &outputSourceBackground);
    alDeleteBuffers(1, &outputBufferBackground);
    
    alDeleteSources(1, &outputSourceSavedDuck);
    alDeleteBuffers(1, &outputBufferSavedDuck);
    
    alDeleteSources(1, &outputSourceButtonClick);
    alDeleteBuffers(1, &outputBufferButtonClick);
    
    alDeleteSources(1, &outputSourceLeaveTaking);
    alDeleteBuffers(1, &outputBufferLeaveTaking);
    
    alDeleteSources(1, &outputSourceBirdKilling);
    alDeleteBuffers(1, &outputBufferBirdKilling);
    
    alcMakeContextCurrent(NULL);
    if (openALContext) {
        alcDestroyContext(openALContext);
        openALContext = NULL;
    }
    
    if (openALDevice) {
        alcCloseDevice(openALDevice);
        openALDevice = NULL;
    }
    
    if (duckPCMData) {
        free(duckPCMData);
        duckPCMData = NULL;
    }
    
    if (killedDuckPCMData) {
        free(killedDuckPCMData);
        killedDuckPCMData = NULL;
    }
    
    if (brokenEggPCMData) {
        free(brokenEggPCMData);
        brokenEggPCMData = NULL;
    }
    
    if (friedEggPCMData) {
        free(friedEggPCMData);
        friedEggPCMData = NULL;
    }
    
    if (backgroundPCMData) {
        free(backgroundPCMData);
        backgroundPCMData = NULL;
    }
    
    if (savedDuckPCMData) {
        free(savedDuckPCMData);
        savedDuckPCMData = NULL;
    }
    
    if (buttonClickPCMData) {
        free(buttonClickPCMData);
        buttonClickPCMData = NULL;
    }
    
    if (leaveTakingPCMData) {
        free(leaveTakingPCMData);
        leaveTakingPCMData = NULL;
    }
    
    if (birdKillingPCMData) {
        free(birdKillingPCMData);
        birdKillingPCMData = NULL;
    }
}

- (void)dealloc {
    [self tearDownOpenAL];
    [super dealloc];
}

@end
