//
//  MGBackground.m
//  MyGame
//
//  Created by Marina Osés Merino on 13/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGBackground.h"

@implementation MGBackground

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        self.scale = MGPointMake(480.0, 320.0, 1.0);
        self.translation = MGPointMake(0.0, 0.0, 0.0);
        self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_fondo_completo.png"];
        self.soundSourceObject.audioLooping = AL_TRUE;

    }
    return self;
}

- (void)playSound {
//    [self.soundSourceObject playSound:[[MGOpenALSoundController sharedSoundController] soundBufferDataFromFileBaseName:BACKGROUND]];

}

+ (void)loadResources {
    [[MGOpenALSoundController sharedSoundController] soundBufferDataFromFileBaseName:BACKGROUND];
}

@end
