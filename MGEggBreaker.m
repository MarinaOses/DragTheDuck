//
//  MGEggBreaker.m
//  MyGame
//
//  Created by Marina Osés Merino on 28/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGEggBreaker.h"

#import "MGLifesController.h"

@implementation MGEggBreaker
@synthesize sceneController = _sceneController;
@synthesize boundaryController = _boundaryController;
@synthesize lifesController = _lifesController;
@synthesize sceneObjects = _sceneObjects;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller LifesController:(MGLifesController *)lifes_controller SceneObjects:(NSMutableArray *)scene_objects {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.boundaryController = boundary_controller;
        self.lifesController = lifes_controller;
        self.sceneObjects = scene_objects;
    }
    return self;
}

- (void)breakEgg:(MGEgg *)egg {
    MGBrokenEgg *brokenEgg = [[MGBrokenEgg alloc] initWithSceneController:self.sceneController BoundaryController:self.boundaryController LifesController:self.lifesController ComesFromEgg:egg];
    [self.sceneObjects addObject:brokenEgg];
    [[MGOpenALSoundController sharedSoundController].brokenEggSound playWithVolume:1.0f];
    [brokenEgg release];
}

- (void)dealloc {
    [_sceneController release];
    [_boundaryController release];
    [_lifesController release];
    [_sceneObjects release];
    [super dealloc];
}

@end
