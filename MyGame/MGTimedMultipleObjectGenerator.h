//
//  TimedMultipleBirdGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGMultipleNestGenerator.h"
#import "MGMultipleArrowGenerator.h"
#import "MGMultipleLeafGenerator.h"
#import "MGMultipleBeeGenerator.h"
#import "MGTimeController.h"


#define NESTS 0
#define ARROWS 1
#define LEAVES 2
#define BEES 3


@class MGSceneController;

@interface MGTimedMultipleObjectGenerator : NSObject {
    NSMutableArray *_objectsToAdd;
    id<MGGenerator> _generator;
    MGTimeController *_timeController;
}

@property (nonatomic, retain) NSMutableArray *objectsToAdd;
@property (nonatomic, retain) id<MGGenerator> generator;
@property (nonatomic, retain) MGTimeController *timeController;


- (id)initWithMGGenerator:(id<MGGenerator>)mg_generator TimeController:(MGTimeController *)time_controller;
+ (id<MGGenerator>)createSpecificMGGenerator:(int)type WithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTransmitter:(MGScoreTransmitter *)score_transmitter SceneObjects:(NSMutableArray *)scene_objects;
- (void)loadNewObjectsWaveToAdd;
- (void)setNextTimeToAppear;
- (void)clearObjectsToAdd;

@end
