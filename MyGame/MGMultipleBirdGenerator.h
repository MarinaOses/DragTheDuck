//
//  MultipleBirdGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGConfiguration.h"
#import "MGBird.h"

@class MGSceneController;

@interface MGMultipleBirdGenerator : NSObject {
    MGSceneController *_sceneController;

}

@property (nonatomic, retain) MGSceneController *sceneController;

- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (NSArray *)createBirdsWave;

@end
