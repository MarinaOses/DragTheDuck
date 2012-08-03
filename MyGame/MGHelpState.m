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
    //Creación de botones
    //************************************
    
    //HOMEBUTTON
    MGTexturedButton *homeButton = [[MGTexturedButton alloc] initWithSceneController:self.sceneControllerForState UpKey:@"mg_button_home.png" downKey:@"mg_button_home_pressed.png"];
    homeButton.scale = MGPointMake(40.0, 40.0, 1.0);
    homeButton.translation = MGPointMake(-190.0, -130.0, 0.0);
    homeButton.target = self;
    homeButton.buttonGoodAction = @selector(goodTouchOfHomeButtonIsDone);
    homeButton.buttonBadAction = @selector(badTouchOfHomeButtonIsDone);
    [self.sceneObjects addObject:homeButton];
    [homeButton release];
    
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

- (void)dealloc {
    [super dealloc];
}
@end
