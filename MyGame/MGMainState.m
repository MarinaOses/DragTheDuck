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
    //Creación de fondo
    //************************************

    MGSceneObject *background = [[MGSceneObject alloc] initWithSceneController:self.sceneControllerForState];
    background.scale = MGPointMake(480.0, 320.0, 1.0);
    background.translation = MGPointMake(0.0, 0.0, 0.0);
    background.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_fondo_main.png"];
    [self.sceneObjects addObject:background];
    [background release];
    
    //************************************
    //Creación de botones
    //************************************
    
    //PLAYBUTTON
    MGTexturedButton *playButton = [[MGTexturedButton alloc] initWithSceneController:self.sceneControllerForState UpKey:@"mg_boton_play_final.png" downKey:@"mg_boton_play_final_pressed.png"];
    playButton.scale = MGPointMake(160.0, 160.0, 1.0);
    playButton.translation = MGPointMake(0.0, 0.0, 0.0);
    playButton.target = self;
    playButton.buttonGoodAction = @selector(goodTouchOfPlayButtonIsDone);
    playButton.buttonBadAction = @selector(badTouchOfPlayButtonIsDone);
    [self.sceneObjects addObject:playButton];
    [playButton release];
    
    //SOUNDBUTTON
    MGTexturedButton *soundButton = [[MGTexturedButton alloc] initWithSceneController:self.sceneControllerForState UpKey:@"mg_button_sound_off.png" downKey:@"mg_button_sound_on.png"];
    soundButton.scale = MGPointMake(40.0, 40.0, 1.0);
    soundButton.translation = MGPointMake(0.0, 130.0, 0.0);
    soundButton.target = self;
    soundButton.buttonGoodAction = @selector(goodTouchOfSoundButtonIsDone);
    soundButton.buttonBadAction = @selector(badTouchOfSoundButtonIsDone);
    [self.sceneObjects addObject:soundButton];
    [soundButton release];
    
    //HELPBUTTON
    MGTexturedButton *helpButton = [[MGTexturedButton alloc] initWithSceneController:self.sceneControllerForState UpKey:@"mg_button_help.png" downKey:@"mg_button_help_pressed.png"];
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
