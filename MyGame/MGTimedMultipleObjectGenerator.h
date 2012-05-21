//
//  TimedMultipleBirdGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGMultipleDuckGenerator.h"
#import "MGMultipleBirdGenerator.h"
#import "MGMultipleLeafGenerator.h"
#import "MGTimeController.h"

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
+ (id<MGGenerator>)createSpecificMGGenerator:(int)type WithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer;
- (void)loadNewObjectsWaveToAdd;
- (void)setNextTime;
- (void)clearObjectsToAdd;

@end