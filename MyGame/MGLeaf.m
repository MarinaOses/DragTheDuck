//
//  Leaf.m
//  MyGame
//
//  Created by Marina Osés Merino on 17/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGLeaf.h"

#import "MGSceneController.h"

@interface MGLeaf()
- (MGPoint)randomTranslation:(CGRect)leaf_mesh_bounds;
- (MGPoint)randomRotation;
- (MGPoint)randomScale;
- (CGFloat)randomLifeTime;
@end


//static CGFloat MGLeafFirstColorValues[16] ={
//    0.0, 1.0, 0.0, 1.0, 
//    0.0, 1.0, 0.0, 1.0, 
//    0.0, 1.0, 0.0, 1.0, 
//    0.0, 1.0, 0.0, 1.0
//};
//
//static CGFloat MGLeafSecondColorValues[16] ={
//    0.0, 0.0, 1.0, 1.0, 
//    0.0, 0.0, 1.0, 1.0, 
//    0.0, 0.0, 1.0, 1.0, 
//    0.0, 0.0, 1.0, 1.0
//};


@implementation MGLeaf





- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer];
    if (self) {
        self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_hoja_verde.png"];
        self.translation = [self randomTranslation:self.meshBounds];
        self.rotation = [self randomRotation];
        self.scale = [self randomScale];

    }
    return self;
}

- (MGPoint)randomTranslation:(CGRect)leaf_mesh_bounds {
    CGFloat screenY = CGRectGetHeight(self.sceneController.openGLView.window.frame);
    CGFloat screenX = CGRectGetWidth(self.sceneController.openGLView.window.frame);
    CGFloat meshBoundsMidX = leaf_mesh_bounds.size.width/2.0;
    CGFloat meshBoundsMidY = leaf_mesh_bounds.size.height/2.0;
    //Para que no se salga de la pantalla se suma o resta la mitad del tamaño de la hoja
    CGFloat randomX = RANDOM_FLOAT(meshBoundsMidX, screenY-meshBoundsMidX) - screenY/2.0;
    CGFloat randomY = RANDOM_FLOAT(meshBoundsMidY + GRASS_HEIGHT, screenX-meshBoundsMidY) - screenX/2.0;
    return MGPointMake(randomX, randomY, 0.0);
}

- (MGPoint)randomRotation {
    int randomDegrees = RANDOM_FLOAT(0.0, MAX_LEAF_ROTATION);
    return MGPointMake(0.0, 0.0, randomDegrees);
}

- (MGPoint)randomScale {
    int randomScale = RANDOM_FLOAT(MIN_LEAF_SCALE, MAX_LEAF_SCALE);
    return MGPointMake(randomScale, randomScale, 1.0);
}

- (CGFloat)randomLifeTime {
    return RANDOM_FLOAT(MINSEC_TO_LEAF_DISAPPEARANCE, MAXSEC_TO_LEAF_DISAPPEARANCE);
}

- (void)changeColor {
    self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_hoja_roja.png"];
}

- (void)update {
    self.lifeTimeInUpdates--;
    if (self.lifeTimeInUpdates > 0){
        if (self.lifeTimeInUpdates <= self.beginningLifeTime/4.0) {
            [self changeColor];
        }
    }
    else { //(self.lifeTimeInUpdates <= 0) {
        [self removeMySelf];
    }
    [super update];
}


- (void)dealloc {
    [super dealloc];
}





@end
