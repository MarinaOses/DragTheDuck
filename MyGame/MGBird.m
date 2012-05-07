//
//  MGBird.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGBird.h"

#import "MGSceneController.h"

@interface MGBird()
+ (MGBird *)randomBirdWithScale:(NSRange)scaleRange WithSpeed:(NSRange)speedRange FromStandardBird:(MGBird *)standard_bird;

@end

@implementation MGBird


static NSInteger MGBirdVertexSize = 2;
static NSInteger MGBirdColorSize = 4;
static GLenum MGBirdRenderStyle = GL_LINE_LOOP;
static NSInteger MGBirdVertexCount = 4;
static CGFloat MGBirdVertexes[8] = {-0.5, -0.5, 0.5, -0.5, 0.5, 0.5, -0.5, 0.5};
static CGFloat MGBirdColorValues[16] ={1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0};



- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        self.speed = MGPointMake(0.0, 0.0, 0.0);
        MGMesh *meshToAssign = [[MGMesh alloc] initWithVertexes:MGBirdVertexes vertexCount:MGBirdVertexCount vertexSize:MGBirdVertexSize renderStyle:MGBirdRenderStyle];
        self.mesh = meshToAssign;
        [meshToAssign release];
        self.mesh.colors = MGBirdColorValues;
        self.mesh.colorSize = MGBirdColorSize;
    }
    return self;
}


#pragma mark - Obtener pájaros con tamaños y velocidad aleatorias

//Crea un pájaro con un tamaño y velocidad determinados
//Tanto una variable como la otra se calculan aleatoriamente entre todos los valores comprendidos en unos intervalos definidos en la librería de configuración

+ (MGBird *)randomBirdFromStandardBird:(MGBird *)standard_bird {
    return [MGBird randomBirdWithScale:NSMakeRange(MIN_BIRD_SCALE, MAX_BIRD_SCALE) 
                          WithSpeed:NSMakeRange(MIN_SPEED_IN_PIXELS_PER_UPDATE, MAX_SPEED_IN_PIXELS_PER_UPDATE) FromStandardBird:standard_bird];
}

+ (MGBird *)randomBirdWithScale:(NSRange)scaleRange 
                      WithSpeed:(NSRange)speedRange
               FromStandardBird:(MGBird *)standard_bird {
    
    CGFloat randomScale = RANDOM_INT(scaleRange.location, NSMaxRange(scaleRange));
    standard_bird.scale = MGPointMake(randomScale, randomScale, 1.0);
    //Se obtiene la anchura de la ventana teniendo en cuenta que en el juego es igual a la altura
    GLint maxHeightToAppearance = standard_bird.sceneController.openGLView.getBackingWidth;
    CGFloat randomAppearanceHeight = RANDOM_INT(0, maxHeightToAppearance) - maxHeightToAppearance/2;
    standard_bird.translation = MGPointMake(standard_bird.sceneController.openGLView.getBackingHeight/2, randomAppearanceHeight, 0.0);
    GLfloat speedToassign = RANDOM_INT(speedRange.location, NSMaxRange(speedRange));
    standard_bird.speed = MGPointMake(speedToassign, 0.0, 0.0);
    return standard_bird;
}


@end
