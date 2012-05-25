//
//  MGCollider.m
//  MyGame
//
//  Created by Marina Osés Merino on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGCollider.h"

@implementation MGCollider

@synthesize checkForCollision;
@synthesize maxRadius;

//- (id)initWithSceneController:(MGSceneController *)scene_controller {
//    self = [super initWithSceneController:scene_controller];
//    if (self) {
//        <#initializations#>
//    }
//    return self;
//}


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
    self.translation = transformedCentroid;
    self.scale = MGPointMake(scene_object.mesh.radius * scene_object.scale.x, scene_object.mesh.radius * scene_object.scale.y, 0.0);
}

//Devuelve YES cuando han colisionado dos determinados colliders
- (BOOL)doesCollideWithCollider:(MGCollider *)aCollider {
    CGFloat collisionDistance = self.maxRadius + aCollider.maxRadius;
    CGFloat objectDistance = MGPointDistance(self.translation, aCollider.translation);
    if (objectDistance < collisionDistance) {
        return YES;
    }
    return NO;
}

@end
