//
//  MGSceneController.h
//  MyGame
//
//  Created by Marina Osés Merino on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGInputViewController.h"
#import "MGStateManager.h"

@interface MGSceneController : NSObject {
    
    NSMutableArray *sceneObjects;
    
    MGInputViewController *_inputViewController;
    EAGLView *_openGLView;
    MGStateManager *_stateManager;
    
    NSTimer *animationTimer;
    NSTimeInterval animationInterval;
    
    NSTimeInterval lastFrameTime;
    NSTimeInterval cyclesLeftOver;
    
}

@property (nonatomic, retain) MGInputViewController *inputViewController;
@property (nonatomic, retain) EAGLView *openGLView;
@property (nonatomic, retain) MGStateManager *stateManager;


- (id)init;
- (void)loadScene;
- (void)startScene;



@end
