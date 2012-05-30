//
//  MGCollisionController.m
//  MyGame
//
//  Created by Marina Osés Merino on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGCollisionController.h"

@implementation MGCollisionController

@synthesize sceneObjects = _sceneObjects;
@synthesize allColliders = _allColliders;
@synthesize collidersToCheck = _collidersToCheck;

- (id)initWithSceneObjects:(NSMutableArray *)scene_objects {
    self = [super init];
    if (self) {
        self.sceneObjects = scene_objects;
        _allColliders = [[NSMutableArray alloc] init];
        _collidersToCheck = [[NSMutableArray alloc] init];
    }
    return self;
}

//Se crean las tablas allColliders y collidersToCheck a partir de sceneObjects
- (void)handleCollisions {
    [self.allColliders removeAllObjects];
    [self.collidersToCheck removeAllObjects];
    for (MGSceneObject *obj in self.sceneObjects) {
        if (obj.collider != nil) {
            [self.allColliders addObject:obj];
            if (obj.collider.checkForCollision) {
                [self.collidersToCheck addObject:obj];
            }
        }
    }
    //Se comprueba si alguno de los objetos de la escena está colisionando con otro
    for (MGSceneObject *colliderObject in self.collidersToCheck) {
        for (MGSceneObject *collideeObject in self.allColliders) {
            //Si los objetos coinciden se pasa a la siguiente vuelta
            if (colliderObject != collideeObject) {
                if ([colliderObject.collider doesCollideWithSceneObject:collideeObject]) {
                    if ([colliderObject conformsToProtocol:@protocol(MGCollisionable)]) {
                        id<MGCollisionable>adaptedColliderObject = (id<MGCollisionable>)colliderObject;
                        [adaptedColliderObject collideWith:collideeObject];
                    }
                }
            }
        }
    }
}

- (void)dealloc {
    [_sceneObjects release];
    [_allColliders release];
    [_collidersToCheck release];
    [super dealloc];
}


@end
