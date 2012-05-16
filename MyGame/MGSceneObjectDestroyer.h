//
//  MGBirdDestroyer.h
//  MyGame
//
//  Created by Marina Osés Merino on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGSceneObject.h"

@interface MGSceneObjectDestroyer : NSObject {
    NSMutableArray *sceneObjectsToRemove;
}


- (void)clearSceneObjectsToRemove;
- (void)markToRemoveSceneObject:(MGSceneObject *)sceneObject;
- (void)destroyFrom:(NSMutableArray *)sceneObjects;

@end
