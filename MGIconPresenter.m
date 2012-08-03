//
//  MGIconPresenter.m
//  MyGame
//
//  Created by Marina Osés Merino on 15/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGIconPresenter.h"


//static NSInteger MGIconVertexSize = 2;
//static NSInteger MGIconColorSize = 4;
//static GLenum MGIconRenderStyle = GL_TRIANGLE_STRIP;
//static NSInteger MGIconVertexCount = 4;
//static CGFloat MGIconVertexes[8] = {
//    -0.5, -0.5, 
//    0.5, -0.5,
//    -0.5, 0.5,
//    0.5, 0.5
//};
//
//static CGFloat MGSavedDucksIconColorValues[16] = {
//    1.0, 0.0, 0.0, 1.0, 
//    0.0, 1.0, 0.0, 1.0, 
//    0.0, 0.0, 1.0, 1.0, 
//    1.0, 1.0, 1.0, 1.0
//};
//
//static CGFloat MGKilledBirdsIconColorValues[16] = {
//    1.0, 1.0, 1.0, 1.0, 
//    0.0, 1.0, 0.0, 1.0, 
//    0.0, 0.0, 1.0, 1.0, 
//    0.0, 0.0, 0.0, 1.0
//};

@implementation MGIconPresenter
@synthesize sceneController = _sceneController;

- (id)initWithSceneController:(MGSceneController *)scene_controller StartPointOfTheNumberThatComesAfter:(MGPoint)start_point_of_the_number_that_comes_after ScaleOfPresentation:(MGPoint)scale_of_presentation {
    self = [super init];
    if (self) {
        startPointOfTheNumberThatComesAfter = start_point_of_the_number_that_comes_after;
        scaleOfPresentation = scale_of_presentation;
        
        self.sceneController = scene_controller;
    }
    return self;
}

- (MGSceneObject *)createIconObject {
    MGSceneObject *icon = [[MGSceneObject alloc] initWithSceneController:self.sceneController];
//    MGMesh *meshToAssign = [[MGMesh alloc] initWithVertexes:MGIconVertexes vertexCount:MGIconVertexCount vertexSize:MGIconVertexSize renderStyle:MGIconRenderStyle];
//    icon.mesh = meshToAssign;
//    [meshToAssign release];
//    icon.mesh.colorSize = MGIconColorSize;
    if (startPointOfTheNumberThatComesAfter.y == SAVED_DUCKS_SCORE_START_Y) {
        //icon.mesh.colors = MGSavedDucksIconColorValues;
        icon.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_icono_patito.png"];
    }
    else {
        //icon.mesh.colors = MGKilledBirdsIconColorValues;
        icon.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_icono_pajaro_muerto.png"];
    }
    icon.scale = scaleOfPresentation;
    icon.translation = MGPointMake(startPointOfTheNumberThatComesAfter.x - CGRectGetWidth(icon.meshBounds)/2 - SPACE_BETWEEN_ICON_NUMBERS, startPointOfTheNumberThatComesAfter.y, startPointOfTheNumberThatComesAfter.z);
    return [icon autorelease];
}

- (void)dealloc {
    [_sceneController release];
    [super dealloc];
}

@end
