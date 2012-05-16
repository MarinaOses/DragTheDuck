//
//  MGBirdDestroyer.m
//  MyGame
//
//  Created by Marina Osés Merino on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObjectDestroyer.h"

@implementation MGSceneObjectDestroyer


- (id)init {
    self = [super init];
    if (self) {
        sceneObjectsToRemove = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)clearSceneObjectsToRemove {
    [sceneObjectsToRemove removeAllObjects];
}

- (void)markToRemoveSceneObject:(MGSceneObject *)sceneObject {
    [sceneObjectsToRemove addObject:sceneObject];
}


- (void)destroyFrom:(NSMutableArray *)sceneObjects {
    if ([sceneObjectsToRemove count] > 0) {
        [sceneObjects removeObjectsInArray:sceneObjectsToRemove];
        [self clearSceneObjectsToRemove];
    }
}

- (void)dealloc {
    [sceneObjectsToRemove release];
    [super dealloc];
}

@end
