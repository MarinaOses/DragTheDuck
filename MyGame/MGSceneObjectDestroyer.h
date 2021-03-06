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
    NSMutableArray *_sceneObjectsToRemove;
}

@property (nonatomic, retain) NSMutableArray *sceneObjectsToRemove;

- (id)init;
- (void)clearSceneObjectsToRemove;
- (void)markToRemoveSceneObject:(MGSceneObject *)sceneObject;
- (void)destroyFrom:(NSMutableArray *)sceneObjects;

@end
