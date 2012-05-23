//
//  MGStoppedObject.m
//  MyGame
//
//  Created by Marina Osés Merino on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGStoppedObject.h"

#import "MGSceneController.h"





@implementation MGStoppedObject

@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize lifeTimeInUpdates;

static NSInteger MGStoppedVertexSize = 2;
static NSInteger MGStoppedColorSize = 4;
static GLenum MGStoppedRenderStyle = GL_TRIANGLE_STRIP;
static NSInteger MGStoppedVertexCount = 4;
static CGFloat MGStoppedVertexes[8] = {
    -0.5, -0.5, 
    0.5, -0.5,
    -0.5, 0.5,
    0.5, 0.5
};

static CGFloat MGStoppedColorValues[16] ={
    0.0, 0.0, 0.0, 1.0, 
    0.0, 0.0, 0.0, 1.0, 
    0.0, 0.0, 0.0, 1.0, 
    0.0, 0.0, 0.0, 1.0
};

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        MGMesh *meshToAssign = [[MGMesh alloc] initWithVertexes:MGStoppedVertexes vertexCount:MGStoppedVertexCount vertexSize:MGStoppedVertexSize renderStyle:MGStoppedRenderStyle];
        self.mesh = meshToAssign;
        [meshToAssign release];
        self.mesh.colorSize = MGStoppedColorSize;
        self.mesh.colors = MGStoppedColorValues;
        self.translation = MGPointZero();
        self.rotation = MGPointZero();
        self.scale = MGPointZero();
        
        
        self.lifeTimeInUpdates = 0;
        self.sceneObjectDestroyer = scene_object_destroyer;
        
    }
    return self;
}

- (void)removeMySelf {
    [self.sceneObjectDestroyer markToRemoveSceneObject:self];
}

- (void)update {
    self.lifeTimeInUpdates--;
    if (self.lifeTimeInUpdates <= 0) {
        [self removeMySelf];
    }
    [super update];
}



- (void)dealloc {
    [_sceneObjectDestroyer release];
    [super dealloc];
}




@end
