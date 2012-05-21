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
    NSMutableArray *arrayWithLeavesWave = [[NSMutableArray alloc] init];
    NSInteger leavesToAppear = RANDOM_INT(MIN_LEAVES_TO_APPEAR, MAX_LEAVES_TO_APPEAR);
    NSInteger leavesCount;
    for (leavesCount = 0; leavesCount < leavesToAppear; leavesCount++) {
        MGLeaf *leafToAdd = [[MGLeaf alloc] initWithSceneController:self.sceneController SceneObjectDestroyer:self.sceneObjectDestroyer TimeController:nil];  
        [arrayWithLeavesWave addObject:leafToAdd];
        [leafToAdd release];
    }
    return [arrayWithLeavesWave autorelease];
}

- (NSInteger)getWaitTimeToNextWave {
    return RANDOM_INT(MINSEC_TO_LEAF_APPEARANCE, MAXSEC_TO_LEAF_APPEARANCE);
}

- (void)dealloc {
    [_sceneController release];
    [_sceneObjectDestroyer release];
    [super dealloc];
}



@end

