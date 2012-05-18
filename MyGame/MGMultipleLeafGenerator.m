//
//  MGMultipleLeafGenerator.m
//  MyGame
//
//  Created by Marina Osés Merino on 18/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMultipleLeafGenerator.h"

#import "MGSceneController.h"

@implementation MGMultipleLeafGenerator

@synthesize sceneController = _sceneController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize timeController = _timeController;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer TimeController:(MGTimeController *)time_controller {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.sceneObjectDestroyer = scene_object_destroyer;
        self.timeController = time_controller;
    }
    return self;
}


//Crea una oleada de pájaros rojos, cuyo número de objetos se calcula aleatoriamente entre un mínimo y un máximo definidos en el archivo de configuración
- (NSArray *)createWave {
    NSMutableArray *arrayWithLeavesWave = [[NSMutableArray alloc] init];
    NSInteger leavesToAppear = RANDOM_INT(MIN_BIRDS_TO_APPEAR, MAX_BIRDS_TO_APPEAR);
    NSInteger leavesCount;
    for (leavesCount = 0; leavesCount < leavesToAppear; leavesCount++) {
        MGLeaf *leafToAdd = [[MGLeaf alloc] initWithSceneController:self.sceneController SceneObjectDestroyer:self.sceneObjectDestroyer TimeController:self.timeController];  
        [arrayWithLeavesWave addObject:leafToAdd];
        [leafToAdd release];
    }
    return [arrayWithLeavesWave autorelease];
}

- (NSInteger)getWaitTimeToNextWave {
    
}

- (void)dealloc {
    [_sceneController release];
    [_sceneObjectDestroyer release];
    [_timeController release];
    [super dealloc];
}



@end

