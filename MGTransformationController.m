//
//  MGTransformationController.m
//  MyGame
//
//  Created by Marina Osés Merino on 21/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTransformationController.h"

@implementation MGTransformationController
@synthesize sceneObjects = _sceneObjects;
@synthesize duckWhoStartsTheTransformation = _duckWhoStartsTheTransformation;


- (id)initWithSceneObjects:(NSMutableArray *)scene_objects {
    self = [super init];
    if (self) {
        self.sceneObjects = scene_objects;
    }
    return self;
}

- (void)spawnBeeFrom:(MGDuck *)duck {
    self.duckWhoStartsTheTransformation = duck;
    MGTransformer *transformerToAdd = [[MGTransformer alloc] initWithSceneController:duck.sceneController BoundaryController:duck.boundaryController SceneObjectDestroyer:duck.sceneObjectDestroyer ScoreTransmitter:duck.scoreTransmitter TransformationController:duck.transformationController StartAtPoint:duck.translation];
    [self.sceneObjects addObject:transformerToAdd];
    [transformerToAdd release];
}

- (void)spawnDuckFrom:(MGTransformer *)transformer {
    MGDuck *duckToAdd = self.duckWhoStartsTheTransformation;
    duckToAdd.translation = transformer.translation;
    [self.sceneObjects addObject:duckToAdd];
    [_duckWhoStartsTheTransformation release];
    _duckWhoStartsTheTransformation = nil;
    
}

- (void)addAnEgg:(MGEgg *)egg {
    [self.sceneObjects addObject:egg];
}


- (void)dealloc {
    [_sceneObjects release];
    if (_duckWhoStartsTheTransformation != nil) {
        [_duckWhoStartsTheTransformation release];
    }
    [super dealloc];
}

@end
