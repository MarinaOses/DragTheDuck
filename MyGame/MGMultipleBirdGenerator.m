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
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.sceneObjectDestroyer = scene_object_destroyer;
    }
    return self;
}


//Crea una oleada de pájaros rojos, cuyo número de objetos se calcula aleatoriamente entre un mínimo y un máximo definidos en el archivo de configuración
- (NSArray *)createWave {
    NSMutableArray *arrayWithBirdsWave = [[NSMutableArray alloc] init];
    NSInteger birdsToAppear = RANDOM_INT(MIN_BIRDS_TO_APPEAR, MAX_BIRDS_TO_APPEAR);
    NSInteger birdsCount;
    for (birdsCount = 0; birdsCount < birdsToAppear; birdsCount++) {
        MGBird *birdToAdd = [[MGBird alloc] initWithSceneController:self.sceneController SceneObjectDestroyer:self.sceneObjectDestroyer];
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
    [_sceneObjectDestroyer release];
    [super dealloc];
}



@end
