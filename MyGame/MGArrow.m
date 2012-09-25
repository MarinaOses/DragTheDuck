//
//  MGArrow.m
//  MyGame
//
//  Created by Marina Osés Merino on 11/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGArrow.h"


#import "MGSceneController.h"

@implementation MGArrow
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize sceneObjects = _sceneObjects;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer SceneObjects:(NSMutableArray *)scene_objects {
    self = [super initWithSceneController:scene_controller BoundaryController:boundary_controller RangeForScale:NSMakeRange(MIN_ARROW_SCALE, MAX_ARROW_SCALE) RangeForSpeed:NSMakeRange(MIN_ARROW_SPEED, MAX_ARROW_SPEED) Direction:-1];
    if (self) {
        self.sceneObjectDestroyer = scene_object_destroyer;
        self.sceneObjects = scene_objects;
        timeBeforeTheBirdAppearsInUpdates = SEC_BEFORE_THE_BIRD_APPEARS * MAXIMUM_FRAME_RATE;
        throwedBird = NO;
        self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_arrow.png"];
        self.translation = [self randomTranslationWithMeshBounds:self.meshBounds OnSide:-self.movingDirection];
    }
    return self;
}


- (void)update {
    if (timeBeforeTheBirdAppearsInUpdates <= 0 && !throwedBird) {
        MGBird *bird = [[MGBird alloc] initWithSceneController:self.sceneController BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyer AppearanceHeight:self.translation.y];
        [bird update];
        [bird render];
        [self.sceneObjects addObject:bird];
        [bird release];
        throwedBird = YES;
        [self.sceneObjectDestroyer markToRemoveSceneObject:self];
    }
    else {
        timeBeforeTheBirdAppearsInUpdates--;
    }
    [super update];
}


- (void)dealloc {
    [_sceneObjectDestroyer release];
    [_sceneObjects release];
    [super dealloc];
}

@end
