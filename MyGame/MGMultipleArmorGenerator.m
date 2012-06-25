//
//  MGArmorGenerator.m
//  MyGame
//
//  Created by Marina Osés Merino on 01/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMultipleArmorGenerator.h"

#import "MGSceneController.h"

@implementation MGMultipleArmorGenerator

@synthesize sceneController = _sceneController;
@synthesize boundaryController = _boundaryController;
@synthesize sceneObjects = _sceneObjects;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjects:(NSMutableArray *)scene_objects {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.boundaryController = boundary_controller;
        self.sceneObjects = scene_objects;
    }
    return self;
}


- (NSArray *)createWave {
    NSMutableArray *arrayWithArmorsWave = [[NSMutableArray alloc] init];
    for (MGSceneObject *obj in self.sceneObjects) {
        if ([obj isKindOfClass:[MGDuck class]]) {
            MGDuck *aDuck = (MGDuck *)obj;
            MGArmor *armorToAdd = [[MGArmor alloc] initWithSceneController:self.sceneController BoundaryController:self.boundaryController ToPutItOnDuck:aDuck];
            [arrayWithArmorsWave addObject:armorToAdd];
            [armorToAdd release];
            //Los patos con armadura no pueden arrastrarse ni colisionar
            aDuck.draggeable = NO;
            aDuck.collider.checkForCollision = NO;
        }
    }
    return [arrayWithArmorsWave autorelease];
}

- (CGFloat)getWaitTimeToNextWave {
    return 0.0;
}



- (void)dealloc {
    [_sceneController release];
    [_boundaryController release];
    [_sceneObjects release];
    [super dealloc];
}

@end
