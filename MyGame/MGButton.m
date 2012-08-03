//
//  MGButton.m
//  MyGame
//
//  Created by Marina Osés Merino on 30/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGButton.h"
#import "MGSceneController.h"

@interface MGButton () 
//nonatomic -- no serializable. 

- (void)handleTouches;
@end

//static NSInteger MGSquareVertexSize = 2;
//static NSInteger MGSquareColorSize = 4;
//static GLenum MGSquareOutlineRenderStyle = GL_LINE_LOOP;
//static NSInteger MGSquareOutlineVertexCount = 4;
//static CGFloat MGSquareOutlineVertexes[8] = {-0.5, -0.5, 0.5, -0.5, 0.5, 0.5, -0.5, 0.5};
//static CGFloat MGSquareOutlineColorValues[16] ={1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0};
////Parra comprobar que el botón se pulsa
//static GLenum MGSquareFillRenderStyle = GL_TRIANGLE_STRIP;
//static NSInteger MGSquareFillVertexesCount = 4;
//static CGFloat MGSquareFillVertexes[8] = {-0.5, -0.5, 0.5, -0.5, -0.5, 0.5, 0.5, 0.5};



@implementation MGButton

@synthesize target = _target;
@synthesize buttonBadAction = _buttonBadAction;
@synthesize buttonGoodAction = _buttonGoodAction;


- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        pressed = NO;
        startedInButton = NO;
//        MGMesh *meshToAssign = [[MGMesh alloc] initWithVertexes:MGSquareOutlineVertexes vertexCount:MGSquareOutlineVertexCount vertexSize:MGSquareVertexSize renderStyle:MGSquareOutlineRenderStyle];
//        self.mesh = meshToAssign;
//        [meshToAssign release];
//        self.mesh.colorSize = MGSquareColorSize;
//        self.mesh.colors = MGSquareOutlineColorValues;
    }
    return self;
}

- (void)update {
    [self handleTouches];
    [super update];
}

- (void)handleTouches {
    NSSet *touchesHandler = [self.sceneController.inputViewController touchEvents];
    //Si no hay toques salimos rápido de la función
    if ([touchesHandler count] == 0) {
        return;
    }
    BOOL pointInBounds = NO;
    CGRect screenRectToAccess = self.screenRect;
    CGRect touchableArea = CGRectMake(CGRectGetMinX(screenRectToAccess) - ADD_TO_SCREENRECT_OF_BUTTONS, CGRectGetMinY(self.screenRect) - ADD_TO_SCREENRECT_OF_BUTTONS, CGRectGetWidth(screenRectToAccess) + ADD_TO_SCREENRECT_OF_BUTTONS*2, CGRectGetHeight(screenRectToAccess) + ADD_TO_SCREENRECT_OF_BUTTONS*2);
    for (MGTouch *handleTouch in touchesHandler) {
        if (CGRectContainsPoint(touchableArea, [handleTouch location]) &&  handleTouch.numberOfFingersOnTheScreen == 1) {
            pointInBounds = YES;
            switch (handleTouch.phase) {
                case UITouchPhaseBegan:
                    startedInButton = YES;
                    break;
                case UITouchPhaseEnded:
                    if (startedInButton) {
                        [self goodTouch];
                    }
                    break;
                default:
                    break;
            }
        }
        if (handleTouch.phase == UITouchPhaseEnded && handleTouch.numberOfFingersOnTheScreen == 1) {
            startedInButton = NO;
        }
    }
    if (!pointInBounds) {
        [self badTouch];
    }
}

- (void)goodTouch {

    if (pressed) {
        return;
    }
    pressed = YES;
    [self setPressedVertexes];
    [self.target performSelector:self.buttonGoodAction];
    pressed = NO;
}

-(void)badTouch {
    if (!pressed) {
        return;
    }
    pressed = NO;
    [self setNotPressedVertexes];
    [self.target performSelector:self.buttonBadAction];
}

- (void)setNotPressedVertexes {
//    self.mesh.vertexes = MGSquareOutlineVertexes;
//    self.mesh.renderStyle = MGSquareOutlineRenderStyle;
//    self.mesh.vertexCount = MGSquareOutlineVertexCount;
//    self.mesh.colors = MGSquareOutlineColorValues;
}

- (void)setPressedVertexes {
//    self.mesh.vertexes = MGSquareFillVertexes;
//    self.mesh.renderStyle = MGSquareFillRenderStyle;
//    self.mesh.vertexCount = MGSquareFillVertexesCount;
//    self.mesh.colors = MGSquareOutlineColorValues;
}




- (void)dealloc {
    [super dealloc];
}

@end
