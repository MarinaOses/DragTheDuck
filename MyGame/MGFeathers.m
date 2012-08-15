//
//  MGFeathers.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGFeathers.h"

#import "MGSceneController.h"



@interface MGFeathers()
- (MGPoint)randomRotation;
- (CGFloat)randomLifeTime;
@end


//static CGFloat MGFeathersColorValues[16] ={
//    1.0, 1.0, 1.0, 1.0, 
//    1.0, 1.0, 1.0, 1.0, 
//    1.0, 1.0, 1.0, 1.0, 
//    1.0, 1.0, 1.0, 1.0
//};

@implementation MGFeathers


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer Translation:(MGPoint)feathers_translation Scale:(MGPoint)feathers_scale Color:(NSInteger)feathers_color {
    self = [super initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer];
    if (self) {
        if (feathers_color == DUCK_COLOR) {
            self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_feathers_duck.png"];

        }
        else if (feathers_color == BIRD_COLOR) {
            self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_feathers_bird.png"];
        }
//        self.mesh.colors = MGFeathersColorValues;
//        self.mesh.colors = feathers_color;
        self.translation = feathers_translation;
        self.rotation = [self randomRotation];
        self.scale = feathers_scale;
        
    }
    return self;
}


- (MGPoint)randomRotation {
    int randomDegrees = RANDOM_FLOAT(0.0, MAX_FEATHERS_ROTATION);
    return MGPointMake(0.0, 0.0, randomDegrees);
}

- (CGFloat)randomLifeTime {
    return RANDOM_FLOAT(SEC_TO_FEATHERS_DISAPPEARANCE, SEC_TO_FEATHERS_DISAPPEARANCE);
}

- (void)update {
    self.lifeTimeInUpdates--;
    if (self.lifeTimeInUpdates <= 0) {
        [self removeMySelf];
    }
    [super update];

}

- (void)dealloc {
    [super dealloc];
}

@end
