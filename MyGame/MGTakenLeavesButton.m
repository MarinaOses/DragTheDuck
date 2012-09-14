//
//  MGTakenLeavesButton.m
//  MyGame
//
//  Created by Marina Osés Merino on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTakenLeavesButton.h"

@implementation MGTakenLeavesButton

@synthesize scoreBoard = _scoreBoard;
@synthesize takenLeavesButtonShowerLayer = _takenLeavesButtonShowerLayer;
@synthesize isActive;
@synthesize soundSourceObjectForLeavesButtonActive = _soundSourceObjectForLeavesButtonActive;


- (id)initWithSceneController:(MGSceneController *)scene_controller Translation:(MGPoint)button_translation Rotation:(MGPoint)button_rotation Scale:(MGPoint)button_scale scoreBoard:(MGScoreBoard *)score_board {
    self = [super initWithSceneController:scene_controller UpKey:@"mg_boton_hojas.png" downKey:@"mg_boton_hojas.png"];
    if (self) {
        
        self.scoreBoard = score_board;
        previousTakenLeaves = 0;
        self.translation = button_translation;
        self.rotation = button_rotation;
        self.scale = button_scale;
            
        MGTakenLeavesButtonShowerLayer *takenLeavesButtonShowerLayerToAssign = [[MGTakenLeavesButtonShowerLayer alloc] initWithSceneController:scene_controller Translation:button_translation Rotation:button_rotation Scale:button_scale];
        self.takenLeavesButtonShowerLayer = takenLeavesButtonShowerLayerToAssign;
        [takenLeavesButtonShowerLayerToAssign release];
        
        isActive = NO;
        _soundSourceObjectForLeavesButtonActive = [[MGSoundSourceObject alloc] init];
        self.soundSourceObjectForLeavesButtonActive.audioLooping = AL_TRUE;
        
    }
    return self;
}

- (void)goodTouch {
    if (isActive) { //Si funciona como botón
        [super goodTouch];
        [self stopSound];
        //Cuando hayamos terminado la acción del toque volvemos a poner el layer
        self.takenLeavesButtonShowerLayer.scale = self.scale;
        self.takenLeavesButtonShowerLayer.translation = self.translation;
        //Reseteamos los contadores
        [self.scoreBoard resetTakenLeaves];
        previousTakenLeaves = self.scoreBoard.takenLeaves;
        //Y de ahora en adelante el botón debe estar inactivo y evidentemente, como no seleccionado
        [self setNotPressedVertexes];
        isActive = NO;
    }
}

-(void)badTouch {
    if (isActive) {
        [super badTouch];
    }
}

- (void)checkIfShowerLayerHasToGoUp:(NSInteger)taken_leaves_now {
    if (taken_leaves_now < MAX_TAKEN_LEAVES) {
        if (previousTakenLeaves < taken_leaves_now) {
            [self.takenLeavesButtonShowerLayer decreaseHeight:(MAX_TAKEN_LEAVES - taken_leaves_now)];
            previousTakenLeaves = taken_leaves_now;
        }
    }
    else if (taken_leaves_now == MAX_TAKEN_LEAVES){
        [self.takenLeavesButtonShowerLayer decreaseHeight:(MAX_TAKEN_LEAVES - taken_leaves_now)];
        [self playSoundLeavesButtonActive];
        isActive = YES;
    }
}

- (void)update {
    if (!isActive) {
        [self checkIfShowerLayerHasToGoUp:self.scoreBoard.takenLeaves];    
    }
    [super update];
}

- (void)playSoundLeavesButtonActive {
    [self.soundSourceObjectForLeavesButtonActive playSound:[[MGOpenALSoundController sharedSoundController] soundBufferDataFromFileBaseName:LEAVES_BUTTON_ACTIVE]];
}

- (void)stopSound {
    [self.soundSourceObjectForLeavesButtonActive stopSound];
}


+ (void)loadResources {
    [[MGOpenALSoundController sharedSoundController] soundBufferDataFromFileBaseName:LEAVES_BUTTON_ACTIVE];
}

- (void)dealloc {
    [_scoreBoard release];
    [_takenLeavesButtonShowerLayer release];
    [_soundSourceObjectForLeavesButtonActive release];
    [super dealloc];
}


@end
