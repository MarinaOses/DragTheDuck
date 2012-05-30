//
//  MGTakenLeavesButtonShowerLayer.m
//  MyGame
//
//  Created by Marina Osés Merino on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTakenLeavesButtonShowerLayer.h"


static NSInteger MGShowerLayerVertexSize = 2;
static NSInteger MGShowerLayerColorSize = 4;
static GLenum MGShowerLayerRenderStyle = GL_TRIANGLE_STRIP;
static NSInteger MGShowerLayerVertexCount = 4;
static CGFloat MGShowerLayerVertexes[8] = {
    -0.5, -0.5, 
    0.5, -0.5,
    -0.5, 0.5,
    0.5, 0.5
};

static CGFloat MGShowerLayerdColorValues[16] ={
    0.0, 0.0, 0.0, 0.5, 
    0.0, 0.0, 0.0, 0.5, 
    0.0, 0.0, 0.0, 0.5, 
    0.0, 0.0, 0.0, 0.5
};


@implementation MGTakenLeavesButtonShowerLayer

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        //Translation, rotation y scale se asignarán en el botón, ya que tiene que estar en el mismo sitio
        MGMesh *meshToAssign = [[MGMesh alloc] initWithVertexes:MGShowerLayerVertexes vertexCount:MGShowerLayerVertexCount vertexSize:MGShowerLayerVertexSize renderStyle:MGShowerLayerRenderStyle];
        self.mesh = meshToAssign;
        [meshToAssign release];
        self.mesh.colors = MGShowerLayerdColorValues;
        self.mesh.colorSize = MGShowerLayerColorSize;
    }
    return self;
}

- (void)decreaseHeight {
    self.scale = MGPointMake(self.scale.x, self.scale.y - self.scale.y/MAX_TAKEN_LEAVES, self.scale.z);
    CGFloat heightToDecrease = (CGRectGetHeight(self.meshBounds)/MAX_TAKEN_LEAVES)/2;
    self.translation = MGPointMake(self.translation.x, self.translation.y + heightToDecrease, self.translation.z);
}

- (void)dealloc {
    [super dealloc];
}

@end
