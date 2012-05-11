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

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
    }
    return self;
}


//Crea una oleada de pájaros rojos, cuyo número de objetos se calcula aleatoriamente entre un mínimo y un máximo definidos en el archivo de configuración
- (NSArray *)createBirdsWave {
    NSMutableArray *arrayWithBirdsWave = [[NSMutableArray alloc] init];
    NSInteger birdsToAppear = RANDOM_INT(MIN_BIRDS_TO_APPEAR, MAX_BIRDS_TO_APPEAR);
    NSInteger birdsCount;
    for (birdsCount = 0; birdsCount < birdsToAppear; birdsCount++) {
        MGBird *birdToAdd = [[MGBird alloc] initRandomWithSceneController:self.sceneController];
        [arrayWithBirdsWave addObject:birdToAdd];
        [birdToAdd release];
    }
    return [arrayWithBirdsWave autorelease];
}

- (void)dealloc {
    [_sceneController release];
    [super dealloc];
}



@end
