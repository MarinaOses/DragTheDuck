//
//  MGTransformationController.h
//  MyGame
//
//  Created by Marina Osés Merino on 21/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGDuck.h"
#import "MGTransformer.h"
#import "MGBee.h"

@interface MGTransformationController : NSObject {
    NSMutableArray *_sceneObjects;
    MGDuck *_duckWhoStartsTheTransformation;
}

@property (nonatomic, retain) NSMutableArray *sceneObjects;
@property (nonatomic, retain) MGDuck *duckWhoStartsTheTransformation;

- (id)initWithSceneObjects:(NSMutableArray *)scene_objects;

- (void)spawnBeeFrom:(MGDuck *)duck;
- (void)spawnDuckFrom:(MGTransformer *)transformer;
- (void)addAnEgg:(MGEgg *)egg;
@end
