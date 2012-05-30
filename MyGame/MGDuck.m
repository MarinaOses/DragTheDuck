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

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer takenLeavesButton:(MGTakenLeavesButton *)taken_leaves_button {
    self = [super initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer RangeForScale:NSMakeRange(MIN_DUCK_SCALE, MAX_DUCK_SCALE) RangeForSpeed:NSMakeRange(MIN_DUCK_SPEED, MAX_DUCK_SPEED) Direction:1];
    if (self) {        
        self.mesh.colors = MGDuckColorValues;
        self.collider.checkForCollision = YES;
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
            [self.takenLeavesButton.scoreBoard addNewTakenLeaf];
            [self.sceneObjectDestroyer markToRemoveSceneObject:scene_object];
        }
    }
}

- (void)update {
    //Ha habido algún toque?
    //touchEvents contiene todos los toques o deslizamientos que se an hecho en pantalla
    NSSet *touchesSet = [self.sceneController.inputViewController touchEvents];
    for (MGTouch *atouch in touchesSet) {
        //NSLog(@"%@", [atouch description]);
        //NSLog(@"screenRectX: %d to %d", (int)self.screenRect.origin.x,  (int)self.screenRect.origin.x+(int)CGRectGetWidth(self.screenRect));
        //NSLog(@"screenRectY: %d to %d", (int)self.screenRect.origin.y,  (int)self.screenRect.origin.y+(int)CGRectGetHeight(self.screenRect));
        if (atouch.phase == UITouchPhaseBegan && atouch.numberOfFingersOnTheScreen == 1) {
            if (CGRectContainsPoint(self.screenRect, atouch.location)) {
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
    [super update];
}

- (void)dealloc {
    [_takenLeavesButton release];
    [super dealloc];
}



@end
