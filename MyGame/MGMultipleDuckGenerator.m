//
//  MGMultipleDuckGenerator.m
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMultipleDuckGenerator.h"

#import "MGSceneController.h"

@implementation MGMultipleDuckGenerator

@synthesize sceneController = _sceneController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize scoreTransmitter = _scoreTransmitter;
@synthesize transformationController = _transformationController;
@synthesize boundaryController = _boundaryController;
@synthesize finger = _finger;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTrasnmitter:(MGScoreTransmitter *)score_transmitter SceneObjects:(NSMutableArray *)scene_objects {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.sceneObjectDestroyer = scene_object_destroyer;
        self.scoreTransmitter = score_transmitter;
        _transformationController = [[MGTransformationController alloc] initWithSceneObjects:scene_objects];
        self.boundaryController = boundary_controller;
        _finger = [[MGFinger alloc] init];
    }
    return self;
}


//Crea una oleada de patos, cuyo número de objetos se calcula aleatoriamente entre un mínimo y un máximo definidos en el archivo de configuración. El intervalo para el random será más pequeño que en el caso de los pájaros.
- (NSArray *)createWave {
    NSMutableArray *arrayWithDucksWave = [[NSMutableArray alloc] init];
    NSInteger ducksToAppear = RANDOM_INT(MIN_DUCKS_TO_APPEAR, MAX_DUCKS_TO_APPEAR);
    NSInteger ducksCount;
    for (ducksCount = 0; ducksCount < ducksToAppear; ducksCount++) {
        MGDuck *duckToAdd = [[MGDuck alloc] initWithSceneController:self.sceneController BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyer ScoreTrasnmitter:self.scoreTransmitter TransformationController:self.transformationController TouchFinger:self.finger];
        [arrayWithDucksWave addObject:duckToAdd];
        [duckToAdd release];
    }
    return [arrayWithDucksWave autorelease];
}

- (CGFloat)getWaitTimeToNextWave {
    return RANDOM_FLOAT(MINSEC_TO_DUCK_APPEARANCE, MAXSEC_TO_DUCK_APPEARANCE);
}


- (void)dealloc {
    [_sceneController release];
    [_sceneObjectDestroyer release];
    [_scoreTransmitter release];
    [_transformationController release];
    [_boundaryController release];
    [_finger release];
    [super dealloc];
}


@end
