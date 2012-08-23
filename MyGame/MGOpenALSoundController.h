//
//  MGOpenALSoundController.h
//  MyGame
//
//  Created by Marina Osés Merino on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

#import "MGAudioSessionSupport.h"

//ALC: Audio Library Context
@interface MGOpenALSoundController : NSObject {
    ALCdevice *openALDevice;
    ALCcontext *openALContext;
    ALuint outputSource;
    ALuint laserOutputBuffer;
}

- (void)initOpenAL;

@end
