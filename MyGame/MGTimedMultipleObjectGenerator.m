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
@synthesize timeController = _timeController;

- (id)initWithMGGenerator:(id<MGGenerator>)mg_generator TimeController:(MGTimeController *)time_controller {
    self = [super init];
    if (self) {
        _objectsToAdd = [[NSMutableArray alloc] init];
        self.generator = mg_generator; 
        self.timeController = time_controller;
        
    }
    return self;
}

+ (id<MGGenerator>)createSpecificMGGenerator:(int)type WithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTransmitter:(MGScoreTransmitter *)score_transmitter SceneObjects:(NSMutableArray *)scene_objects {
    
    if (type == DUCKS) {
        return [[[MGMultipleDuckGenerator alloc] initWithSceneController:scene_controller BoundaryController:boundary_controller SceneObjectDestroyer:scene_object_destroyer ScoreTrasnmitter:score_transmitter SceneObjects:scene_objects] autorelease];
    }
    else if (type == BIRDS) {
        return [[[MGMultipleBirdGenerator alloc] initWithSceneController:scene_controller BoundaryController:boundary_controller SceneObjectDestroyer:scene_object_destroyer] autorelease];
    }
    else if (type == LEAVES){
        return [[[MGMultipleLeafGenerator alloc] initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer] autorelease];
    }
    else {
        return [[[MGMultipleBeeGenerator alloc] initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer] autorelease];
    }
}

- (void)clearObjectsToAdd {
    [self.objectsToAdd removeAllObjects];
}

- (void)loadNewObjectsWaveToAdd {
    [self.objectsToAdd addObjectsFromArray:[self.generator createWave]];
}


- (void)setNextTimeToAppear {
    CGFloat secondsToWait = [self.generator getWaitTimeToNextWave];
    [self.timeController createAndAddNotificationIn:secondsToWait WithObject:self Selector:@selector(getNewObjectsWaveToAdd)];
}


- (void)getNewObjectsWaveToAdd {
    NSArray *newWave = [self.generator createWave];
    [self.objectsToAdd addObjectsFromArray:newWave];
    [self setNextTimeToAppear];
    
}

- (void)dealloc {
    [_objectsToAdd release];
    [_generator release];
    [_timeController release];
    [super dealloc];
}

@end
