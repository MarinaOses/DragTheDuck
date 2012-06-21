//
//  MGSceneObject.m
//  MyGame
//
//  Created by Marina Osés Merino on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObject.h"
#import "MGSceneController.h"
#import "MGCollider.h"

@implementation MGSceneObject 

@synthesize mesh = _mesh;
@synthesize sceneController = _sceneController;
@synthesize translation = _translation;
@synthesize rotation = _rotation;
@synthesize scale = _scale;
@synthesize matrix = _matrix;
@synthesize collider = _collider;
@synthesize positionOfNumber;


- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        self.translation = MGPointMake(0.0, 0.0, 0.0);
        self.rotation = MGPointMake(0.0, 0.0, 0.0);
        self.scale = MGPointMake(1.0, 1.0, 1.0);
        self.matrix = (CGFloat *)malloc(16 * sizeof(CGFloat));

        self.sceneController = scene_controller;
        self.meshBounds = CGRectZero;
        self.screenRect = CGRectZero;
        self.collider = nil;
        self.positionOfNumber = 0;
        
    }
    return self;
}



- (void)update {
    
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
    
    //La matriz que se ha contruido se guarda en la variable matrix
    glGetFloatv(GL_MODELVIEW_MATRIX, self.matrix);
    
    //Resauramos la matriz actual (quitamos la matriz de la cima de la pila)
    glPopMatrix();
    
    //Se hace el update de su correspondiente collider
    if (self.collider != nil) {
        [self.collider updateWith:self];
    }
}


- (void)render {
    
    //No hace falta que hagamosesta orden, ya que a la única pila que podemos acceder es a MODELVIEW
    //glMatrixMode(GL_MODELVIEW);
    if (!self.mesh) {
        return;
    }
    //Se hace una copia de la matriz actual y se deja al inicio de la pila
    glPushMatrix();
    glLoadIdentity();
    glMultMatrixf(self.matrix);
    [self.mesh render];
    
    //Resauramos la matriz actual (quitamos la matriz de la cima de la pila)
    glPopMatrix();
    if (self.collider != nil) {
        [self.collider render];
    }
    
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
    free(_matrix);
    [_sceneController release];
    [_collider release];
    [super dealloc];
}


@end