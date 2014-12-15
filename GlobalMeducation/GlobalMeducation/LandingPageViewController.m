//
//  LandingPageViewController.m
//  GlobalMeducation
//
//  Created by Amanda Doyle on 12/14/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "LandingPageViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface LandingPageViewController ()
@property (strong, nonatomic) MPMoviePlayerController *player;
@property (weak, nonatomic) IBOutlet UIButton *mazeButton;
@property (weak, nonatomic) IBOutlet UIImageView *postVideo;
@end

@implementation LandingPageViewController
@synthesize player;
@synthesize mazeButton;
@synthesize postVideo;

- (void)viewDidLoad {
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterMaze:(id)sender {
    NSString *filepath   =   [[NSBundle mainBundle] pathForResource:@"MazeTransition" ofType:@"mp4"];
    NSURL    *fileURL    =   [NSURL fileURLWithPath:filepath];
    
    player = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [self.view addSubview:player.view];
    player.fullscreen = YES;
    player.controlStyle = MPMovieControlStyleNone;
    [player prepareToPlay];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish2:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:player];
}

- (IBAction)pressedStart:(id)sender {
    NSString *filepath   =   [[NSBundle mainBundle] pathForResource:@"Intro" ofType:@"mp4"];
    NSURL    *fileURL    =   [NSURL fileURLWithPath:filepath];
    
    player = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [self.view addSubview:player.view];
    player.fullscreen = YES;
    player.controlStyle = MPMovieControlStyleNone;
    [player prepareToPlay];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:player];
    postVideo.hidden = NO;
    mazeButton.alpha = 0.0;
    mazeButton.hidden = NO;
    
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    
    [player.view removeFromSuperview];
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{mazeButton.alpha = .85;}
                     completion:nil];

}

- (void) moviePlayBackDidFinish2:(NSNotification*)notification {
    
    [self performSegueWithIdentifier:@"toMaze" sender:self];
    [player.view removeFromSuperview];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
