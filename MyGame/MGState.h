//
//  MGState.h
//  MyGame
//
//  Created by Marina Osés Merino on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGSceneController;

@interface MGState : NSObject {
    MGSceneController *_sceneControllerForState;
    NSMutableArray *_sceneObjects;    

}

@property (nonatomic, retain) MGSceneController *sceneControllerForState;
@property (nonatomic, retain) NSMutableArray *sceneObjects;


- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)loadState;
- (void)startState;
- (void)updateState;
- (void)renderState;
- (void)stopState;

@end
