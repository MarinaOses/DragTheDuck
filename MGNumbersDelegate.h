//
//  MGNumbersDelegate.h
//  MyGame
//
//  Created by Marina Osés Merino on 08/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGNumberPresenter.h"
#import "MGIconPresenter.h"
#import "MGSceneObjectDestroyer.h"

@interface MGNumbersDelegate : NSObject {
    MGNumberPresenter *_savedDucksPresenter;
    MGNumberPresenter *_killedBirdsPresenter;
    MGIconPresenter *_savedDucksIconPresenter;
    MGIconPresenter *_killedBirdsIconPresenter;
    NSMutableArray *_sceneObjects;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    //Es necesario recordarlo porque en el momento en que termine el poder de la abeja se debe quitar el marcador de los pájaros muertos.
    MGSceneObject *_killedBirdsIcon;
}

@property (nonatomic, retain) MGNumberPresenter *savedDucksPresenter;
@property (nonatomic, retain) MGNumberPresenter *killedBirdsPresenter;
@property (nonatomic, retain) MGIconPresenter *savedDucksIconPresenter;
@property (nonatomic, retain) MGIconPresenter *killedBirdsIconPresenter;
@property (nonatomic, retain) NSMutableArray *sceneObjects;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGSceneObject *killedBirdsIcon;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjects:(NSMutableArray *)scene_objects SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer;
- (void)initializeAllMembersOfStaff;
- (void)initializeKilledBirdsMarker;
- (void)updateTheMarker:(NSInteger)position_of_number With:(NSInteger)score;
- (void)removeKilledBirdsMarker;
@end
