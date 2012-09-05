//
//  MGSoundButton.h
//  MyGame
//
//  Created by Marina Osés Merino on 05/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTexturedButton.h"

@class MGSceneController;

@interface MGSoundButton : MGTexturedButton {
    BOOL enabled;
}

- (id)initWithSceneController:(MGSceneController *)scene_controller UpKey:(NSString *)up_key downKey:(NSString *)down_key Enabled:(BOOL)isEnabled;

@end
