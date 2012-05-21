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

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.sceneObjectDestroyer = scene_object_destroyer;
    }
    return self;
}


//Crea una oleada de patos, cuyo número de objetos se calcula aleatoriamente entre un mínimo y un máximo definidos en el archivo de configuración. El intervalo para el random será más pequeño que en el caso de los pájaros.
- (NSArray *)createWave {
    NSMutableArray *arrayWithDucksWave = [[NSMutableArray alloc] init];
    NSInteger ducksToAppear = RANDOM_INT(MIN_DUCKS_TO_APPEAR, MAX_DUCKS_TO_APPEAR);
    NSInteger ducksCount;
    for (ducksCount = 0; ducksCount < ducksToAppear; ducksCount++) {
        MGDuck *duckToAdd = [[MGDuck alloc] initWithSceneController:self.sceneController SceneObjectDestroyer:self.sceneObjectDestroyer];
        [arrayWithDucksWave addObject:duckToAdd];
        [duckToAdd release];
    }
    return [arrayWithDucksWave autorelease];
}

- (NSInteger)getWaitTimeToNextWave {
    return RANDOM_INT(MINSEC_TO_DUCK_APPEARANCE, MAXSEC_TO_DUCK_APPEARANCE);
}


- (void)dealloc {
    [_sceneController release];
    [_sceneObjectDestroyer release];
    [super dealloc];
}


@end