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
@synthesize sceneObjectsOfPlayState = _sceneObjectsOfPlayState;
@synthesize pauseButton = _pauseButton;



- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjects:(NSMutableArray *)scene_objects PauseButton:(MGButton *)pause_button {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        self.sceneObjectsOfPlayState = scene_objects;
        self.pauseButton = pause_button;
    }
    return self;
}


- (void)loadState {
    
    //************************************
    //Creación de botones
    //************************************
    [self.sceneObjects removeAllObjects];
    
    //HOMEBUTTON
    MGButton *homeButton = [[MGButton alloc] initWithSceneController:self.sceneControllerForState];
    homeButton.scale = MGPointMake(50.0, 50.0, 1.0);
    homeButton.translation = MGPointMake(-120.0, -60.0, 0.0);
    homeButton.target = self;
    homeButton.buttonGoodAction = @selector(goodTouchOfHomeButtonIsDone);
    homeButton.buttonBadAction = @selector(badTouchOfHomeButtonIsDone);
    [self.sceneObjects addObject:homeButton];
    [homeButton release];
    
    //RESTARTBUTTON
    MGButton *restartButton = [[MGButton alloc] initWithSceneController:self.sceneControllerForState];
    restartButton.scale = MGPointMake(50.0, 50.0, 1.0);
    restartButton.translation = MGPointMake(120.0, -60.0, 0.0);
    restartButton.target = self;
    restartButton.buttonGoodAction = @selector(goodTouchOfRestartButtonIsDone);
    restartButton.buttonBadAction = @selector(badTouchOfRestartButtonIsDone);
    [self.sceneObjects addObject:restartButton];
    [restartButton release];

    self.pauseButton.target = self;
    [super loadState];
    
}


- (void)updateState {
    [self.pauseButton update];
    [self.sceneObjects makeObjectsPerformSelector:@selector(update)];
    [super updateState];
}

- (void)renderState {
    [self.sceneObjectsOfPlayState makeObjectsPerformSelector:@selector(render)];
    [super renderState];
}

- (void)goodTouchOfPauseButtonIsDone {
    [self.sceneControllerForState.stateManager stopActiveState];
    [self.sceneControllerForState.stateManager restartPlayState];    
}

- (void)badTouchOfPauseButtonIsDone {
    //Podría ampliarse la funcionalidad
}

- (void)goodTouchOfHomeButtonIsDone {
    [self.sceneControllerForState.stateManager stopActiveState];
    [self.sceneControllerForState.stateManager goToMainState];    
}

- (void)badTouchOfHomeButtonIsDone {
    //Podría ampliarse la funcionalidad
}

- (void)goodTouchOfRestartButtonIsDone {
    [self.sceneControllerForState.stateManager stopActiveState];
    [self.sceneControllerForState.stateManager goToPlayState];    
}

- (void)badTouchOfRestartButtonIsDone {
    //Podría ampliarse la funcionalidad
}

- (void)dealloc {
    [_pauseButton release];
    [_sceneObjectsOfPlayState release];
    [super dealloc];
}

@end
