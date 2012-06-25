//
//  MGBoundaryController.h
//  MyGame
//
//  Created by Marina Osés Merino on 25/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGScoreTransmitter.h"


@class MGSceneController;
@class MGMobileObject;

@interface MGBoundaryController : NSObject {
    MGSceneController *_sceneController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGScoreTransmitter *_scoreTransmitter;
}

@property (nonatomic, retain) MGSceneController *sceneController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;


- (id)initWithSceneController:(MGSceneController *)scene_controller ScoreTransmitter:(MGScoreTransmitter *)score_transmitter SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer;

- (void)checkIfItIsOutOfBondaries:(MGMobileObject *)mobile_object;
@end
