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
    NSArray *sceneObjects;
    NSMutableArray *allColliders; //Colliders + collidees
    NSMutableArray *collidersToCheck; //Only colliders
}



@end
