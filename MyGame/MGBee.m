//
//  MGBee.m
//  MyGame
//
//  Created by Marina Osés Merino on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGBee.h"
#import "MGSceneController.h"

@interface MGBee()
- (MGPoint)randomTranslation:(CGRect)bee_mesh_bounds;
- (MGPoint)randomRotation;
- (MGPoint)randomScale;
- (CGFloat)randomLifeTime;
@end


@implementation MGBee

static CGFloat MGBeeColorValues[16] ={
    1.0, 1.0, 0.0, 1.0, 
    0.0, 0.0, 0.0, 1.0, 
    1.0, 1.0, 0.0, 1.0, 
    0.0, 0.0, 0.0, 1.0
};

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer];
    if (self) {
        self.mesh.colors = MGBeeColorValues;
        
        self.translation = [self randomTranslation:self.meshBounds];
        self.rotation = [self randomRotation];
        self.scale = [self randomScale];
        
        self.lifeTimeInUpdates = (int)([self randomLifeTime] * MAXIMUM_FRAME_RATE);
    }
    return self;
}


- (MGPoint)randomTranslation:(CGRect)bee_mesh_bounds {
    CGFloat screenY = CGRectGetHeight(self.sceneController.openGLView.window.frame);
    CGFloat screenX = CGRectGetWidth(self.sceneController.openGLView.window.frame);
    CGFloat meshBoundsMidX = bee_mesh_bounds.size.width/2.0;
    CGFloat meshBoundsMidY = bee_mesh_bounds.size.height/2.0;
    //Para que no se salga de la pantalla se suma o resta la mitad del tamaño de la hoja
    CGFloat randomX = RANDOM_FLOAT(meshBoundsMidX, screenY-meshBoundsMidX) - screenY/2.0;
    CGFloat randomY = RANDOM_FLOAT(meshBoundsMidY, screenX-meshBoundsMidY) - screenX/2.0;
    return MGPointMake(randomX, randomY, 0.0);
}

- (MGPoint)randomRotation {
    NSInteger rotationDirection = RANDOM_INT(1, 10);
    if (rotationDirection <= 5) {
        rotationDirection = LEFT;
    }
    else {
        rotationDirection = RIGHT;
    }
    int randomDegrees = RANDOM_FLOAT(0.0, MAX_BEE_ROTATION);
    return MGPointMake(0.0, 0.0, rotationDirection * randomDegrees);
}

- (MGPoint)randomScale {
    int randomScale = RANDOM_FLOAT(MIN_BEE_SCALE, MAX_BEE_SCALE);
    return MGPointMake(randomScale, randomScale, 1.0);
}

- (CGFloat)randomLifeTime {
    return RANDOM_FLOAT(MINSEC_TO_BEE_DISAPPEARANCE, MAXSEC_TO_BEE_DISAPPEARANCE);
}

- (void)update {
    [super update];
}


- (void)dealloc {
    [super dealloc];
}

@end
