//
//  MGCollider.h
//  MyGame
//
//  Created by Marina Osés Merino on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObject.h"

@interface MGCollider : MGSceneObject {
    MGPoint transformedCentroid;
    BOOL checkForCollision;
    CGFloat maxRadius;
}

@property (nonatomic, assign) MGPoint transformedCentroid;
@property (nonatomic, assign) BOOL checkForCollision;
@property (nonatomic, assign) CGFloat maxRadius;



//- (BOOL)doesCollideWithCollider:(MGCollider *)aCollider;
- (BOOL)doesCollideWithSceneObject:(MGSceneObject *)scene_object;

- (void)updateWith:(MGSceneObject *)scene_object;

@end
