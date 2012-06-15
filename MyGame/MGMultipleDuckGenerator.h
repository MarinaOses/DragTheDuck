//
//  MGMultipleDuckGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGConfiguration.h"
#import "MGDuck.h"
#import "MGGenerator.h"


@class MGSceneController;

@interface MGMultipleDuckGenerator : NSObject <MGGenerator> {
    MGSceneController *_sceneController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGScoreTransmitter *_scoreTransmitter;
}

@property (nonatomic, retain) MGSceneController *sceneController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTrasnmitter:(MGScoreTransmitter *)score_transmitter;

@end
