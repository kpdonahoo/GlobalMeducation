//
//  MazeViewController.m
//  GlobalMeducation
//
//  Created by Amanda Doyle on 12/14/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "MazeViewController.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "StudyViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MazeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mazeBackground;
@property (weak, nonatomic) IBOutlet UIImageView *message;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIImageView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *closeScrollButton;
@property (weak, nonatomic) IBOutlet UIImageView *mazeOne;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lostMessage;
@property (weak, nonatomic) IBOutlet UIButton *tryAgain;
@property (weak, nonatomic) IBOutlet UILabel *seconds;
@property (weak, nonatomic) IBOutlet UIImageView *message18;
@property (strong, nonatomic) MPMoviePlayerController *player2;


@end

@implementation MazeViewController
@synthesize mazeBackground;
@synthesize message;
@synthesize continueButton;
@synthesize scroll;
@synthesize closeScrollButton;
@synthesize mazeOne;
@synthesize tempDrawImage;
@synthesize resetButton;
@synthesize mainImage;
@synthesize timerLabel;
@synthesize lostMessage;
@synthesize tryAgain;
@synthesize seconds;
@synthesize message18;
@synthesize player2;

CGPoint lastPoint;
CGFloat brush;
CGFloat opacity;
BOOL mouseSwiped;
CGFloat red;
CGFloat blue;
CGFloat green;
int counter;
NSTimer *myTimer;
AVAudioPlayer *click;
AVAudioPlayer *lost;
AVAudioPlayer *win;
AVAudioPlayer *maze;
int new;
StudyViewController *vc;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    new = 0;
    
    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:@"beep"
                                               ofType:@"wav"]];
    NSURL* musicFile2 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:@"Flurry"
                                               ofType:@"wav"]];
    NSURL* musicFile3 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                pathForResource:@"Medal"
                                                ofType:@"wav"]];
    
    NSURL* musicFile4 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                pathForResource:@"GOT"
                                                ofType:@"wav"]];

   click = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
   lost = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile2 error:nil];
    win = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile3 error:nil];
    maze = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile4 error:nil];
    
    [maze play];
    
    
    self.navigationController.navigationBarHidden = YES;
    mazeBackground.alpha = 0.0;
    continueButton.alpha = 0.0;
    message.alpha = 0.0;
    message18.alpha = 0.0;
    mazeOne.alpha = 0.0;
    scroll.alpha = 0.0;
    closeScrollButton.alpha = 0.0;
    resetButton.alpha = 0.0;
    lostMessage.alpha = 0.0;
    tryAgain.alpha = 0.0;
    
    brush = 10.0;
    opacity = 1.0;
    red = 164.0;
    blue = 160.0;
    green = 160.0;
    
    timerLabel.alpha = 0.0;
    
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{mazeBackground.alpha = 1.0;}
                     completion:nil];
    
    
    [UIView animateWithDuration:1.0
                          delay:1.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{scroll.alpha = .8;}
                     completion:nil];
    
    [UIView animateWithDuration:1.0
                          delay:1.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{closeScrollButton.alpha = 1.0;}
                     completion:nil];
    

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (new == 0) {
        counter = 20;
        
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                            target:self
                                                          selector:@selector(updateLabel)
                                                          userInfo:nil
                                                          repeats:YES];
    }
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
     if (mainImage.hidden == NO) {
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);

    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
         
     }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
     if (mainImage.hidden == NO) {
         
         self.tempDrawImage.image = nil;
         self.mainImage.image = nil;
         
         new = 1;
         
         if (lastPoint.x >=879  && lastPoint.y >=697) {
             [maze pause];
             [win play];
             
             [UIView animateWithDuration:3.0
                                   delay:0.0
                                 options: UIViewAnimationCurveEaseInOut
                              animations:^{continueButton.alpha = 1.0;}
                              completion:nil];
             

             
NSString *number = [timerLabel.text substringFromIndex: [timerLabel.text length] - 2];
             
             
    int value = 20 - [number intValue];
             
             if (value == 18) {
                 
                 [UIView animateWithDuration:3.0
                                       delay:0.0
                                     options: UIViewAnimationCurveEaseInOut
                                  animations:^{message18.alpha = 1.0;}
                                  completion:nil];
                 
             } else {
                 
                 [UIView animateWithDuration:3.0
                                       delay:0.0
                                     options: UIViewAnimationCurveEaseInOut
                                  animations:^{message.alpha = 1.0;}
                                  completion:nil];
                 
                 [UIView animateWithDuration:3.0
                                       delay:0.0
                                     options: UIViewAnimationCurveEaseInOut
                                  animations:^{seconds.alpha = 1.0;}
                                  completion:nil];
                 
                 [UIView animateWithDuration:3.0
                                       delay:1.0
                                     options: UIViewAnimationCurveEaseInOut
                                  animations:^{seconds.text = [NSString stringWithFormat:@"%i",value];}
                                  completion:nil];
             }
             
             [UIView animateWithDuration:3.0
                                   delay:0.0
                                 options: UIViewAnimationCurveEaseInOut
                              animations:^{mazeBackground.alpha = .2;}
                              completion:nil];
             
             [UIView animateWithDuration:3.0
                                   delay:0.0
                                 options: UIViewAnimationCurveEaseInOut
                              animations:^{mazeOne.alpha = .2;}
                              completion:nil];
             
             [UIView animateWithDuration:3.0
                                   delay:0.0
                                 options: UIViewAnimationCurveEaseInOut
                              animations:^{timerLabel.alpha = .2;}
                              completion:nil];
             
             [UIView animateWithDuration:3.0
                                   delay:0.0
                                 options: UIViewAnimationCurveEaseInOut
                              animations:^{resetButton.alpha = .2;}
                              completion:nil];
             
             
             [myTimer invalidate];
             myTimer = nil;
         }
         
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mazeOne.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
         }
}

