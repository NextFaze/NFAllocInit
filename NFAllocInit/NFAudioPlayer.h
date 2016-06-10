//
//  NFAudioPlayer.h
//  NFAllocInit
//
//  Created by Ricardo Santos on 2/04/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NFAudioPlayer : NSObject <AVAudioPlayerDelegate>

+ (NFAudioPlayer *)sharedPlayer;

- (void)playSound:(NSString *)fileName;
+ (void)playSound:(NSString *)fileName;

- (void)playSoundWithURL:(NSURL *)URL;
+ (void)playSoundWithURL:(NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
