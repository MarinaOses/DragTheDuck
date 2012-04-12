//
//  MGSceneController.h
//  MyGame
//
//  Created by Marina Osés Merino on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGInputViewController.h"
#import "EAGLView.h"

@interface MGSceneController : NSObject {
    
    NSMutableArray *sceneObjects;
    
    MGInputViewController *_inputViewController;
    EAGLView *_openGLView;
    
    NSTimer *animationTimer;
    NSTimeInterval animationInterval;
    
    NSTimeInterval lastFrameTime;
    NSTimeInterval cyclesLeftOver;
    
}

@property (nonatomic, retain) MGInputViewController *inputViewController;
@property (nonatomic, retain) EAGLView *openGLView;


- (id)init;
- (void)loadScene;
- (void)startScene;



@end
