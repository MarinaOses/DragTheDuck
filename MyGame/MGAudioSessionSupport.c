//
//  MGAudioSessionSupport.c
//  MyGame
//
//  Created by Marina Osés Merino on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "MGAudioSessionSupport.h"

#include <stdio.h> /* printf */
#include <ctype.h> /* isprint */
#include <arpa/inet.h> /* htonl */

bool initAudioSession(UInt32 session_category, AudioSessionInterruptionListener interruption_callback, void *user_data, Float64 sample_rate) {
    
    OSStatus the_error = AudioSessionInitialize(NULL, NULL, interruption_callback, user_data);
    if (noErr != the_error) {
        printf("Error al inicializar la sesión de audio!");
        return false;
    }
    the_error = AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(session_category), &session_category);
    if (noErr != the_error) {
        printf("Error al setear la categoría de la sesión de audio!");
        return false;
    }
    setPreferredSampleRate(sample_rate);
    the_error = AudioSessionSetActive(true);
    if (noErr != the_error) {
        printf("Error al poner en activo la sesión de audio!");
        return false;
    }
    return true;
}

void setPreferredSampleRate(Float64 preferred_sample_rate) {
    OSStatus the_error;
    UInt32 the_size = sizeof(preferred_sample_rate);
    the_error = AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, the_size, &preferred_sample_rate);
    if (noErr != the_error) {
        printf("Error al setear PreferredHarwareSampleRate!");
    }
}
