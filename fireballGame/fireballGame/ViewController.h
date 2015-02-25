//
//  ViewController.h
//  fireballGame
//
//  Created by iD Student on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController <ADBannerViewDelegate>
{
    ADBannerView *adView;
}

@property (nonatomic, retain) IBOutlet ADBannerView *adView;

//-(IBAction)quitgame: (id)sender; //IBAction named quitgame

@end


/*
 NSString *path = [[NSBundle mainBundle] pathForResource:@"bounce_sound" ofType:@"mp3"];//a string named path was created, it is equal to the main bundle of NSBundle. it gathers its resources from the file bounce_sound.mp3
 AVAudioPlayer* theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];//the name of the AVAudioPlayer is theAudio. the AVaudioplayer is allocated. its contents are the contents of the url that contains an NSUrl with a fileURLPath that we named path
 theAudio.delegate = self; //this AVAudioplayer "theAudio" delegates to its self
 [theAudio play];//then it plays
*/

//Ibactions and outlets are only for when you are doing visual stuff that the user will interact with