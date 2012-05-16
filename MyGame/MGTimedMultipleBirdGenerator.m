//
//  TimedMultipleBirdGenerator.m
//  MyGame
//
//  Created by Marina Osés Merino on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTimedMultipleBirdGenerator.h"

#import "MGSceneController.h"

@implementation MGTimedMultipleBirdGenerator

@synthesize birdsToAdd = _birdsToAdd;
@synthesize multipleBirdGenerator = _multipleBirdGenerator;


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super init];
    
    if (self) {
        _birdsToAdd = [[NSMutableArray alloc] init];
        _multipleBirdGenerator = [[MGMultipleDuckGenerator alloc] initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer];
    }
    return self;
}

- (void)clearBirdsToAdd {
    [self.birdsToAdd removeAllObjects];
}

- (void)loadNewBirdsWaveToAdd {
    [self.birdsToAdd addObjectsFromArray:[self.multipleBirdGenerator createWave]];
}


- (void)startNextTimer {
    NSTimeInterval randomSecondsToNextTimer = RANDOM_INT(MINSEC_TO_BIRD_APPEARANCE, MAXSEC_TO_BIRD_APPEARANCE);
    generatorTimer = [NSTimer scheduledTimerWithTimeInterval:randomSecondsToNextTimer target:self selector:@selector(getNewBirdsWaveToAdd) userInfo:nil repeats:NO];
}

- (void)getNewBirdsWaveToAdd {
    [self.birdsToAdd addObjectsFromArray:[self.multipleBirdGenerator createWave]];
    [self startNextTimer];
}

- (void)stopGeneratorTimer {
    [generatorTimer invalidate];
    generatorTimer = nil;
}

- (void)dealloc {
    [_birdsToAdd release];
    [_multipleBirdGenerator release];
    [super dealloc];
}

@end
