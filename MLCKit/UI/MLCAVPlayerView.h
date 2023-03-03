//
//  MLCAVPlayerView.h
//  MLCKit
//
//  Created by menglingchao on 2023/1/30.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

@interface MLCAVPlayerView : UIView

@property (nonatomic, strong, readonly) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;

@end
