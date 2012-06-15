//
//  MGBirdDestroyer.m
//  MyGame
//
//  Created by Marina Osés Merino on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObjectDestroyer.h"

@implementation MGSceneObjectDestroyer

@synthesize sceneObjectsToRemove = _sceneObjectsToRemove;


- (id)init {
    self = [super init];
    if (self) {
        _sceneObjectsToRemove = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)clearSceneObjectsToRemove {
    [self.sceneObjectsToRemove removeAllObjects];
}

- (void)markToRemoveSceneObject:(MGSceneObject *)sceneObject {
    [self.sceneObjectsToRemove addObject:sceneObject];
}


- (void)destroyFrom:(NSMutableArray *)sceneObjects {
    if ([self.sceneObjectsToRemove count] > 0) {
        [sceneObjects removeObjectsInArray:self.sceneObjectsToRemove];
        [self clearSceneObjectsToRemove];
    }
}

- (void)dealloc {
    [_sceneObjectsToRemove release];
    [super dealloc];
}

@end
