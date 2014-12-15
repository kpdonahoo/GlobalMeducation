//
//  ISpyViewController.m
//  GlobalMeducation
//
//  Created by Amanda Doyle on 12/14/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "ISpyViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ISpyViewController ()
@property (strong, nonatomic) MPMoviePlayerController *player;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation ISpyViewController
@synthesize player;
@synthesize button;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)buttonClicked:(id)sender {
    NSString *filepath   =   [[NSBundle mainBundle] pathForResource:@"ISpyTransition" ofType:@"mp4"];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    
    self.view.backgroundColor = [UIColor blackColor];
    button.hidden = YES;
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
