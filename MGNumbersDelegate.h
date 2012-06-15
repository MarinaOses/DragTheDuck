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
    MGNumberPresenter *_numberPresenter;
    MGIconPresenter *_iconPresenter;
    NSMutableArray *_sceneObjects;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
}

@property (nonatomic, retain) MGNumberPresenter *numberPresenter;
@property (nonatomic, retain) MGIconPresenter *iconPresenter;
@property (nonatomic, retain) NSMutableArray *sceneObjects;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjects:(NSMutableArray *)scene_objects SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer;
- (void)initializeAllMembersOfStaff;
- (void)updateTheMarkerWith:(NSInteger)score;
@end
