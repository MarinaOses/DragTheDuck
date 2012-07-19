//
//  MGPauseState.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGState.h"
#import "MGButton.h"

@class MGSceneController;


@interface MGPauseState : MGState {
    NSMutableArray *_sceneObjects;
    MGButton *_pauseButton;
}

@property (nonatomic, retain) NSMutableArray *sceneObjects;
@property (nonatomic, retain) MGButton *pauseButton;


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjects:(NSMutableArray *)scene_objects PauseButton:(MGButton *)pause_button;
@end
