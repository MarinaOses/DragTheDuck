//
//  MGSoundButton.m
//  MyGame
//
//  Created by Marina Osés Merino on 05/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSoundButton.h"

#import "MGSceneController.h"

@implementation MGSoundButton


- (id)initWithSceneController:(MGSceneController *)scene_controller UpKey:(NSString *)up_key downKey:(NSString *)down_key Enabled:(BOOL)isEnabled {
    self = [super initWithSceneController:scene_controller UpKey:up_key downKey:down_key];
    if (self) {
        enabled = isEnabled;
        if (enabled) {
            [self setPressedVertexes];
        }
        else {
            [self setNotPressedVertexes];
        }
    }
    return self;
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
        if (CGRectContainsPoint(touchableArea, [handleTouch location])) {
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
        else {
            pointInBounds = NO;
        }
        if (handleTouch.phase == UITouchPhaseEnded) {
            startedInButton = NO;
            pressed = NO;
            
        }
    }
    if (!pointInBounds) {
        [self badTouch];
    }
}

- (void)goodTouch {
    if (!pressed) {
        [self playSound];
        if (enabled) {
            [self setNotPressedVertexes];
            enabled = NO;
        }
        else {
            [self setPressedVertexes];
            enabled = YES;
        }
        pressed = YES;
        [self.target performSelector:self.buttonGoodAction];
    }
}


@end
