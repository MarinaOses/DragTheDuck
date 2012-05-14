//
//  MGBird.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGBird.h"

#import "MGSceneController.h"

@implementation MGBird


static NSInteger MGBirdVertexSize = 2;
static NSInteger MGBirdColorSize = 4;
static GLenum MGBirdRenderStyle = GL_TRIANGLE_STRIP;
static NSInteger MGBirdVertexCount = 4;
static CGFloat MGBirdVertexes[8] = {
    -0.5, -0.5, 
    0.5, -0.5,
    -0.5, 0.5,
    0.5, 0.5
};
static CGFloat MGBirdColorValues[16] ={
    1.0, 0.0, 0.0, 1.0, 
    1.0, 0.0, 0.0, 1.0, 
    1.0, 0.0, 0.0, 1.0, 
    1.0, 0.0, 0.0, 1.0
};



- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        MGMesh *meshToAssign = [[MGMesh alloc] initWithVertexes:MGBirdVertexes vertexCount:MGBirdVertexCount vertexSize:MGBirdVertexSize renderStyle:MGBirdRenderStyle];
        self.mesh = meshToAssign;
        [meshToAssign release];
        self.mesh.colors = MGBirdColorValues;
        self.mesh.colorSize = MGBirdColorSize;
    }
    return self;
}


//Crea un pájaro con un tamaño y velocidad determinados
//Tanto una variable como la otra se calculan aleatoriamente entre todos los valores comprendidos en unos intervalos definidos en la librería de configuración

- (id)initRandomWithSceneCotroller:(MGSceneController *)scene_controller Scale:(NSRange)scale_range Speed:(NSRange)speed_range {
    self = [self initWithSceneController:scene_controller];
    
    CGFloat randomScale = RANDOM_INT(scale_range.location, scale_range.length);
    self.scale = MGPointMake(randomScale, randomScale, 1.0);
    //NSLog(@"scale(%f, %f, %f)",self.scale.x, self.scale.y, self.scale.z);
    
    
    //Se obtiene la anchura de la ventana teniendo en cuenta que en el juego es igual a la altura
    CGFloat maxHeightToAppearance = CGRectGetWidth(self.sceneController.openGLView.window.frame);
    
    CGFloat randomAppearanceHeight = RANDOM_INT(0, (int)maxHeightToAppearance) - maxHeightToAppearance/2;
    self.translation = MGPointMake(CGRectGetMidY(self.sceneController.openGLView.window.frame), randomAppearanceHeight, 0.0);
    //NSLog(@"translation(%f, %f, %f)",self.translation.x, self.translation.y, self.translation.z);
    
    
    GLfloat speedToassign = RANDOM_INT(speed_range.location, speed_range.length)/100.0;
    self.speed = MGPointMake(-speedToassign, 0.0, 0.0);
    //NSLog(@"speed(%f, %f, %f)",self.speed.x, self.speed.y, self.speed.z);
    return self;
}

- (id)initRandomWithSceneController:(MGSceneController *)scene_controller {
    self = [self initRandomWithSceneCotroller:scene_controller 
                                        Scale:NSMakeRange(MIN_BIRD_SCALE, MAX_BIRD_SCALE) 
                                        Speed:NSMakeRange(MIN_BIRD_SPEED, MAX_BIRD_SPEED)];
    return self;
}


-(void)removeIfItIsOutOfArena {
    BOOL outOfArena = NO;
    CGFloat midYOfWindowRect = CGRectGetMidY(self.sceneController.openGLView.window.frame);
    CGFloat midYOfMeshRect = CGRectGetMidY(self.meshBounds);
    CGFloat midXOfWindowRect = CGRectGetMidX(self.sceneController.openGLView.window.frame);
    CGFloat midXOfMeshRect = CGRectGetMidX(self.meshBounds);
    CGFloat centerX = self.translation.x;
    CGFloat centerY = self.translation.y;
    
    if (centerX > (midYOfWindowRect + midXOfMeshRect)) {
        outOfArena = YES;    
    }   
    if (centerX < (-midYOfWindowRect - midXOfMeshRect)) {
        outOfArena = YES;
    }
    
    if (centerY > (midXOfWindowRect + midYOfMeshRect)) {
        outOfArena = YES;
    }
    
    if (centerY < (-midXOfWindowRect - midYOfMeshRect)) {
        outOfArena = YES;
    }
    
    if (outOfArena) {
        MGPlayState *actualPlayState = (MGPlayState *)[[self.sceneController stateManager] activeState];
        [[actualPlayState birdDestroyer] markToRemoveBird:self]; 
    }
}


- (void)update {
    [self removeIfItIsOutOfArena];
    [super update];
}

- (void)dealloc {
    [super dealloc];
}


@end
