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
@end

@implementation MGLeaf

@synthesize timeController = _timeController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;

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
        
    }
    return self;
}

- (MGPoint)randomTranslation:(CGRect)leaf_mesh_bounds {
    CGFloat screenY = CGRectGetHeight(self.sceneController.openGLView.window.frame);
    CGFloat screenX = CGRectGetWidth(self.sceneController.openGLView.window.frame);
    CGFloat meshBoundsMidX = leaf_mesh_bounds.size.width/2.0;
    CGFloat meshBoundsMidY = leaf_mesh_bounds.size.height/2.0;
    //Para que no se salga de la pantalla se suma o resta la mitad del tamaño de la hoja
    CGFloat randomX = RANDOM_INT(0+(int)meshBoundsMidX, (int)screenY-(int)meshBoundsMidX) - screenY/2.0;
    CGFloat randomY = RANDOM_INT(0+(int)meshBoundsMidY, (int)screenX-(int)meshBoundsMidY) - screenX/2.0;
    return MGPointMake(randomX, randomY, 0.0);
}

- (MGPoint)randomRotation {
    int randomDegrees = RANDOM_INT(0, MAX_LEAF_ROTATION);
    return MGPointMake(0.0, 0.0, randomDegrees);
}

- (MGPoint)randomScale {
    int randomScale = RANDOM_INT(MIN_LEAF_SCALE, MAX_LEAF_SCALE);
    return MGPointMake(randomScale, randomScale, 1.0);
}

- (void)removeIfItIsOutOfTime {
//    if (self.timeController.updateCounter == MAXSEC_TO_LEAF_DISAPPEARANCE){
//        [self.sceneObjectDestroyer markToRemoveSceneObject:self];
//    }
}

- (void)update {
    [self removeIfItIsOutOfTime];
    [super update];
}



- (void)dealloc {
    [_timeController release];
    [_sceneObjectDestroyer release];
    [super dealloc];
}





@end
