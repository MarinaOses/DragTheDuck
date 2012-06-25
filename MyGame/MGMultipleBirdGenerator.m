//
//  MultipleBirdGenerator.m
//  MyGame
//
//  Created by Marina Osés Merino on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMultipleBirdGenerator.h"

#import "MGSceneController.h"

@implementation MGMultipleBirdGenerator

@synthesize sceneController = _sceneController;
@synthesize boundaryController =_boundaryController;
- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.boundaryController = boundary_controller;
    }
    return self;
}


//Crea una oleada de pájaros rojos, cuyo número de objetos se calcula aleatoriamente entre un mínimo y un máximo definidos en el archivo de configuración
- (NSArray *)createWave {
    NSMutableArray *arrayWithBirdsWave = [[NSMutableArray alloc] init];
    NSInteger birdsToAppear = RANDOM_INT(MIN_BIRDS_TO_APPEAR, MAX_BIRDS_TO_APPEAR);
    NSInteger birdsCount;
    for (birdsCount = 0; birdsCount < birdsToAppear; birdsCount++) {
        MGBird *birdToAdd = [[MGBird alloc] initWithSceneController:self.sceneController BoundaryController:self.boundaryController];
        [arrayWithBirdsWave addObject:birdToAdd];
        [birdToAdd release];
    }
    return [arrayWithBirdsWave autorelease];
}

- (CGFloat)getWaitTimeToNextWave {
    return RANDOM_FLOAT(MINSEC_TO_BIRD_APPEARANCE, MAXSEC_TO_BIRD_APPEARANCE);    
}


- (void)dealloc {
    [_sceneController release];
    [_boundaryController release];
    [super dealloc];
}



@end
