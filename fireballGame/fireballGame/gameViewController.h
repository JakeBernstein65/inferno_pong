//
//  ViewController.h
//  fireball game
//
//  Created by iD Student on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>//imported when you want to include sounds in your program

@interface gameViewController: UIViewController <UIAccelerometerDelegate, AVAudioPlayerDelegate> //including an accelerometer and an audioplayer in this ViewController so must declare that here in the header because they require delegates

{
    UIImageView *fireball;
    IBOutlet UIImageView *paddle;
    IBOutlet UIImageView *lives; //assigns image to variable
    IBOutlet UIImageView *gameOver; //makes game over
    IBOutlet UILabel *score; //the score label
    IBOutlet UILabel *highScore;
    NSTimer *timer;//a timer, used to animate
    CGPoint position;//position of certain point on screen, tracks object
    int livesLeft;//lives left
    int points;// points
    float ballspeed; //ballspeed
    int topScore; //overall top score
    int newTopScore;//score per current game
    NSString *topScores;
    
    
}
@property (nonatomic, retain) NSString *topScores; //change to topScore later
@property (nonatomic, retain) UILabel *highScore;

-(void)saveData;
-(void)animate; //animates object
-(void)playSound: (NSString*)sound; //must declare the action that plays sounds, but also its string that's a variable, sound.
-(void)prepareSound: (NSString*)sound2;

@end //end

/*
-(void)playSound: (NSString*)sound //an action that plays a sound of the type "mp3", but the specific sound is a variable a.k.a. "sound". Not IBAction because the user isn't preforming an action. called through              [self playSound: @"name of sound"];
{
    NSString *path = [[NSBundle mainBundle] pathForResource:sound ofType:@"mp3"];//a string named path was created, it is equal to the main bundle of NSBundle. it gathers its resources from the file bounce_sound.mp3
    AVAudioPlayer* theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];//the name of the AVAudioPlayer is theAudio. the AVaudioplayer is allocated. its contents are the contents of the url that contains an NSUrl with a fileURLPath that we named path
    theAudio.delegate = self; //this AVAudioplayer "theAudio" delegates to its self
    [theAudio play];//then it plays
    [AVAudioPlayer release];
}
*/

