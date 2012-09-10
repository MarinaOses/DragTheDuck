//
//  MGSoundState.h
//  MyGame
//
//  Created by Marina Osés Merino on 10/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenAL/al.h>


@interface MGSoundState : NSObject {
    ALfloat gainLevel;
}

@property (nonatomic, assign) ALfloat gainLevel;

//Estas funciones deben sobreescribirse en las subclases
- (void)applyState;
- (void)update;

@end
