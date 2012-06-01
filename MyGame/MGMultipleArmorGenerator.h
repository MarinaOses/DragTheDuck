//
//  MGArmorGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 01/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGGenerator.h"

#import "MGArmor.h"

@class MGSceneController;

@interface MGMultipleArmorGenerator : NSObject <MGGenerator> {
    NSMutableArray *_sceneObjects;
    MGSceneController *_sceneController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;    
}

@property (nonatomic, retain) MGSceneController *sceneController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) NSMutableArray *sceneObjects;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer SceneObjects:(NSMutableArray *)scene_objects;

@end