//
//  TimedMultipleBirdGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGMultipleBirdGenerator.h"

@class MGSceneController;

@interface MGTimedMultipleBirdGenerator : NSObject {
    NSMutableArray *_birdsToAdd;
    MGMultipleBirdGenerator *_multipleBirdGenerator;
    NSTimer *generatorTimer;
}

@property (nonatomic, retain) NSMutableArray *birdsToAdd;
@property (nonatomic, retain) MGMultipleBirdGenerator *multipleBirdGenerator;

- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)loadNewBirdsWaveToAdd;
- (void)startNextTimer;
- (void)clearBirdsToAdd;
- (void)stopGeneratorTimer;


@end
