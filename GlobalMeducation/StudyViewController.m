//
//  StudyViewController.m
//  GlobalMeducation
//
//  Created by Amanda Doyle on 12/14/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "StudyViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface StudyViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) MPMoviePlayerController *player;
@property (weak, nonatomic) IBOutlet UIImageView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *closeScrollButton;
@property (weak, nonatomic) IBOutlet UILabel *spyLabel;

@end

@implementation StudyViewController
@synthesize button;
@synthesize background;
@synthesize player;
@synthesize scroll;
@synthesize closeScrollButton;
@synthesize spyLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    background.alpha = 0.0;
    scroll.alpha = 0.0;
    closeScrollButton.alpha = 0.0;
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
    
    background.hidden = NO;
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{background.alpha = 1.0;}
                     completion:nil];
    
    [UIView animateWithDuration:3.0
                          delay:3.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{scroll.alpha = .8;}
                     completion:nil];
    
    [UIView animateWithDuration:3.0
                          delay:3.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{closeScrollButton.alpha = 1.0;}
                     completion:nil];
}

- (IBAction)closeScroll:(id)sender {
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{scroll.alpha = 0.0;}
                     completion:nil];
    
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{closeScrollButton.alpha = 0.0;}
                     completion:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                   ^{
                       [self animateLabelShowText:@"I SPY A DINOSAUR" characterDelay:0.2];
                   });
}

- (void)animateLabelShowText:(NSString*)newText characterDelay:(NSTimeInterval)delay
{
    [spyLabel setText:@""];
    
    for (int i=0; i<newText.length; i++)
    {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [spyLabel setText:[NSString stringWithFormat:@"%@%C", spyLabel.text, [newText characterAtIndex:i]]];
                       });
        
        [NSThread sleepForTimeInterval:delay];
    }
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
