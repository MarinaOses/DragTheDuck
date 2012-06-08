//
//  MGDuck.m
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGDuck.h"

#import "MGSceneController.h"

static CGFloat MGDuckColorValues[16] ={
    1.0, 1.0, 0.0, 1.0, 
    1.0, 1.0, 0.0, 1.0, 
    1.0, 1.0, 0.0, 1.0, 
    1.0, 1.0, 0.0, 1.0
};

@implementation MGDuck

@synthesize takenLeavesButton = _takenLeavesButton;
@synthesize  draggeable;


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer takenLeavesButton:(MGTakenLeavesButton *)taken_leaves_button {
    self = [super initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer RangeForScale:NSMakeRange(MIN_DUCK_SCALE, MAX_DUCK_SCALE) RangeForSpeed:NSMakeRange(MIN_DUCK_SPEED, MAX_DUCK_SPEED) Direction:1];
    if (self) {        
        self.mesh.colors = MGDuckColorValues;
        self.collider.checkForCollision = YES;
        self.draggeable = YES;
        self.takenLeavesButton = taken_leaves_button;
    }
    return self;
}


- (void)collideWith:(MGSceneObject *)scene_object {
    if (![scene_object isKindOfClass:[MGBird class]] && ![scene_object isKindOfClass:[MGBee class]] && ![scene_object isKindOfClass:[MGLeaf class]]) {
        return;
    }
    if ([scene_object isKindOfClass:[MGBird class]]) {
        self.collider.checkForCollision = NO;
        //Animacion: igual no hace falta el remove
        [self.sceneObjectDestroyer markToRemoveSceneObject:self];
        //sumar a marcador "número de patos muertos"
        
    }
    else if ([scene_object isKindOfClass:[MGBee class]]) {
        [self.sceneObjectDestroyer markToRemoveSceneObject:scene_object];
        //comerzar poder de pato-abeja
    }
    else { //hoja
        if (!self.takenLeavesButton.isActive) {
            [self.sceneObjectDestroyer markToRemoveSceneObject:scene_object];
            [self.takenLeavesButton.scoreBoard addNewTakenLeaf];
        }
    }
}


- (BOOL)hasCrossedTheFinishingLine {
    BOOL hasCrossed = NO;
    CGFloat midYOfWindowRect = CGRectGetMidY(self.sceneController.openGLView.window.frame);
    CGFloat midXOfMeshRect = CGRectGetMidX(self.meshBounds);
    CGFloat myCenterX = self.translation.x;
    if (myCenterX > (midYOfWindowRect + midXOfMeshRect)) {
        hasCrossed = YES;
    }
    return hasCrossed;    
}

- (void)update {
    if (self.draggeable) {
        //Ha habido algún toque?
        //touchEvents contiene todos los toques o deslizamientos que se an hecho en pantalla
        NSSet *touchesSet = [self.sceneController.inputViewController touchEvents];
        for (MGTouch *atouch in touchesSet) {
            if (atouch.phase == UITouchPhaseBegan && atouch.numberOfFingersOnTheScreen == 1) {
                CGRect screenRectToAccess = self.screenRect;
                CGRect touchableArea = CGRectMake(CGRectGetMinX(screenRectToAccess) - ADD_TO_SCREENRECT_OF_DUCKS, CGRectGetMinY(screenRectToAccess) - ADD_TO_SCREENRECT_OF_DUCKS, CGRectGetWidth(screenRectToAccess) + ADD_TO_SCREENRECT_OF_DUCKS*2, CGRectGetHeight(screenRectToAccess) + ADD_TO_SCREENRECT_OF_DUCKS*2);
                if (CGRectContainsPoint(touchableArea, atouch.location)) {
                    taken = YES;
                }
            }
            else if (atouch.phase == UITouchPhaseMoved && taken == YES) {
                self.translation = [self.sceneController.inputViewController meshCenterFromMGTouchLocation:atouch.location];
            }
            else if (atouch.phase == UITouchPhaseEnded){
                taken = NO;
            }
        }
    }
    if ([self hasCrossedTheFinishingLine]) {
       // [self.scoreTransmitter transmiteToScoreBoardToAddANewSavedDuck];
    }
    [super update];
}



- (void)dealloc {
    [_takenLeavesButton release];
    [super dealloc];
}



@end
