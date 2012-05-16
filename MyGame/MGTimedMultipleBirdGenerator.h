//
//  TimedMultipleBirdGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGMultipleDuckGenerator.h"

@class MGSceneController;

@interface MGTimedMultipleBirdGenerator : NSObject {
    NSMutableArray *_birdsToAdd;
    MGMultipleDuckGenerator *_multipleBirdGenerator;
    NSTimer *generatorTimer;
}

@property (nonatomic, retain) NSMutableArray *birdsToAdd;
@property (nonatomic, retain) MGMultipleDuckGenerator *multipleBirdGenerator;


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer;
- (void)loadNewBirdsWaveToAdd;
- (void)startNextTimer;
- (void)clearBirdsToAdd;
- (void)stopGeneratorTimer;


@end
