//
//  MultipleArrowGenerator.m
//  MyGame
//
//  Created by Marina Osés Merino on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMultipleArrowGenerator.h"

#import "MGSceneController.h"

@implementation MGMultipleArrowGenerator

@synthesize sceneController = _sceneController;
@synthesize boundaryController =_boundaryController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize sceneObjects = _sceneObjects;



- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer SceneObjects:(NSMutableArray *)scene_objects {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.boundaryController = boundary_controller;
        self.sceneObjectDestroyer = scene_object_destroyer;
        self.sceneObjects = scene_objects;
    }
    return self;
}


//Crea una oleada de pájaros rojos, cuyo número de objetos se calcula aleatoriamente entre un mínimo y un máximo definidos en el archivo de configuración
- (NSArray *)createWave {
    NSMutableArray *arrayWithArrowsWave = [[NSMutableArray alloc] init];
    NSInteger arrowsToAppear = RANDOM_INT(MIN_ARROWS_TO_APPEAR, MAX_ARROWS_TO_APPEAR);
    NSInteger arrowsCount;
    for (arrowsCount = 0; arrowsCount < arrowsToAppear; arrowsCount++) {
        MGArrow *arrowToAdd = [[MGArrow alloc] initWithSceneController:self.sceneController BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyer SceneObjects:self.sceneObjects]; 
        [arrayWithArrowsWave addObject:arrowToAdd];
        [arrowToAdd release];
    }
    return [arrayWithArrowsWave autorelease];
}

- (CGFloat)getWaitTimeToNextWave {
    return RANDOM_FLOAT(MINSEC_TO_ARROW_APPEARANCE, MAXSEC_TO_ARROW_APPEARANCE);    
}


- (void)dealloc {
    [_sceneController release];
    [_boundaryController release];
    [_sceneObjectDestroyer release];
    [_sceneObjects release];
    [super dealloc];
}



@end
