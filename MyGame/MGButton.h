//
//  MGButton.h
//  MyGame
//
//  Created by Marina Osés Merino on 30/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObject.h"


@class MGSceneController;


@interface MGButton : MGSceneObject {
    BOOL pressed;
    BOOL startedInButton;
    id _target;
    SEL _buttonBadAction;
    SEL _buttonGoodAction;
}

@property (nonatomic, retain) id target;
@property (nonatomic, assign) SEL buttonBadAction;
@property (nonatomic, assign) SEL buttonGoodAction;

- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)setPressedVertexes;
- (void)setNotPressedVertexes;
- (void)goodTouch;
- (void)badTouch;

@end
