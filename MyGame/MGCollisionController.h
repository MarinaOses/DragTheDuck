//
//  MGCollisionController.h
//  MyGame
//
//  Created by Marina Osés Merino on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGCollider.h"
#import "MGCollisionable.h"

@interface MGCollisionController : NSObject {
    NSArray *_sceneObjects;
    NSMutableArray *_allColliders; //Colliders + collidees
    NSMutableArray *_collidersToCheck; //Only colliders
}

@property (nonatomic, retain) NSArray *sceneObjects;
@property (nonatomic, retain) NSMutableArray *allColliders;
@property (nonatomic, retain) NSMutableArray *collidersToCheck;


- (id)initWithSceneObjects:(NSMutableArray *)scene_objects;
- (void)handleCollisions;

@end
