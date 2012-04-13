//
//  SceneObject.m
//  MyGame
//
//  Created by Marina Osés Merino on 09/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneObject.h"
#import "MGSceneController.h"


static CGFloat squareVertices[8] = {
    -0.5f, -0.5f,
    -0.5f, 0.5f,
    0.5f, -0.5f,
    0.5f, 0.5f
};

static CGFloat squareColors [16] = {
    1.0, 1.0, 0, 1.0,
    0, 1.0, 1.0, 1.0,
    0, 0, 0, 0,
    1.0, 0, 1.0, 1.0
};

@implementation SceneObject 

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        translation = MGPointMake(0.0, 0.0, 0.0);
        rotation = MGPointMake(0.0, 0.0, 0.0);
        scale = MGPointMake(1.0, 1.0, 1.0);
        
        active = NO;
        sceneController = scene_controller;
        [sceneController retain];
    }
    return self;
}

- (void)awake {
    mesh = [[MGMesh alloc] initWithVertexes:squareVertices vertexCount:4 vertexSize:2 renderStyle:GL_TRIANGLE_STRIP];
    mesh.colors = squareVertices;
    mesh.colorSize = 4;
}


- (void)update {
    //Ha habido algún toque?
    //touchEvents contiene todos los toques o deslizamientos que se an hecho en pantalla
    NSSet *touches = [sceneController.inputViewController touchEvents];
    for (UITouch *touch in [touches allObjects]) {
        //Modificamos el estado del cuadrado (parado o moviendose) si el toque es de tipo "ended" 
        if (touch.phase == UITouchPhaseEnded) {
            active = !active;
        }
    }
    if (active) {
        //rota el eje z del cuadrado 3 grados
        rotation.z += 3;
    }
}

- (void)render {
    //Se hace una copia de la matriz actual y se deja al inicio de la pila
    glPushMatrix();
    glLoadIdentity();
    
    //Mover a la posicion correspondiente
    glTranslatef(translation.x, translation.y, translation.z);
    
    //Rotar
    glRotatef(rotation.x, 1.0f, 0.0f, 0.0f);
    glRotatef(rotation.y, 0.0f, 1.0f, 0.0f);
    glRotatef(rotation.z, 0.0f, 0.0f, 1.0f);
    
    
    //Escalar
    glScalef(scale.x, scale.y, scale.z);
    
    [mesh render];
    
    //Resauramos la matriz actual (quitamos la matriz de la cima de la pila)
    glPopMatrix();
    
}

- (void)dealloc {
    [mesh release];
    [sceneController release];
    [super dealloc];
}


@end
