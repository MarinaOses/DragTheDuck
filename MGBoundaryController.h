//
//  MGBoundaryController.h
//  MyGame
//
//  Created by Marina Osés Merino on 25/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGScoreTransmitter.h"
#import "MGLifesController.h"

@class MGSceneController;
@class MGEggBreaker;
@class MGNest;
@class MGMobileObject;

@interface MGBoundaryController : NSObject {
    MGSceneController *_sceneController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGScoreTransmitter *_scoreTransmitter;
    MGEggBreaker *_eggBreaker;
    MGLifesController *_lifesController;
    NSMutableArray *_sceneObjects;
    MGSoundSourceObject *_soundSourceObject;
}

@property (nonatomic, retain) MGSceneController *sceneController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, retain) MGEggBreaker *eggBreaker;
@property (nonatomic, retain) MGLifesController *lifesController;
@property (nonatomic, retain) NSMutableArray *sceneObjects;
@property (nonatomic, retain) MGSoundSourceObject *soundSourceObject;


- (id)initWithSceneController:(MGSceneController *)scene_controller ScoreTransmitter:(MGScoreTransmitter *)score_transmitter SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer LifesController:(MGLifesController *)lifes_controller SceneObjects:(NSMutableArray *)scene_objects;
- (void)createEggBreaker;
- (void)checkIfItIsOutOfBondaries:(MGMobileObject *)mobile_object;
- (void)checkIf:(MGMobileObject *)mobile_object HasArrivedTo:(MGPoint)point FallingInDirection:(NSInteger)direction;
- (BOOL)hasTheNest:(MGNest *)nest arrivedToPointX:(CGFloat)point_x;
@end
