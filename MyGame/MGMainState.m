//
//  MGMainState.m
//  MyGame
//
//  Created by Marina Osés Merino on 30/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMainState.h"

#import "MGStateManager.h"

@implementation MGMainState

- (id)initWithSceneController:(MGSceneController *)scene_controller andWithStateManager:(MGStateManager *)state_manager{
    self = [super initWithSceneController:scene_controller andWithStateManager:state_manager];
    if (self) {
        interfaceObjects = [[NSMutableArray alloc] init];
    }
    return self;
}



- (void)loadInterface {
    //Se borran todos los objetos que pudiera haber previamente
    [interfaceObjects removeAllObjects];
    
    //************************************
    //Creación de botones
    //************************************
    
    //PLAYBUTTON
    MGButton *playButton = [[MGButton alloc] initWithSceneController:self.sceneControllerForState];
    playButton.scale = MGPointMake(80.0, 80.0, 1.0);
    playButton.translation = MGPointMake(-120.0, 0.0, 0.0);
    playButton.target = self;
    playButton.buttonGoodAction = @selector(goodTouchOfPlayButtonIsDone);
    playButton.buttonBadAction = @selector(badTouchOfPlayButtonIsDone);
    [interfaceObjects addObject:playButton];
    [playButton release];
    
    //QUITBUTTON
    MGButton *quitButton = [[MGButton alloc] initWithSceneController:self.sceneControllerForState];
    quitButton.scale = MGPointMake(80.0, 80.0, 1.0);
    quitButton.translation = MGPointMake(120.0, 0.0, 0.0);
    quitButton.target = self;
    quitButton.buttonGoodAction = @selector(goodTouchOfQuitButtonIsDone);
    quitButton.buttonBadAction = @selector(badTouchOfQuitButtonIsDone);
    [interfaceObjects addObject:quitButton];
    [quitButton release];
    
    //SOUNDBUTTON
    MGButton *soundButton = [[MGButton alloc] initWithSceneController:self.sceneControllerForState];
    soundButton.scale = MGPointMake(40.0, 40.0, 1.0);
    soundButton.translation = MGPointMake(0.0, 130.0, 0.0);
    soundButton.target = self;
    soundButton.buttonGoodAction = @selector(goodTouchOfSoundButtonIsDone);
    soundButton.buttonBadAction = @selector(badTouchOfSoundButtonIsDone);
    [interfaceObjects addObject:soundButton];
    [soundButton release];
    
    //HELPBUTTON
    MGButton *helpButton = [[MGButton alloc] initWithSceneController:self.sceneControllerForState];
    helpButton.scale = MGPointMake(40.0, 40.0, 1.0);
    helpButton.translation = MGPointMake(0.0, -130.0, 0.0);
    helpButton.target = self;
    helpButton.buttonGoodAction = @selector(goodTouchOfHelpButtonIsDone);
    helpButton.buttonBadAction = @selector(badTouchOfHelpButtonIsDone);
    [interfaceObjects addObject:helpButton];
    [helpButton release];
}


- (void)updateInterface {
    [interfaceObjects makeObjectsPerformSelector:@selector(update)];
}


//Los botones hacen el render() de MGSceneObjects
- (void)renderInterface {
    [interfaceObjects makeObjectsPerformSelector:@selector(render)];
}



- (void)goodTouchOfPlayButtonIsDone {
    [self.stateManager goToGameState];
}

- (void)badTouchOfPlayButtonIsDone {
    //Podría ampliarse la funcionalidad
}

- (void)goodTouchOfQuitButtonIsDone {
    [self.stateManager goToQuitState];
}

- (void)badTouchOfQuitButtonIsDone{
    //Podría ampliarse la funcionalidad
}

- (void)goodTouchOfSoundButtonIsDone {
    [self.stateManager changeSoundState];
    
}

- (void)badTouchOfSoundButtonIsDone {
    //Podría ampliarse la funcionalidad
}


- (void)dealloc {
    [interfaceObjects release];;
    [super dealloc];
}


@end
