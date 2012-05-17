//
//  MGMultipleDuckGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGConfiguration.h"
#import "MGDuck.h"
#import "MGGenerator.h"


@class MGSceneController;

@interface MGMultipleDuckGenerator : NSObject <MGGenerator> {
    MGSceneController *_sceneController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
}

@property (nonatomic, retain) MGSceneController *sceneController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer;

- (NSArray *)createWave;

@end
