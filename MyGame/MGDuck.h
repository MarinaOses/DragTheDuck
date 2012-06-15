//
//  MGDuck.h
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMobileObject.h"
#import "MGCollisionable.h"
#import "MGScoreTransmitter.h"

@class MGSceneController;


@interface MGDuck : MGMobileObject <MGCollisionable> {
    MGScoreTransmitter *_scoreTransmitter;
    BOOL draggeable;
}


@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, assign) BOOL draggeable;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTrasnmitter:(MGScoreTransmitter *)score_transmitter;



@end
