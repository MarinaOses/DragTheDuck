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
@synthesize sceneObjects = _sceneObjects;

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        _sceneObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadState {
    //Se borran todos los objetos que pudiera haber previamente
    [self.sceneObjects removeAllObjects];
    
    //************************************
    //Creación de botones
    //************************************
    
    //HOMEBUTTON
    MGButton *homeButton = [[MGButton alloc] initWithSceneController:self.sceneControllerForState];
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
    [self.sceneObjects makeObjectsPerformSelector:@selector(render)];
    [super updateState];
}

- (void)goodTouchOfHomeButtonIsDone {
    [self.sceneControllerForState.stateManager stopActiveState];
    [self.sceneControllerForState.stateManager goToMainState];    
}

- (void)badTouchOfHomeButtonIsDone {
    //Podría ampliarse la funcionalidad
}

- (void)dealloc {
    [_sceneObjects release];
    [super dealloc];
}
@end
