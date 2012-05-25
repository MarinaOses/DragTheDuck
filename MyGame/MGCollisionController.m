//
//  MGCollisionController.m
//  MyGame
//
//  Created by Marina Osés Merino on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGCollisionController.h"

@implementation MGCollisionController

- (id)init {
    self = [super init];
    if (self) {
        sceneObjects = [[NSArray alloc] init];
        allColliders = [[NSMutableArray alloc] init];
        collidersToCheck = [[NSMutableArray alloc] init];
    }
    return self;
}

//Se crean las tablas allColliders y collidersToCheck a partir de sceneObjects
- (void)handleCollisions {
    [allColliders removeAllObjects];
    [collidersToCheck removeAllObjects];
    for (MGSceneObject *obj in sceneObjects) {
        if (obj.collider != nil) {
            [allColliders addObject:obj];
            if (obj.collider.checkForCollision) {
                [collidersToCheck addObject:obj];
            }
        }
    }
    //Se comprueba si alguno de los objetos de la escena está colisionando con otro
    for (MGSceneObject *colliderObject in collidersToCheck) {
        for (MGSceneObject *collideeObject in allColliders) {
            //Si los objetos coinciden se pasa a la siguiente vuelta
            if (colliderObject == collideeObject) {
                continue;
            }
            if ([colliderObject.collider doesCollideWithCollider:collideeObject.collider]) {
                if ([colliderObject conformsToProtocol:@protocol(MGCollisionable)]) {
                    id<MGCollisionable>adaptedColliderObject = (id<MGCollisionable>)colliderObject;
                    [adaptedColliderObject collideWith:collideeObject];
                }
            }
        }
    }
}

- (void)dealloc {
    [sceneObjects release];
    [allColliders release];
    [collidersToCheck release];
    [super dealloc];
}


@end
