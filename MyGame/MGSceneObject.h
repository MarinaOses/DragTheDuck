//
//  MGSceneObject.h
//  MyGame
//
//  Created by Marina Osés Merino on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGPoint.h"
#import "MGMesh.h"

@class MGSceneController;

@interface MGSceneObject : NSObject {
    MGPoint _translation;
    MGPoint _rotation;
    MGPoint _scale;
    
    MGMesh *_mesh;
    CGRect _meshBounds;
    
    //Rectángulo al que pertenecen todos los vértices del objeto 
    CGRect _screenRect;
    CGPoint screenRectCenter;
    
    //BOOL taken;
    
    MGSceneController *_sceneController;
}


@property (nonatomic, assign) MGPoint translation;
@property (nonatomic, assign) MGPoint rotation;
@property (nonatomic, assign) MGPoint scale;
@property (nonatomic, assign) CGRect meshBounds; //NO @synthesize
@property (nonatomic, assign) CGRect screenRect; //NO @synthesize
@property (nonatomic, retain) MGMesh *mesh;
@property (nonatomic, retain) MGSceneController *sceneController;


- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)update;

@end