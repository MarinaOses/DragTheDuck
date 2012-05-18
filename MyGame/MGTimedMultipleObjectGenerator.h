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

@class MGSceneController;

@interface MGTimedMultipleObjectGenerator : NSObject {
    NSMutableArray *_objectsToAdd;
    id<MGGenerator> _generator;
}

@property (nonatomic, retain) NSMutableArray *objectsToAdd;
@property (nonatomic, retain) id<MGGenerator> generator;


- (id)initWithMGGenerator:(id<MGGenerator>)mg_generator;
+ (id<MGGenerator>)createSpecificMGGenerator:(int)type WithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer TimeController:(MGTimeController *)time_controller;
- (void)loadNewObjectsWaveToAdd;
- (void)setNextTime;
- (void)clearObjectsToAdd;
- (void)stopTimeController;


@end
