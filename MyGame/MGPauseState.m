//
//  MGPauseState.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGPauseState.h"


#import "MGSceneController.h"

@implementation MGPauseState
@synthesize sceneObjects = _sceneObjects;
@synthesize pauseButton = _pauseButton;



- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjects:(NSMutableArray *)scene_objects PauseButton:(MGButton *)pause_button {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        self.sceneObjects = scene_objects;
        self.pauseButton = pause_button;
    }
    return self;
}


- (void)loadState {
    
    //************************************
    //Creación de botones
    //************************************
    
    //PAUSEBUTTON
//    MGButton *pauseButton = [[MGButton alloc] initWithSceneController:self.sceneControllerForState];
//    pauseButton.scale = MGPointMake(35.0,35.0, 1.0);
//    pauseButton.translation = MGPointMake(220.0, 140.0, 0.0);
//    pauseButton.target = self;
//    pauseButton.buttonGoodAction = @selector(goodTouchOfPauseButtonIsDone);
//    pauseButton.buttonBadAction = @selector(badTouchOfPauseButtonIsDone);
//    [self.sceneObjects addObject:pauseButton];
//    [pauseButton release];

    self.pauseButton.target = self;
    [super loadState];
    
}


- (void)updateState {
    [self.pauseButton update];
    [super updateState];
}

- (void)renderState {
    [self.sceneObjects makeObjectsPerformSelector:@selector(render)];
    [super updateState];
}

- (void)goodTouchOfPauseButtonIsDone {
    [self.sceneControllerForState.stateManager stopActiveState];
    [self.sceneControllerForState.stateManager restartPlayState];    
}

- (void)badTouchOfPauseButtonIsDone {
    //Podría ampliarse la funcionalidad
}


- (void)dealloc {
    [_sceneObjects release];
    [_pauseButton release];
    [super dealloc];
}

@end
