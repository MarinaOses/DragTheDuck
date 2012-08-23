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

bool initAudioSession(UInt32 session_category, AudioSessionInterruptionListener interruption_callback, void *user_data) {
    AudioSessionInitialize(NULL, NULL, interruption_callback, user_data);
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(session_category), &session_category);
    AudioSessionSetActive(true);
    return true;
}
