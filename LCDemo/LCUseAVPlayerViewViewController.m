//
//  LCUseAVPlayerViewViewController.m
//  LCDemo
//
//  Created by menglingchao on 2023/2/14.
//

#import "LCUseAVPlayerViewViewController.h"
#import "MLCAVPlayerView.h"

@interface LCUseAVPlayerViewViewController ()

@property (nonatomic, strong) MLCAVPlayerView *playerView;

@end

@implementation LCUseAVPlayerViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self usePlayer];
}
#pragma mark - Getter
- (MLCAVPlayerView *)playerView {
    if (_playerView) {
        return _playerView;
    }
    _playerView = [[MLCAVPlayerView alloc] init];
//    _playerView.player = self.player;
    [self.view addSubview:_playerView];
    [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    return _playerView;
}
#pragma mark -
- (void)usePlayer {
    self.playerView.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:@"http://192.168.112.218/xm/video/%E8%AF%B4%E5%A5%BD%E4%B8%8D%E5%93%AD.mp4"]];
//    self.playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    self.playerView.playerLayer.videoGravity = AVLayerVideoGravityResize;
//    self.playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.playerView.player play];
}

@end
