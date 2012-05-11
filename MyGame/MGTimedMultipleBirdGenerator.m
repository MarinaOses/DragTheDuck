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


- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    
    if (self) {
        _birdsToAdd = [[NSMutableArray alloc] init];
        _multipleBirdGenerator = [[MGMultipleBirdGenerator alloc] initWithSceneController:scene_controller];
    }
    return self;
}

- (void)clearBirdsToAdd {
    [self.birdsToAdd removeAllObjects];
}

- (void)calculateNextTimer {
    NSTimeInterval randomSecondsToNextTimer = RANDOM_INT(MINSEC_TO_APPEARANCE, MAXSEC_TO_APPEARANCE);
    NSLog(@"seconds = %f", randomSecondsToNextTimer);
    generatorTimer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(getNewBirdsWaveToAdd) userInfo:nil repeats:NO];
}

- (void)getNewBirdsWaveToAdd {
    [self.birdsToAdd addObjectsFromArray:[self.multipleBirdGenerator createBirdsWave]];
    //[self calculateNextTimer];
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
