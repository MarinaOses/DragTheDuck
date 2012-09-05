//
//  MGSound.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

#import "MGOpenALSupport.h"


@interface MGSound : NSObject {
    ALuint outputSource;
    ALuint outputBuffer;
    void *PCMData;
    BOOL loopProperty;
    BOOL loopPropertyCurrentlyEnabled;
    BOOL loopPlaying;
}

@property (nonatomic, assign) BOOL loopPropertyCurrentlyEnabled;
- (id)initWithFileName:(NSString *)file_name LoopProperty:(BOOL)loop_property;
- (void)playWithVolume:(ALfloat)volume;
- (void)pause;
- (void)stop;
- (void)restart;
@end
