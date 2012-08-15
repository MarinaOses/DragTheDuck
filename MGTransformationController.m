//
//  MGTransformationController.m
//  MyGame
//
//  Created by Marina Osés Merino on 21/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTransformationController.h"


#import "MGSceneController.h"

@implementation MGTransformationController
@synthesize sceneObjects = _sceneObjects;
@synthesize duckWhoStartsTheTransformation = _duckWhoStartsTheTransformation;
@synthesize sceneController =_sceneController;
@synthesize boundaryController = _boundaryController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_objects_destroyer SceneObjects:(NSMutableArray *)scene_objects {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.boundaryController = boundary_controller;
        self.sceneObjectDestroyer = scene_objects_destroyer;
        self.sceneObjects = scene_objects;
    }
    return self;
}

- (void)spawnBeeFrom:(MGDuck *)duck {
    self.duckWhoStartsTheTransformation = duck;
    MGTransformer *transformerToAdd = [[MGTransformer alloc] initWithDuck:duck];
    [self.sceneObjects addObject:transformerToAdd];
    [transformerToAdd release];
}

- (void)spawnDuckFrom:(MGTransformer *)transformer {
    MGDuck *duckToAdd = self.duckWhoStartsTheTransformation;
    duckToAdd.translation = transformer.translation;
    duckToAdd.taken = transformer.taken;
    if (duckToAdd.taken) {
        [duckToAdd stop];
    }
    else {
        [duckToAdd start];
    }
    [self.sceneObjects addObject:duckToAdd];
    
    self.duckWhoStartsTheTransformation = nil;
    
}

- (void)spawnEggFrom:(MGDuck *)killed_duck {
    MGEgg *eggToAdd = [[MGEgg alloc] initWithSceneController:self.sceneController BoundaryController:self.boundaryController DropsFromKilledDuck:killed_duck];
    [self.sceneObjects addObject:eggToAdd];
    [eggToAdd release];
}

- (void)spawnFeathersFrom:(MGMobileObject *)killed_mobile_object WithColor:(NSInteger)color{

    MGFeathers *feathersToAdd = [[MGFeathers alloc] initWithSceneController:self.sceneController SceneObjectDestroyer:self.sceneObjectDestroyer Translation:killed_mobile_object.translation Scale:killed_mobile_object.scale Color:color];
  
    [self.sceneObjects addObject:feathersToAdd];
    [feathersToAdd release];
}


- (void)dealloc {
    [_sceneObjects release];
    if (_duckWhoStartsTheTransformation != nil) {
        [_duckWhoStartsTheTransformation release];
    }
    [_sceneController release];
    [_boundaryController release];
    [_sceneObjectDestroyer release];
    [super dealloc];
}

@end
