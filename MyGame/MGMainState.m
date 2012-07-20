//
//  MGMainState.m
//  MyGame
//
//  Created by Marina Osés Merino on 30/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMainState.h"

#import "MGSceneController.h"


@implementation MGMainState



- (void)loadState {
    //Se borran todos los objetos que pudiera haber previamente
    [self.sceneObjects removeAllObjects];
    
    //************************************
    //Creación de botones
    //************************************
    
    //PLAYBUTTON
    MGButton *playButton = [[MGButton alloc] initWithSceneController:self.sceneControllerForState];
    playButton.scale = MGPointMake(80.0, 80.0, 1.0);
    playButton.translation = MGPointMake(0.0, 0.0, 0.0);
    playButton.target = self;
    playButton.buttonGoodAction = @selector(goodTouchOfPlayButtonIsDone);
    playButton.buttonBadAction = @selector(badTouchOfPlayButtonIsDone);
    [self.sceneObjects addObject:playButton];
    [playButton release];
    
    //SOUNDBUTTON
    MGButton *soundButton = [[MGButton alloc] initWithSceneController:self.sceneControllerForState];
    soundButton.scale = MGPointMake(40.0, 40.0, 1.0);
    soundButton.translation = MGPointMake(0.0, 130.0, 0.0);
    soundButton.target = self;
    soundButton.buttonGoodAction = @selector(goodTouchOfSoundButtonIsDone);
    soundButton.buttonBadAction = @selector(badTouchOfSoundButtonIsDone);
    [self.sceneObjects addObject:soundButton];
    [soundButton release];
    
    //HELPBUTTON
    MGButton *helpButton = [[MGButton alloc] initWithSceneController:self.sceneControllerForState];
    helpButton.scale = MGPointMake(40.0, 40.0, 1.0);
    helpButton.translation = MGPointMake(0.0, -130.0, 0.0);
    helpButton.target = self;
    helpButton.buttonGoodAction = @selector(goodTouchOfHelpButtonIsDone);
    helpButton.buttonBadAction = @selector(badTouchOfHelpButtonIsDone);
    [self.sceneObjects addObject:helpButton];
    [helpButton release];
    
    [super loadState];
}




- (void)updateState {
    [self.sceneObjects makeObjectsPerformSelector:@selector(update)];
    [super updateState];
}


//Los botones hacen el render() de MGSceneObjects
- (void)renderState {
    [super renderState];
}



- (void)goodTouchOfPlayButtonIsDone {
    [self.sceneControllerForState.stateManager stopActiveState];
    [self.sceneControllerForState.stateManager goToPlayState];
}



- (void)badTouchOfPlayButtonIsDone {
    //Podría ampliarse la funcionalidad
}


- (void)goodTouchOfSoundButtonIsDone {
    [self.sceneControllerForState.stateManager changeSoundState];
    
}

- (void)badTouchOfSoundButtonIsDone {
    //Podría ampliarse la funcionalidad
}

- (void)goodTouchOfHelpButtonIsDone {
    [self.sceneControllerForState.stateManager stopActiveState];
    [self.sceneControllerForState.stateManager goToHelpState];
}

-(void)badTouchOfHelpButtonIsDone {
    //Podría ampliarse la funcionalidad
}


- (void)dealloc {
    [super dealloc];
}


@end
