//
//  Leaf.m
//  MyGame
//
//  Created by Marina Osés Merino on 17/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Leaf.h"

@implementation Leaf

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


- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        MGMesh *meshToAssign = [[MGMesh alloc] initWithVertexes:MGLeafVertexes vertexCount:MGLeafVertexCount vertexSize:MGLeafVertexSize renderStyle:MGLeafRenderStyle];
        self.mesh = meshToAssign;
        [meshToAssign release];
        self.translation = [self randomTranslation];
        self.rotation = [self randomRotation];
        self.scale = [self randomScale];
        
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}





@end
