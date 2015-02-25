//
//  ViewController.m
//  fireballGame
//
//  Created by iD Student on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize adView;

-(void)bannerViewDidLoadAd:(ADBannerView *)banner//all code in here takes place when an ad is present to be displayed
{
    adView.hidden=FALSE; //the adBanner, adView, is not hidden from the users view. hidden is a bool that decides whether the object attached to it is hidden from sight or not. Right now it is FALSE.
    NSLog(@"Has ad, showing");
    
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error//all code in here takes place when an ad isn't present to be displayed
{
    adView.hidden=TRUE;//the receiver, the banner view in this instance, is hidden.
    NSLog(@"Has no ads, hiding");
}

- (void)viewDidLoad
{
    adView.delegate = self;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

}

/*-(IBAction)quitgame:(id)sender;

{
    exit(0); //exits the game
}
 */


- (void)viewDidUnload
{
    [adView release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
