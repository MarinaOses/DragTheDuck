//
//  MGTexturedButton.m
//  MyGame
//
//  Created by Marina Osés Merino on 03/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTexturedButton.h"


#import "MGSceneController.h"

@implementation MGTexturedButton
@synthesize upQuad = _upQuad;
@synthesize downQuad = _downQuad;

- (id)initWithSceneController:(MGSceneController *)scene_controller UpKey:(NSString *)up_key downKey:(NSString *)down_key {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        self.upQuad = [[MGMaterialController sharedMaterialController] quadFromKey:up_key];
        self.downQuad = [[MGMaterialController sharedMaterialController] quadFromKey:down_key];
        [self setNotPressedVertexes];
        
    }
    return self;
}

- (void)setNotPressedVertexes {
    self.mesh = self.upQuad;
}

- (void)setPressedVertexes {
    self.mesh = self.downQuad;
}

- (void)dealloc {
    [_upQuad release];
    [_downQuad release];
    [super dealloc];
}

@end
