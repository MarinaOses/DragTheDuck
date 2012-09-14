//
//  MGBird.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGBird.h"

#import "MGSceneController.h"




//static CGFloat MGBirdWingsDownColorValues[16] ={
//    1.0, 0.0, 0.0, 1.0, 
//    1.0, 0.0, 0.0, 1.0, 
//    1.0, 0.0, 0.0, 1.0, 
//    1.0, 0.0, 0.0, 1.0
//};
//
//static CGFloat MGBirdWingsUpColorValues[16] ={
//    0.5, 0.0, 0.0, 1.0, 
//    0.5, 0.0, 0.0, 1.0, 
//    0.5, 0.0, 0.0, 1.0, 
//    0.5, 0.0, 0.0, 1.0
//};

@implementation MGBird
@synthesize upWingsQuad = _upWingsQuad;
@synthesize downWingsQuad = _downWingsQuad;




- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer AppearanceHeight:(CGFloat)appearance_height {
    self = [super initWithSceneController:scene_controller BoundaryController:boundary_controller RangeForScale:NSMakeRange(MIN_BIRD_SCALE, MAX_BIRD_SCALE) RangeForSpeed:NSMakeRange(MIN_BIRD_SPEED, MAX_BIRD_SPEED) Direction:-1];
    if (self) {
        wingsDown = YES;
        self.downWingsQuad = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_bird_ala_abajo.png"];
        self.upWingsQuad = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_bird_ala_arriba.png"];
        [self flapItsWings]; 
        
        [self loadTimeToFlapItsWingsInUpdates];
        self.translation = MGPointMake(self.startingPointX, appearance_height, 0.0);
        
    }
    return self;
}

- (void)loadTimeToFlapItsWingsInUpdates {
    timeToFlapItsWingsInUpdates = (TIME_TO_FLAP_ITS_WINGS * MAXIMUM_FRAME_RATE) / (self.speed.x * self.movingDirection);
}

- (void)flapItsWings {
    if (wingsDown) {
        self.mesh = self.downWingsQuad;
    }
    else {
        self.mesh = self.upWingsQuad;
    }
    
}

- (void)update {
    timeToFlapItsWingsInUpdates--;
    if (timeToFlapItsWingsInUpdates <= 0) {
        [self flapItsWings];
        wingsDown = !wingsDown;
        [self loadTimeToFlapItsWingsInUpdates];
        
    }
    [super update];
}


- (void)playSound {
    [self.soundSourceObject playSound:[[MGOpenALSoundController sharedSoundController] soundBufferDataFromFileBaseName:BIRD_KILLING]];

}

+ (void)loadResources {
    [[MGOpenALSoundController sharedSoundController] soundBufferDataFromFileBaseName:BIRD_KILLING];
}

- (void)dealloc {
    [_downWingsQuad release];
    [_upWingsQuad release];
    [super dealloc];
}






@end
