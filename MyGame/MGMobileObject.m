//
//  MGMobileObject.m
//  MyGame
//
//  Created by Marina Osés Merino on 07/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMobileObject.h"

#import "MGSceneController.h"

static NSInteger MGMobileVertexSize = 2;
static NSInteger MGMobileColorSize = 4;
static GLenum MGMobileRenderStyle = GL_TRIANGLE_STRIP;
static NSInteger MGMobileVertexCount = 4;
static CGFloat MGMobileVertexes[8] = {
    -0.5, -0.5, 
    0.5, -0.5,
    -0.5, 0.5,
    0.5, 0.5
};

static CGFloat MGMobileColorValues[16] ={
    0.0, 0.0, 0.0, 1.0, 
    0.0, 0.0, 0.0, 1.0, 
    0.0, 0.0, 0.0, 1.0, 
    0.0, 0.0, 0.0, 1.0
};

@implementation MGMobileObject

@synthesize speed = _speed;
@synthesize boundaryController = _boundaryController;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller RangeForScale:(NSRange)scale_range RangeForSpeed:(NSRange)speed_range Direction:(int)direction {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        MGMesh *meshToAssign = [[MGMesh alloc] initWithVertexes:MGMobileVertexes vertexCount:MGMobileVertexCount vertexSize:MGMobileVertexSize renderStyle:MGMobileRenderStyle];
        self.mesh = meshToAssign;
        [meshToAssign release];
        self.mesh.colorSize = MGMobileColorSize;
        self.mesh.colors = MGMobileColorValues;
        
        self.collider = [[MGCollider alloc] initWithSceneController:scene_controller];

        self.scale = [self randomScaleInRange:scale_range];
        self.translation = [self randomTranslationOnSide:-direction];
        self.speed = [self randomSpeedInRange:speed_range WithDirection:direction];
        
        self.boundaryController = boundary_controller;
    }
    return self;
}

- (MGPoint)randomScaleInRange:(NSRange)scale_range {
    CGFloat randomScale = RANDOM_FLOAT(scale_range.location, scale_range.length);
    return MGPointMake(randomScale, randomScale, 1.0);
}

- (MGPoint)randomTranslationOnSide:(int)side {
    //Se obtiene la anchura de la ventana teniendo en cuenta que en el juego es igual a la altura
    CGFloat maxHeightToAppearance = CGRectGetWidth(self.sceneController.openGLView.window.frame);    
    CGFloat randomAppearanceHeight = RANDOM_FLOAT(0.0, maxHeightToAppearance) - maxHeightToAppearance/2;
    return MGPointMake(side * CGRectGetMidY(self.sceneController.openGLView.window.frame), randomAppearanceHeight, 0.0);
}

- (MGPoint)randomSpeedInRange:(NSRange)speed_range WithDirection:(int)direction {
    GLfloat speedToassign = RANDOM_FLOAT(speed_range.location, speed_range.length)/100.0;
    return MGPointMake(direction * speedToassign, 0.0, 0.0);
}




- (void)update {
    [self.boundaryController checkIfItIsOutOfBondaries:self];
    MGPoint p = self.translation;
    p.x += self.speed.x;
    p.y += self.speed.y;
    p.z += self.speed.z;
    self.translation = p;
    [super update];
}


- (void)dealloc {
    [_boundaryController release];
    [super dealloc];
}

@end
