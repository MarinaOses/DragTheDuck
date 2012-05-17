//
//  TimedMultipleBirdGenerator.m
//  MyGame
//
//  Created by Marina Osés Merino on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTimedMultipleObjectGenerator.h"

#import "MGSceneController.h"

@implementation MGTimedMultipleObjectGenerator

@synthesize objectsToAdd = _objectsToAdd;
@synthesize generator = _generator;

- (id)initWithMGGenerator:(id<MGGenerator>)mg_generator {
    self = [super init];
    if (self) {
        _objectsToAdd = [[NSMutableArray alloc] init];
        self.generator = mg_generator; 
        
    }
    return self;
}

+ (id<MGGenerator>)createSpecificMGGenerator:(int)type WithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    
    if (type == 0) {
        return [[[MGMultipleDuckGenerator alloc] initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer] autorelease];
    }
    else {
        return [[[MGMultipleBirdGenerator alloc] initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer] autorelease];
    }
}

- (void)clearObjectsToAdd {
    [self.objectsToAdd removeAllObjects];
}

- (void)loadNewObjectsWaveToAdd {
    [self.objectsToAdd addObjectsFromArray:[self.generator createWave]];
}


- (void)startNextTimer {
    NSTimeInterval randomSecondsToNextTimer = RANDOM_INT(MINSEC_TO_BIRD_APPEARANCE, MAXSEC_TO_BIRD_APPEARANCE);
    generatorTimer = [NSTimer scheduledTimerWithTimeInterval:randomSecondsToNextTimer target:self selector:@selector(getNewObjectsWaveToAdd) userInfo:nil repeats:NO];
}

- (void)getNewObjectsWaveToAdd {
    [self.objectsToAdd addObjectsFromArray:[self.generator createWave]];
    [self startNextTimer];
}

- (void)stopGeneratorTimer {
    [generatorTimer invalidate];
    generatorTimer = nil;
}

- (void)dealloc {
    [_objectsToAdd release];
    [_generator release];
    [super dealloc];
}

@end
