//
//  MGGameOverState.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGGameOverState.h"

#import "MGSceneController.h"

@implementation MGGameOverState
@synthesize numbersDelegate = _numbersDelegate;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize scoreBoard = _scoreBoard;

- (id)initWithSceneController:(MGSceneController *)scene_controller ScoreBoard:(MGScoreBoard *)score_board {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        self.scoreBoard = score_board;
        _sceneObjectDestroyer = [[MGSceneObjectDestroyer alloc] init];
        _numbersDelegate = [[MGNumbersDelegate alloc] initWithSceneController:scene_controller SceneObjects:self.sceneObjects SceneObjectDestroyer:self.sceneObjectDestroyer];
    }
    return self;
}

- (void)loadState {
    //Se borran todos los objetos que pudiera haber previamente
    [self.sceneObjects removeAllObjects];
    
    //************************************
    //Creación de fondo
    //************************************
    
    MGSceneObject *background = [[MGSceneObject alloc] initWithSceneController:self.sceneControllerForState];
    background.scale = MGPointMake(480.0, 320.0, 1.0);
    background.translation = MGPointMake(0.0, 0.0, 0.0);
    background.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_fondo_game_over.png"];
    [self.sceneObjects addObject:background];
    [background release];
    
    //************************************
    //Creación de botones
    //************************************
    
    //HOMEBUTTON
    MGTexturedButton *homeButton = [[MGTexturedButton alloc] initWithSceneController:self.sceneControllerForState UpKey:@"mg_button_home.png" downKey:@"mg_button_home_pressed.png"];
    homeButton.scale = MGPointMake(50.0, 50.0, 1.0);
    homeButton.translation = MGPointMake(-120.0, -60.0, 0.0);
    homeButton.target = self;
    homeButton.buttonGoodAction = @selector(goodTouchOfHomeButtonIsDone);
    homeButton.buttonBadAction = @selector(badTouchOfHomeButtonIsDone);
    [self.sceneObjects addObject:homeButton];
    [homeButton release];
    
    //RESTARTBUTTON
    MGTexturedButton *restartButton = [[MGTexturedButton alloc] initWithSceneController:self.sceneControllerForState UpKey:@"mg_button_reload.png" downKey:@"mg_button_reload_pressed.png"];
    restartButton.scale = MGPointMake(50.0, 50.0, 1.0);
    restartButton.translation = MGPointMake(120.0, -60.0, 0.0);
    restartButton.target = self;
    restartButton.buttonGoodAction = @selector(goodTouchOfRestartButtonIsDone);
    restartButton.buttonBadAction = @selector(badTouchOfRestartButtonIsDone);
    [self.sceneObjects addObject:restartButton];
    [restartButton release];
    
    
    //************************************
    //Creación de marcador
    //************************************
    [self.numbersDelegate initializeAllMembersOfStaff];
    [self.numbersDelegate updateTheMarker:1 With:self.scoreBoard.savedDucks];
    
    [super loadState];
    
}


- (void)updateState {
    [self.sceneObjects makeObjectsPerformSelector:@selector(update)];
    [super updateState];
}

- (void)renderState {
    [super renderState];
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
    [_numbersDelegate release];
    [_sceneObjectDestroyer release];
    [_scoreBoard release];
    [super dealloc];
}



@end
