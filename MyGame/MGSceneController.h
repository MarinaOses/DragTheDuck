//
//  MGSceneController.h
//  MyGame
//
//  Created by Marina Osés Merino on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "MGInputViewController.h"
#import "MGStateManager.h"
#import "MGTimeController.h"

@interface MGSceneController : NSObject {
        
    MGInputViewController *_inputViewController;
    EAGLView *_openGLView;
    MGStateManager *_stateManager;
    
    NSTimer *animationTimer;
    NSTimeInterval animationInterval;
    
    NSTimeInterval lastFrameTime;
    NSTimeInterval cyclesLeftOver;
    
    MGTimeController *_timeController;
}

@property (nonatomic, retain) MGInputViewController *inputViewController;
@property (nonatomic, retain) EAGLView *openGLView;
@property (nonatomic, retain) MGStateManager *stateManager;
@property (nonatomic, retain) MGTimeController *timeController;



- (id)init;
- (void)loadScene;
- (void)startScene;
- (void)stopAnimation;



@end