- (IBAction)closeScroll:(id)sender {
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{closeScrollButton.alpha = 0.0;}
                     completion:nil];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{scroll.alpha = 0.0;}
                     completion:nil];
    
    [UIView animateWithDuration:2.0
                          delay:2.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{mazeOne.alpha = 1.0;}
                     completion:nil];
    
    [UIView animateWithDuration:2.0
                          delay:2.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{resetButton.alpha = 1.0;}
                     completion:nil];
    
    [UIView animateWithDuration:2.0
                          delay:2.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{timerLabel.alpha = 1.0;}
                     completion:nil];
    
    [UIView animateWithDuration:2.0
                          delay:2.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{mazeBackground.alpha = .5; mainImage.hidden = NO; tempDrawImage.hidden = NO;}
                     completion:nil];
    
}

- (IBAction)toISpy:(id)sender {
    [win pause];
    
    NSString *filepath   =   [[NSBundle mainBundle] pathForResource:@"ISpyTransition" ofType:@"mp4"];
    NSURL    *fileURL    =   [NSURL fileURLWithPath:filepath];
    
    player2 = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [self.view addSubview:player2.view];
    player2.fullscreen = YES;
    player2.controlStyle = MPMovieControlStyleNone;
    [player2 prepareToPlay];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:player2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reset:(id)sender {
    
    self.mainImage.image = nil;
    
}

-(void) updateLabel {
    if (counter!=0) {
        counter--;
        if (counter < 10) {
        
        timerLabel.text = [NSString stringWithFormat:@": 0%i",counter];
            [click play];
            
            double delayInSeconds = .4;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self playAgain];
            });
            
        } else if (counter >= 10){
            
        timerLabel.text = [NSString stringWithFormat:@": %i",counter];
        [click play];
            
        }
        
        if (counter < 6) {
            timerLabel.textColor = [UIColor redColor];
        }
    } else {
        [UIView animateWithDuration:5.0
                              delay:0.0
                            options: UIViewAnimationCurveEaseInOut
                         animations:^{lostMessage.alpha = 1.0;}
                         completion:nil];
        
        [UIView animateWithDuration:3.0
                              delay:0.0
                            options: UIViewAnimationCurveEaseInOut
                         animations:^{mazeBackground.alpha = .2;}
                         completion:nil];
        [UIView animateWithDuration:3.0
                              delay:0.0
                            options: UIViewAnimationCurveEaseInOut
                         animations:^{mazeOne.alpha = .2;}
                         completion:nil];
        
        [UIView animateWithDuration:3.0
                              delay:0.0
                            options: UIViewAnimationCurveEaseInOut
                         animations:^{tryAgain.alpha = 1.0;}
                         completion:nil];
        
        [UIView animateWithDuration:3.0
                              delay:0.0
                            options: UIViewAnimationCurveEaseInOut
                         animations:^{timerLabel.alpha = .2;}
                         completion:nil];
        
        [UIView animateWithDuration:3.0
                              delay:0.0
                            options: UIViewAnimationCurveEaseInOut
                         animations:^{resetButton.alpha = .2;}
                         completion:nil];
        self.mainImage.image = nil;
        new = 0;
        [maze pause];
        [lost play];
    }
}

- (IBAction)tryAgain:(id)sender {
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{timerLabel.alpha = 1.0;}
                     completion:nil];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{resetButton.alpha = 1.0;}
                     completion:nil];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{mazeOne.alpha = 1.0;}
                     completion:nil];
    
    [UIView animateWithDuration:2.0
                          delay:1.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{mazeBackground.alpha = .5;}
                     completion:nil];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{tryAgain.alpha = 0.0;}
                     completion:nil];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{lostMessage.alpha = 0.0;}
                     completion:nil];
    
    
    [myTimer invalidate];
    myTimer = nil;
    [lost pause];
    [maze play];
    counter = 20;
    timerLabel.text = @": 20";
    timerLabel.textColor = [UIColor whiteColor];
}

-(void) playAgain {
    [click play];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toISpy"])
    {
        vc = (StudyViewController *)[segue destinationViewController];
        vc.mazeSeconds = [NSString stringWithFormat:@"%@ seconds",seconds.text];
    }
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    [self performSegueWithIdentifier:@"toISpy" sender:self];
    [player2.view removeFromSuperview];
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
