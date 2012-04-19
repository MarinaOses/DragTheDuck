//
//  SceneObject.m
//  MyGame
//
//  Created by Marina Osés Merino on 09/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObject.h"
#import "MGSceneController.h"


static CGFloat squareVertices[8] = {
    -0.5f, -0.5f,
    -0.5f, 0.5f,
    0.5f, -0.5f,
    0.5f, 0.5f
};

static CGFloat squareColors [16] = {
    0, 0, 1.0, 1.0,
    0, 1.0, 0, 1.0,
    0, 0, 0, 1.0,
    1.0, 0, 0, 1.0
};

@implementation MGSceneObject 

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        translation = MGPointMake(0.0, 0.0, 0.0);
        rotation = MGPointMake(0.0, 0.0, 0.0);
        scale = MGPointMake(50.0, 50.0, 1.0);
        
        taken = NO;
        
        sceneController = scene_controller;
        [sceneController retain];
        
        mesh = [[MGMesh alloc] initWithVertexes:squareVertices vertexCount:4 vertexSize:2 renderStyle:GL_TRIANGLE_STRIP];
        mesh.colors = squareColors;
        mesh.colorSize = 4;
        
        self.meshBounds = CGRectZero;
        self.screenRect = CGRectZero;
       
    }
    return self;
}



- (void)update {
    //Ha habido algún toque?
    //touchEvents contiene todos los toques o deslizamientos que se an hecho en pantalla
    NSSet *touchesSet = [sceneController.inputViewController touchEvents];
    for (MGTouch *atouch in touchesSet) {
        NSLog(@"%@", [atouch description]);
        //Se comprueba si el toque es sobre el objeto o no
        NSUInteger numberOfFingersOnView = [[atouch.event touchesForView:[sceneController.inputViewController view]] count];
        if (taken == NO) {
            if (atouch.phase == UITouchPhaseBegan && numberOfFingersOnView == 1) {
                if (CGRectContainsPoint(self.screenRect, atouch.location)) {
                    taken = !taken;
                }
            }
        }
        else { //taken == YES
            if (atouch.phase == UITouchPhaseEnded) {
                taken = !taken;
            }
            else if (atouch.phase == UITouchPhaseMoved) {
              
            }
        }
    }
    if (taken) {
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

- (CGRect)meshBounds {
    if (CGRectEqualToRect(_meshBounds, CGRectZero)) {
        _meshBounds = [MGMesh boundsOf:mesh WithScale:scale];
    }
    return _meshBounds;
    
}    

- (void)setMeshBounds:(CGRect)meshBounds {
    _meshBounds = meshBounds;
}

- (CGRect)screenRect {
    if (CGRectEqualToRect(_screenRect, CGRectZero)) {
         _screenRect = [sceneController.inputViewController screenRectFromMeshRect:self.meshBounds atPoint:CGPointMake(translation.x, translation.y)];
    }
    return _screenRect;
}


-(void)setScreenRect:(CGRect)screenRect {
    _screenRect = screenRect;
}


- (void)dealloc {
    [mesh release];
    [sceneController release];
    [super dealloc];
}


@end
