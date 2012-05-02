//
//  MGSceneObject.m
//  MyGame
//
//  Created by Marina Osés Merino on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObject.h"
#import "MGSceneController.h"


@implementation MGSceneObject 

@synthesize mesh = _mesh;
@synthesize sceneController = _sceneController;
@synthesize translation = _translation;
@synthesize rotation = _rotation;
@synthesize scale = _scale;


- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        self.translation = MGPointMake(0.0, 0.0, 0.0);
        self.rotation = MGPointMake(0.0, 0.0, 0.0);
        self.scale = MGPointMake(1.0, 1.0, 1.0);
        
        self.sceneController = scene_controller;
        
        self.meshBounds = CGRectZero;
        self.screenRect = CGRectZero;
        
    }
    return self;
}



- (void)update {
    //Ha habido algún toque?
    //touchEvents contiene todos los toques o deslizamientos que se an hecho en pantalla
//    NSSet *touchesSet = [self.sceneController.inputViewController touchEvents];
//    for (MGTouch *atouch in touchesSet) {
//        NSLog(@"%@", [atouch description]);
//        NSLog(@"screenRectX: %d to %d", (int)self.screenRect.origin.x,  (int)self.screenRect.origin.x+(int)CGRectGetWidth(self.screenRect));
//        NSLog(@"screenRectY: %d to %d", (int)self.screenRect.origin.y,  (int)self.screenRect.origin.y+(int)CGRectGetHeight(self.screenRect));
//        if (atouch.phase == UITouchPhaseBegan && atouch.numberOfFingersOnTheScreen == 1) {
//            if (CGRectContainsPoint(self.screenRect, atouch.location)) {
//                taken = YES;
//            }
//        }
//        else if (atouch.phase == UITouchPhaseMoved && taken == YES) {
//            translation = [self.sceneController.inputViewController meshCenterFromMGTouchLocation:atouch.location];
//        }
//        else if (atouch.phase == UITouchPhaseEnded){
//            taken = NO;
//        }
//    }
}


- (void)render {
    
    //No hace falta que hagamosesta orden, ya que a la única pila que podemos acceder es a MODELVIEW
    //glMatrixMode(GL_MODELVIEW);

    //Se hace una copia de la matriz actual y se deja al inicio de la pila
    glPushMatrix();
    glLoadIdentity();
    
    //Mover a la posicion correspondiente
    glTranslatef(self.translation.x, self.translation.y, self.translation.z);
    
    //Rotar
    glRotatef(self.rotation.x, 1.0f, 0.0f, 0.0f);
    glRotatef(self.rotation.y, 0.0f, 1.0f, 0.0f);
    glRotatef(self.rotation.z, 0.0f, 0.0f, 1.0f);
    
    //Escalar
    glScalef(self.scale.x, self.scale.y, self.scale.z);
    
    [self.mesh render];
    
    //Resauramos la matriz actual (quitamos la matriz de la cima de la pila)
    glPopMatrix();
    
}

- (CGRect)meshBounds {
    if (CGRectEqualToRect(_meshBounds, CGRectZero)) {
        _meshBounds = [MGMesh boundsOf:self.mesh WithScale:self.scale];
    }
    return _meshBounds;
    
}    

- (void)setMeshBounds:(CGRect)meshBounds {
    _meshBounds = meshBounds;
}


- (CGRect)screenRect {
    _screenRect = [self.sceneController.inputViewController screenRectFromMeshRect:self.meshBounds atPoint:CGPointMake(self.translation.x, self.translation.y)];
    return _screenRect;
}


-(void)setScreenRect:(CGRect)screenRect {
    _screenRect = screenRect;
}


- (void)dealloc {
    [_mesh release];
    [_sceneController release];
    [super dealloc];
}


@end