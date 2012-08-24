//
//  MGAudioSessionSupport.h
//  MyGame
//
//  Created by Marina Osés Merino on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef MyGame_MGAudioSessionSupport_h
#define MyGame_MGAudioSessionSupport_h


#include <AudioToolbox/AudioToolbox.h>
#include <stdbool.h>
#include <stdint.h>

bool initAudioSession(UInt32 session_category, AudioSessionInterruptionListener interruption_callback, void *user_data);

#endif
