//
//  NFAudioPlayer.m
//  NFAllocInit
//
//  Created by Ricardo Santos on 2/04/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import "NFAudioPlayer.h"

@interface NFAudioPlayer ()

@property (nonatomic, strong) NSMutableArray *players;

@end

@implementation NFAudioPlayer

+ (NFAudioPlayer *)sharedPlayer
{
	static NFAudioPlayer *instance = nil;
	if (!instance) {
		instance = [[NFAudioPlayer alloc] init];
	}
	return instance;
}

-(id) init
{
    self = [super init];
    
    if (!self) return nil;
    
    self.players = [NSMutableArray array];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error: nil];
    
	return self;
}

#pragma mark -

+ (NSURL *)urlForSound:(NSString *)fileName {
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], fileName]];
}

#pragma mark - Audio Control

- (void)playSound:(NSString*)fileName
{
    NSError *error;
    NSURL *url = [NFAudioPlayer urlForSound:fileName];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [player setDelegate:self];
    
    if (player) {
		[player play];
        [self.players addObject:player]; //need to keep a reference or else ARC will release player before it plays
    
    } else {
		NFLog(@"ERROR: Failed to play effect %@ due to error %@", fileName, [error description]);
    }
}

+ (void)playSound:(NSString *)fileName
{
    [[NFAudioPlayer sharedPlayer] playSound:fileName];
}

- (void)playSoundWithURL:(NSURL *)URL
{
    NSError *error;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:URL error:&error];
    [player setDelegate:self];
    
    if (player) {
		[player play];
        [self.players addObject:player]; //need to keep a reference or else ARC will release player before it plays
    
    } else {
		NFLog(@"ERROR: Failed to play effect %@ due to error %@", URL, [error description]);
    }
}

+ (void)playSoundWithURL:(NSURL *)URL
{
    [[NFAudioPlayer sharedPlayer] playSoundWithURL:URL];
}

#pragma mark - AVAudioPlayerDelegate

/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //NFLog(@"");
    [self.players removeObject:player];
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    //NFLog(@"ERROR: %@", error);
    [self.players removeObject:player];
}

@end
