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
#import "MGTimeController.h"
#import "MGCollisionController.h"

@interface MGSceneController : NSObject {
        
    MGInputViewController *_inputViewController;
    EAGLView *_openGLView;
    MGStateManager *_stateManager;
    
    NSTimer *animationTimer;
    NSTimeInterval animationInterval;
    
    NSTimeInterval lastFrameTime;
    NSTimeInterval cyclesLeftOver;
    
    MGTimeController *_timeController;
    MGCollisionController *_collisionController;
}

@property (nonatomic, retain) MGInputViewController *inputViewController;
@property (nonatomic, retain) EAGLView *openGLView;
@property (nonatomic, retain) MGStateManager *stateManager;
@property (nonatomic, retain) MGTimeController *timeController;
@property (nonatomic, retain) MGCollisionController *collisionController;


- (id)init;
- (void)loadScene;
- (void)startScene;



@end
