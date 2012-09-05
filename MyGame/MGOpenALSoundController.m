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
@synthesize duckSound = _duckSound;
@synthesize killedDuckSound = _killedDuckSound;
@synthesize brokenEggSound = _brokenEggSound;
@synthesize friedEggSound = _friedEggSound;
@synthesize backgroundSound = _backgroundSound;
@synthesize savedDuckSound = _savedDuckSound;
@synthesize buttonClickSound = _buttonClickSound;
@synthesize leaveTakingSound = _leaveTakingSound;
@synthesize birdKillingSound = _birdKillingSound;
@synthesize leavesButtonActiveSound = _leavesButtonActiveSound;
@synthesize transformerFlyingSound = _transformerFlyingSound;
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
        initAudioSession(kAudioSessionCategory_AmbientSound, MyInterruptionCallback, self);
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
    
    _duckSound = [[MGSound alloc] initWithFileName:@"duck" LoopProperty:NO];
    _killedDuckSound = [[MGSound alloc] initWithFileName:@"egg_falling" LoopProperty:NO];
    _brokenEggSound = [[MGSound alloc] initWithFileName:@"egg_crash" LoopProperty:NO];
    _friedEggSound = [[MGSound alloc] initWithFileName:@"fried_egg" LoopProperty:NO];
    _backgroundSound = [[MGSound alloc] initWithFileName:@"background" LoopProperty:YES];
    _savedDuckSound = [[MGSound alloc] initWithFileName:@"saved_duck" LoopProperty:NO];
    _buttonClickSound = [[MGSound alloc] initWithFileName:@"button_click" LoopProperty:NO];
    _leaveTakingSound = [[MGSound alloc] initWithFileName:@"leave_taking" LoopProperty:NO];
    _birdKillingSound = [[MGSound alloc] initWithFileName:@"bird_killing" LoopProperty:NO];
    _leavesButtonActiveSound = [[MGSound alloc] initWithFileName:@"leaves_button_active" LoopProperty:YES];
    _transformerFlyingSound = [[MGSound alloc] initWithFileName:@"transformer_flying" LoopProperty:YES];

}

- (void)pauseAllSounds {
    [self.backgroundSound pause];
    
    if ([self.leavesButtonActiveSound loopPropertyCurrentlyEnabled]) {
        [self.leavesButtonActiveSound pause];
    }
    if ([self.transformerFlyingSound loopPropertyCurrentlyEnabled]) {
        [self.transformerFlyingSound pause];
    }
}

- (void)stopAllSounds {
    [self.backgroundSound stop];

    if ([self.leavesButtonActiveSound loopPropertyCurrentlyEnabled]) {
        [self.leavesButtonActiveSound stop];
    }
    if ([self.transformerFlyingSound loopPropertyCurrentlyEnabled]) {
        [self.transformerFlyingSound stop];
    }
}

- (void)restartAllSounds {
    [self.backgroundSound restart];
    
    if ([self.leavesButtonActiveSound loopPropertyCurrentlyEnabled]) {
        [self.leavesButtonActiveSound restart];
    }
    if ([self.transformerFlyingSound loopPropertyCurrentlyEnabled]) {
        [self.transformerFlyingSound restart];
    }
}

- (void)goodTouchOfSoundButtonIsDone {
    self.soundEnabled = !self.soundEnabled;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:self.soundEnabled forKey:@"soundEnabled"];
    [userDefaults synchronize];
}

- (void)badTouchOfSoundButtonIsDone {
    //Podría ampliarse la funcionalidad
}


- (void)tearDownOpenAL {
    [_duckSound release];
    [_killedDuckSound release];
    [_brokenEggSound release];
    [_friedEggSound release];
    [_backgroundSound release];
    [_savedDuckSound release];
    [_buttonClickSound release];
    [_leaveTakingSound release];
    [_birdKillingSound release];
    [_leavesButtonActiveSound release];
    [_transformerFlyingSound release];
}

- (void)dealloc {
    
    [self tearDownOpenAL];
    alcMakeContextCurrent(NULL);
    if (openALContext) {
        alcDestroyContext(openALContext);
        openALContext = NULL;
    }
    
    if (openALDevice) {
        alcCloseDevice(openALDevice);
        openALDevice = NULL;
    }
    [super dealloc];
}

@end
