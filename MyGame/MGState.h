//
//  MGState.h
//  MyGame
//
//  Created by Marina Osés Merino on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGSceneObjectDestroyer.h"
#import "MGOpenALSoundController.h"

@class MGSceneController;

@interface MGState : NSObject <MGSoundCallBackDelegate> {
    MGSceneController *_sceneControllerForState;
    NSMutableArray *_sceneObjects;
    MGSceneObjectDestroyer *_sceneObjectDestroyerForState;

}

@property (nonatomic, retain) MGSceneController *sceneControllerForState;
@property (nonatomic, retain) NSMutableArray *sceneObjects;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyerForState;

- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)loadState;
- (void)startState;
- (void)updateState;
- (void)renderState;
- (void)stopState;

@end
