//
//  MGLife.m
//  MyGame
//
//  Created by Marina Osés Merino on 13/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGLife.h"

@implementation MGLife



- (void)playSound {
    [self.soundSourceObject playSound:[[MGOpenALSoundController sharedSoundController] soundBufferDataFromFileBaseName:FRIED_EGG]];
}

+ (void)loadResources {
    [[MGOpenALSoundController sharedSoundController] soundBufferDataFromFileBaseName:FRIED_EGG];
}

@end
