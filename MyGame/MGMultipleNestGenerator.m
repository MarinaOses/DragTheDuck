//
//  MGMultipleNestGenerator.m
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMultipleNestGenerator.h"

#import "MGSceneController.h"

@implementation MGMultipleNestGenerator

@synthesize sceneController = _sceneController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize scoreTransmitter = _scoreTransmitter;
@synthesize transformationController = _transformationController;
@synthesize boundaryController = _boundaryController;
@synthesize finger = _finger;
@synthesize sceneObjects = _sceneObjects;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTrasnmitter:(MGScoreTransmitter *)score_transmitter SceneObjects:(NSMutableArray *)scene_objects {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.sceneObjectDestroyer = scene_object_destroyer;
        self.scoreTransmitter = score_transmitter;
        self.boundaryController = boundary_controller;
        self.sceneObjects = scene_objects;
        _transformationController = [[MGTransformationController alloc] initWithSceneController:self.sceneController BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyer SceneObjects:scene_objects];
        _finger = [[MGFinger alloc] init];
        throwedNestsCount = 0;
    }
    return self;
}


//Crea una oleada de nidos, cuyo número de objetos se calcula aleatoriamente entre un mínimo y un máximo definidos en el archivo de configuración. El intervalo para el random será más pequeño que en el caso de los pájaros.
- (NSArray *)createWave {
    NSInteger minNestsToAppearIncrease = MIN((throwedNestsCount/(NESTS_TO_LEVEL_UP*2)), MIN_NESTS_TO_APPEAR_INCREASE);
    NSInteger maxNestsToAppearIncrease = MIN((throwedNestsCount/NESTS_TO_LEVEL_UP), MAX_NESTS_TO_APPEAR_INCREASE);

    NSInteger down = MIN_NESTS_TO_APPEAR + minNestsToAppearIncrease;
    NSInteger up = MAX_NESTS_TO_APPEAR + maxNestsToAppearIncrease;
    NSInteger nestsToAppear = RANDOM_INT(down, up);
    throwedNestsCount += nestsToAppear;
    

    NSMutableArray *arrayWithNestsWave = [[NSMutableArray alloc] init];
    for (NSInteger nestsCount = 0; nestsCount < nestsToAppear; nestsCount++) {
        MGNest *nestToAdd = [[MGNest alloc] initWithSceneController:self.sceneController BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyer ScoreTrasnmitter:self.scoreTransmitter TransformationController:self.transformationController TouchFinger:self.finger SceneObjects:self.sceneObjects];
        [arrayWithNestsWave addObject:nestToAdd];
        [nestToAdd release];
    }
    return [arrayWithNestsWave autorelease];
}

- (CGFloat)getWaitTimeToNextWave {
    return RANDOM_FLOAT(MINSEC_TO_NEST_APPEARANCE, MAXSEC_TO_NEST_APPEARANCE);
}


- (void)dealloc {
    [_sceneController release];
    [_sceneObjectDestroyer release];
    [_scoreTransmitter release];
    [_transformationController release];
    [_boundaryController release];
    [_finger release];
    [_sceneObjects release];
    [super dealloc];
}


@end
