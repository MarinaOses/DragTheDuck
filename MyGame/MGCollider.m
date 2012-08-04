//
//  MGCollider.m
//  MyGame
//
//  Created by Marina Osés Merino on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGCollider.h"

@interface MGCollider()
- (BOOL)doesCollideWithVertexes:(CGFloat *)verts vertexCount:(NSInteger)vertex_count vertexSize:(NSInteger)vertex_size transformMatrix:(CGFloat *)tranform_matrix;

@end


#pragma mark circle mesh
static NSInteger MGCircleVertexSize = 2;
static NSInteger MGCircleColorSize = 4;
static GLenum MGCircleRenderStyle = GL_LINE_LOOP;
static NSInteger MGCircleOutlineVertexesCount = 20;
static CGFloat MGCircleOutlineVertexes[40] = {1.0000,0.0000,0.9511,0.3090,0.8090,0.5878,0.5878,0.8090,0.3090,0.9511,0.0000,1.0000,-0.3090,0.9511,-0.5878,0.8090,-0.8090,0.5878,-0.9511,0.3090,-1.0000,0.0000,-0.9511,-0.3090,-0.8090,-0.5878,-0.5878,-0.8090,-0.3090,-0.9511,-0.0000,-1.0000,0.3090,-0.9511,0.5878,-0.8090,0.8090,-0.5878,0.9511,-0.3090};

static CGFloat MGCircleColorValues[80] = 
{   1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0, 
    1.0,1.0,1.0,1.0} ;


@implementation MGCollider

@synthesize transformedCentroid;
@synthesize checkForCollision;
@synthesize maxRadius;


- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        if (DEBUG_DRAW_COLLIDERS) {
            self.mesh = [[MGMesh alloc] initWithVertexes:MGCircleOutlineVertexes vertexCount:MGCircleOutlineVertexesCount vertexSize:MGCircleVertexSize renderStyle:MGCircleRenderStyle];
            self.mesh.colorSize = MGCircleColorSize;
            self.mesh.colors = MGCircleColorValues;
        }
        self.checkForCollision = NO;
        self.maxRadius = 0.0;
        self.transformedCentroid = MGPointZero();
    }
    return self;
}


- (void)updateWith:(MGSceneObject *)scene_object {
    if (scene_object == nil) {
        return;
    }
    transformedCentroid = MGPointMatrixMultiply(scene_object.matrix, scene_object.mesh.centroid);
    maxRadius = scene_object.scale.x;
    if (maxRadius < scene_object.scale.y) {
        maxRadius = scene_object.scale.y;
    }
    if ((scene_object.mesh.vertexSize > 2) && (maxRadius < scene_object.scale.z)) {
        maxRadius = scene_object.scale.z;
    }
    maxRadius *= scene_object.mesh.radius;
    self.translation = transformedCentroid;
    self.scale = MGPointMake(scene_object.mesh.radius * scene_object.scale.x, scene_object.mesh.radius * scene_object.scale.y, 0.0);
}

//Devuelve YES cuando han colisionado dos determinados colliders
//- (BOOL)doesCollideWithCollider:(MGCollider *)aCollider {
//    CGFloat collisionDistance = self.maxRadius + aCollider.maxRadius;
//    CGFloat objectDistance = MGPointDistance(self.translation, aCollider.translation);
//    if (objectDistance < collisionDistance) {
//        return YES;
//    }
//    return NO;
//}

- (BOOL)doesCollideWithSceneObject:(MGSceneObject *)scene_object {
    return [self doesCollideWithVertexes:scene_object.mesh.vertexes vertexCount:scene_object.mesh.vertexCount vertexSize:scene_object.mesh.vertexSize transformMatrix:scene_object.matrix];
}

- (BOOL)doesCollideWithVertexes:(CGFloat *)verts vertexCount:(NSInteger)vertex_count vertexSize:(NSInteger)vertex_size transformMatrix:(CGFloat *)tranform_matrix {
    if (verts == nil) {
        NSLog(@"CUIDADOOOOO");
    }
    NSInteger index;
    for (index = 0; index < vertex_count; index++) {
        NSInteger position = index * vertex_size;
        MGPoint aVert;
        if (vertex_size > 2) {
            aVert = MGPointMake(verts[position], verts[position + 1], verts[position + 2]);
        }
        else {
            aVert = MGPointMake(verts[position], verts[position + 1], 0.0);
        }
        aVert = MGPointMatrixMultiply(tranform_matrix, aVert);
        CGFloat distance = MGPointDistance(aVert, self.translation);
        if (distance < self.maxRadius) {
            return YES;
        }
    }
    return NO;
}

-(void)render
{
	glPushMatrix();
	glLoadIdentity();
	glTranslatef(self.translation.x, self.translation.y, self.translation.z);
	glScalef(self.scale.x, self.scale.y, self.scale.z);
	[self.mesh render];	
	glPopMatrix();
}

@end
