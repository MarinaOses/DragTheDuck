//
//  MGLifesController.m
//  MyGame
//
//  Created by Marina Osés Merino on 26/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGLifesController.h"

#import "MGSceneController.h"

//static CGFloat MGSpentLifesColorValues[16] ={
//    1.0, 0.5, 0.0, 1.0, 
//    1.0, 0.5, 0.0, 1.0, 
//    1.0, 0.5, 0.0, 1.0, 
//    1.0, 0.5, 0.0, 1.0
//};
//
//static CGFloat MGLifesColorValues[16] ={
//    0.9, 0.8, 0.7, 1.0, 
//    0.9, 0.8, 0.7, 1.0, 
//    0.9, 0.8, 0.7, 1.0, 
//    0.9, 0.8, 0.7, 1.0
//};

@implementation MGLifesController
@synthesize lifesPresenter = _lifesPresenter;
@synthesize lifesMarker = _lifesMarker;
@synthesize sceneObjects = _sceneObjects;
@synthesize nextLifeWithoutUsing;
@synthesize sceneController = _sceneController;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjects:(NSMutableArray *)scene_objects FirstTranslation:(MGPoint)first_translation ScaleOfPresentation:(MGPoint)scale_of_presentation NumberOfLifes:(NSInteger)number_of_lifes {
    
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        _lifesPresenter = [[MGLifesPresenter alloc] initWithSceneController:self.sceneController FirstTranslation:first_translation ScaleOfPresentation:scale_of_presentation];
        numberOfLifes = number_of_lifes;
        self.nextLifeWithoutUsing = numberOfLifes - 1;
        self.sceneObjects = scene_objects;
        
    }
    return self;
}

- (void)createAndAddLifesMarker {
    self.lifesMarker = [self.lifesPresenter createLifesMarkerWith:numberOfLifes];
    [self.sceneObjects addObjectsFromArray:self.lifesMarker];
}

- (void)aLifeHasBeenSpent {
    MGSceneObject *life = [self.lifesMarker objectAtIndex:self.nextLifeWithoutUsing];
    life.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_fried_egg.png"];
    self.nextLifeWithoutUsing--;
    if (self.nextLifeWithoutUsing < 0) {
        [self.sceneController.stateManager stopActiveState];
    }
    [[MGOpenALSoundController sharedSoundController] playFriedEgg];
}

- (void)aLifeHasBeenRecovered {
    if (self.nextLifeWithoutUsing+1 < numberOfLifes) {
        MGSceneObject *life = [self.lifesMarker objectAtIndex:self.nextLifeWithoutUsing+1];
        life.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_egg.png"];
        self.nextLifeWithoutUsing++;
    }
    
}

- (void)dealloc {
    [_lifesPresenter release];
    [_lifesMarker release];
    [_sceneObjects release];
    [_sceneController release];
    [super dealloc];
}

@end
