//
//  MLCAVPlayerView.m
//  MLCKit
//
//  Created by menglingchao on 2023/1/30.
//

#import "MLCAVPlayerView.h"

@implementation MLCAVPlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}
- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}
- (AVPlayer *)player {
    return self.playerLayer.player;
}
- (void)setPlayer:(AVPlayer *)player {
    self.playerLayer.player = player;
}


@end
