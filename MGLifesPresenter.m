//
//  MGLifesPresenter.m
//  MyGame
//
//  Created by Marina Osés Merino on 26/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGLifesPresenter.h"

#import "MGSceneController.h"

//static NSInteger MGLifesVertexSize = 2;
//static NSInteger MGLifesColorSize = 4;
//static GLenum MGLifesRenderStyle = GL_TRIANGLE_STRIP;
//static NSInteger MGLifesVertexCount = 4;
//static CGFloat MGLifesVertexes[8] = {
//    -0.5, -0.5, 
//    0.5, -0.5,
//    -0.5, 0.5,
//    0.5, 0.5
//};
//
//static CGFloat MGLifesColorValues[16] ={
//    0.9, 0.8, 0.7, 1.0, 
//    0.9, 0.8, 0.7, 1.0, 
//    0.9, 0.8, 0.7, 1.0, 
//    0.9, 0.8, 0.7, 1.0
//};

@implementation MGLifesPresenter 
@synthesize sceneController = _sceneController;



- (id)initWithSceneController:(MGSceneController *)scene_controller FirstTranslation:(MGPoint)first_translation ScaleOfPresentation:(MGPoint)scale_of_presentation {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        firstTranslation = first_translation;
        scaleOfPresentation = scale_of_presentation;
    }
    return self;
}

- (MGSceneObject *)createALife {
    MGSceneObject *obj = [[MGSceneObject alloc] initWithSceneController:self.sceneController];
//    MGMesh *meshToAssign = [[MGMesh alloc] initWithVertexes:MGLifesVertexes vertexCount:MGLifesVertexCount vertexSize:MGLifesVertexSize renderStyle:MGLifesRenderStyle];
//    obj.mesh = meshToAssign;
//    [meshToAssign release];
//    obj.mesh.colorSize = MGLifesColorSize;
//    obj.mesh.colors = MGLifesColorValues;
    obj.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_egg.png"];    
    obj.collider = [[MGCollider alloc] initWithSceneController:self.sceneController];
    
    obj.scale = scaleOfPresentation;
    return [obj autorelease];
}

- (NSMutableArray *)createLifesMarkerWith:(NSInteger)number_of_lifes {
    NSInteger i;
    NSMutableArray *lifesMarkerToAutorelease = [[NSMutableArray alloc] initWithCapacity:number_of_lifes];
    for (i = 0; i < number_of_lifes; i++) {
        MGSceneObject *life = [self createALife];
        life.translation = MGPointMake(firstTranslation.x + i*(CGRectGetWidth(life.meshBounds)+SPACE_BETWEEN_LIFE_LIFE), firstTranslation.y, firstTranslation.z);
        [lifesMarkerToAutorelease addObject:life];
    }
    return [lifesMarkerToAutorelease autorelease];
}




- (void)dealloc {
    [_sceneController release];
    [super dealloc];
}

@end
