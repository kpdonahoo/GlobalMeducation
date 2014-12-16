//
//  StudyViewController.m
//  GlobalMeducation
//
//  Created by Amanda Doyle on 12/14/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "StudyViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "ResultsViewController.h"

@interface StudyViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIImageView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *closeScrollButton;
@property (weak, nonatomic) IBOutlet UILabel *spyLabel;
@property (weak, nonatomic) IBOutlet UIButton *dinosaurButton;
@property (weak, nonatomic) IBOutlet UIButton *cookbookButton;
@property (weak, nonatomic) IBOutlet UIButton *three;

@end

@implementation StudyViewController
@synthesize background;
@synthesize scroll;
@synthesize closeScrollButton;
@synthesize spyLabel;
int check2 = 0;
@synthesize dinosaurButton;
@synthesize cookbookButton;
@synthesize three;
@synthesize mazeSeconds;

AVAudioPlayer *spy;
ResultsViewController *vc;
int dinoCount = 0;
int bookCount = 0;
int threeCount = 0;

NSTimer *timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void) viewDidAppear:(BOOL)animated {
    background.alpha = 0.0;
    scroll.alpha = 0.0;
    closeScrollButton.alpha = 0.0;
    
    NSURL* musicFile2 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                pathForResource:@"bond"
                                                ofType:@"wav"]];
    
    spy = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile2 error:nil];
    
    [spy play];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    background.hidden = NO;
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{background.alpha = 1.0;}
                     completion:nil];
    
    [UIView animateWithDuration:3.0
                          delay:1.0
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
    
    timer= [NSTimer scheduledTimerWithTimeInterval:1.0
                                            target:self
                                          selector:@selector(update)
                                          userInfo:nil
                                           repeats:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                   ^{
                       [self animateLabelShowText:@"I SPY A DINOSAUR" characterDelay:0.2];
                   });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) update {
    dinoCount++;
}

-(void) update2 {
    bookCount++;
}

-(void) update3 {
    threeCount++;
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

- (IBAction)dinosaurMethod:(id)sender {
    
    [timer invalidate];
    timer = nil;
    
    [[dinosaurButton layer] setBorderWidth:2.0f];
    [[dinosaurButton layer] setBorderColor:[UIColor redColor].CGColor];
    
    [UIView animateWithDuration:3.0
                          delay:1.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{ dinosaurButton.alpha = 0.0; }
                     completion:nil];

    timer= [NSTimer scheduledTimerWithTimeInterval:1.0
                                            target:self
                                          selector:@selector(update2)
                                          userInfo:nil
                                           repeats:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                   ^{
                       [self animateLabelShowText:@"I SPY A COOKBOOK" characterDelay:0.2];
                   });
    
    cookbookButton.hidden = NO;
}

- (IBAction)cookbookButton:(id)sender {
    
    [timer invalidate];
    timer = nil;
    
    [[cookbookButton layer] setBorderWidth:2.0f];
    [[cookbookButton layer] setBorderColor:[UIColor redColor].CGColor];
    
    [UIView animateWithDuration:3.0
                          delay:2.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{ cookbookButton.alpha = 0.0;  }
                     completion:nil];
    
    timer= [NSTimer scheduledTimerWithTimeInterval:1.0
                                            target:self
                                          selector:@selector(update3)
                                          userInfo:nil
                                           repeats:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                   ^{
                       [self animateLabelShowText:@"I SPY THE NUMBER THREE ON A SPINE" characterDelay:0.2];
                   });
}

- (IBAction)threeButton:(id)sender {
    [[three layer] setBorderWidth:2.0f];
    [[three layer] setBorderColor:[UIColor redColor].CGColor];
    
    [UIView animateWithDuration:3.0
                          delay:2.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{ cookbookButton.alpha = 0.0;  }
                     completion:nil];
    
    [UIView animateWithDuration:3.0
                          delay:4.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{ cookbookButton.alpha = 0.0;}
                     completion:nil];
    
    double delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self performSegueWithIdentifier:@"toResults" sender:self];
    });

    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toResults"])
    {
        vc = (ResultsViewController *)[segue destinationViewController];
        vc.mazeSecondz = mazeSeconds;
        vc.bookSecondz = [NSString stringWithFormat:@"%i seconds",bookCount];
        vc.dinoSecondz = [NSString stringWithFormat:@"%i seconds",dinoCount];
        vc.threeSecondz = [NSString stringWithFormat:@"%i seconds",threeCount];
    }
}

-(void) viewDidDisappear:(BOOL)animated {
    [spy pause];
}


@end
