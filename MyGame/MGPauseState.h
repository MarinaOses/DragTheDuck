//
//  MGPauseState.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGState.h"
#import "MGTexturedButton.h"

@class MGSceneController;


@interface MGPauseState : MGState {
    NSMutableArray *_sceneObjectsOfPlayState;
    
    MGTexturedButton *_pauseButton;
}

@property (nonatomic, retain) NSMutableArray *sceneObjectsOfPlayState;
@property (nonatomic, retain) MGTexturedButton *pauseButton;


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjects:(NSMutableArray *)scene_objects PauseButton:(MGTexturedButton *)pause_button;
@end
