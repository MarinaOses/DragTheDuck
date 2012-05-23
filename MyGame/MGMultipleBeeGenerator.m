//
//  MGMultipleBeeGenerator.m
//  MyGame
//
//  Created by Marina Osés Merino on 23/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMultipleBeeGenerator.h"

#import "MGSceneController.h"

@implementation MGMultipleBeeGenerator
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
    NSMutableArray *arrayWithBeesWave = [[NSMutableArray alloc] init];
    NSInteger beesToAppear = RANDOM_INT(MIN_BEES_TO_APPEAR, MAX_BEES_TO_APPEAR);
    NSInteger beesCount;
    for (beesCount = 0; beesCount < beesToAppear; beesCount++) {
        MGBee *beeToAdd = [[MGBee alloc] initWithSceneController:self.sceneController SceneObjectDestroyer:self.sceneObjectDestroyer];  
        [arrayWithBeesWave addObject:beeToAdd];
        [beeToAdd release];
    }
    return [arrayWithBeesWave autorelease];
}

- (CGFloat)getWaitTimeToNextWave {
    return RANDOM_FLOAT(MINSEC_TO_BEE_APPEARANCE, MAXSEC_TO_BEE_APPEARANCE);
}

- (void)dealloc {
    [_sceneController release];
    [_sceneObjectDestroyer release];
    [super dealloc];
}


@end
