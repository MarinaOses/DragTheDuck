//
//  MGHelpState.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGHelpState.h"

#import "MGSceneController.h"

@implementation MGHelpState

- (void)loadState {
    //Se borran todos los objetos que pudiera haber previamente
    [self.sceneObjects removeAllObjects];
    
    //************************************
    //Creación de fondo
    //************************************
    
    MGSceneObject *background = [[MGSceneObject alloc] initWithSceneController:self.sceneControllerForState];
    background.scale = MGPointMake(480.0, 320.0, 1.0);
    background.translation = MGPointMake(0.0, 0.0, 0.0);
    background.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_fondo_ayuda.png"];
    [self.sceneObjects addObject:background];
    [background release];
    
    //************************************
    //Creación de botones
    //************************************
    
    //HOMEBUTTON
    MGTexturedButton *homeButton = [[MGTexturedButton alloc] initWithSceneController:self.sceneControllerForState UpKey:@"mg_button_home.png" downKey:@"mg_button_home_pressed.png"];
    homeButton.scale = MGPointMake(60.0, 60.0, 1.0);
    homeButton.translation = MGPointMake(-207.0, -127.0, 0.0);
    homeButton.target = self;
    homeButton.buttonGoodAction = @selector(goodTouchOfHomeButtonIsDone);
    homeButton.buttonBadAction = @selector(badTouchOfHomeButtonIsDone);
    [self.sceneObjects addObject:homeButton];
    [homeButton release];
    
    [super loadState];

}

- (void)updateState {
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

- (void)dealloc {
    [super dealloc];
}
@end
