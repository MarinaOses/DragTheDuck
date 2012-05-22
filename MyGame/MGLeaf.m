//
//  Leaf.m
//  MyGame
//
//  Created by Marina Osés Merino on 17/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGLeaf.h"

#import "MGSceneController.h"

@interface MGLeaf()
- (MGPoint)randomTranslation:(CGRect)leaf_mesh_bounds;
- (MGPoint)randomRotation;
- (MGPoint)randomScale;
- (CGFloat)randomLifeTime;
@end

@implementation MGLeaf

@synthesize timeController = _timeController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize lifeTimeInUpdates;

static NSInteger MGLeafVertexSize = 2;
static NSInteger MGLeafColorSize = 4;
static GLenum MGLeafRenderStyle = GL_TRIANGLE_STRIP;
static NSInteger MGLeafVertexCount = 4;
static CGFloat MGLeafVertexes[8] = {
    -0.5, -0.5, 
    0.5, -0.5,
    -0.5, 0.5,
    0.5, 0.5
};
static CGFloat MGDuckColorValues[16] ={
    0.0, 1.0, 0.0, 1.0, 
    0.0, 1.0, 0.0, 1.0, 
    0.0, 1.0, 0.0, 1.0, 
    0.0, 1.0, 0.0, 1.0
};


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer TimeController:(MGTimeController *)time_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        MGMesh *meshToAssign = [[MGMesh alloc] initWithVertexes:MGLeafVertexes vertexCount:MGLeafVertexCount vertexSize:MGLeafVertexSize renderStyle:MGLeafRenderStyle];
        self.mesh = meshToAssign;
        [meshToAssign release];
        self.mesh.colorSize = MGLeafColorSize;
        self.mesh.colors = MGDuckColorValues;
        self.translation = [self randomTranslation:self.meshBounds];
        self.rotation = [self randomRotation];
        self.scale = [self randomScale];
        
        self.timeController = time_controller;
        self.sceneObjectDestroyer = scene_object_destroyer;
        
        self.lifeTimeInUpdates = (int)([self randomLifeTime] * MAXIMUM_FRAME_RATE);
    }
    return self;
}

- (MGPoint)randomTranslation:(CGRect)leaf_mesh_bounds {
    CGFloat screenY = CGRectGetHeight(self.sceneController.openGLView.window.frame);
    CGFloat screenX = CGRectGetWidth(self.sceneController.openGLView.window.frame);
    CGFloat meshBoundsMidX = leaf_mesh_bounds.size.width/2.0;
    CGFloat meshBoundsMidY = leaf_mesh_bounds.size.height/2.0;
    //Para que no se salga de la pantalla se suma o resta la mitad del tamaño de la hoja
    CGFloat randomX = RANDOM_FLOAT(meshBoundsMidX, screenY-meshBoundsMidX) - screenY/2.0;
    CGFloat randomY = RANDOM_FLOAT(meshBoundsMidY, screenX-meshBoundsMidY) - screenX/2.0;
    return MGPointMake(randomX, randomY, 0.0);
}

- (MGPoint)randomRotation {
    int randomDegrees = RANDOM_FLOAT(0.0, MAX_LEAF_ROTATION);
    return MGPointMake(0.0, 0.0, randomDegrees);
}

- (MGPoint)randomScale {
    int randomScale = RANDOM_FLOAT(MIN_LEAF_SCALE, MAX_LEAF_SCALE);
    return MGPointMake(randomScale, randomScale, 1.0);
}

- (CGFloat)randomLifeTime {
    return RANDOM_FLOAT(MINSEC_TO_LEAF_DISAPPEARANCE, MAXSEC_TO_LEAF_DISAPPEARANCE);
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
    [_timeController release];
    [_sceneObjectDestroyer release];
    [super dealloc];
}





@end
