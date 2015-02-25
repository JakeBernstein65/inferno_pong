//
//  ViewController.m
//  fireball game
//
//  Created by Jake B on 7/15/12.
//  Copyright (c) Jake Bernstein All rights reserved.
//

#import "gameViewController.h"
#import "loseViewController.h"

@interface gameViewController ()

@end

@implementation gameViewController

@synthesize topScores;
@synthesize highScore;

-(void)prepareSound:(NSString *)sound2 //runs the action "prepareSound" using the string "sound2". This pepares the sound to be played later without lag.
{
    NSString *paths = [[NSBundle mainBundle] pathForResource:sound2 ofType:@"mp3"];
    AVAudioPlayer* theAudios = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:paths] error:NULL];
    theAudios.delegate = self;
    [theAudios prepareToPlay];
    [AVAudioPlayer release];
}

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    [self prepareSound:@"bounce_sound"];//prepares sound so that when it plays later it doesn't lag
    //Data.plist code
    
    //get paths from the root directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES);
    //get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    //get the path to our data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
    //check to see if Data.plist exists in documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        //if not in documents, get property list from main bundle
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    
    //read property list into memory as an NSData object
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    
  // NSLog(@"%@", [[NSString alloc] initWithData:plistXML encoding:NSUTF8StringEncoding]); displays all program code
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    //convert static property list into dictionary object
    NSDictionary *temp = (NSDictionary *) [NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format: &format errorDescription: &errorDesc];
    if (!temp)
    {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    //assign values
    self.topScores = [temp objectForKey:@"bestScore"]; //temporarily makes topScores = the object in the plist @"bestScore"
        //display values
   
    highScore.text = [NSString stringWithFormat:@"High score is %@ points", topScores]; //sets the text in the label, highScore, to the value of" some words, topScores, then more words." and right now, topScores temporarily = bestScores

    // string with format is what nslog uses too, esentially string with format replaces operators with the parameters you include afterword. %@ is esentially 'to string', and replaces itself with the string representation of the corresponding pareamters, which in this case is topScores. you can put anything there and the only thing that will change is %@ which will be changed to the current high score. you could also do an integer with %d and a float with %f etc.
    
//Data.plist code above***********************************************************************************************
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f/100.0f;//accell to a rate between 1 and 100 doesn't go any higher or lower
    
    ballspeed = 0.05;
    livesLeft = 3;
    score.text = [NSString stringWithFormat:@"%i points ",points];//displays points as the text of the label score and displayes value as string instead of integer, but doesn't turn the int into a string. %i means int, %@ means words, but when put @% here prints the word pointd twice.
    
    position = CGPointMake(15.0, 7.5); //coordinates of object i.e. (fireball)
    fireball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ice_balls.png"]]; //declare fireball as image to represent object in game.
    fireball.frame = CGRectMake(50, 50, 32, 32);//controls the size of the image i.e. (the fireball)
    [self.view addSubview:fireball]; //view fireball on screen
    
    timer = [NSTimer scheduledTimerWithTimeInterval:ballspeed //speed is a variable that increases each time paddle is hit
                                             target:self 
                                           selector:@selector(animate) //targeting the animate operation
                                           userInfo:nil //???
                                            repeats:YES];//the timer, which animates, targets its self. it animates every 0.05 seconds it animates itself and repeats
}
 
-(void)playSound: (NSString*)sound //an action that plays a sound of the type "mp3", but the specific sound is a variable a.k.a. "sound". Not IBAction because the user isn't preforming an action. called through              [self playSound: @"name of sound"];
{
    NSString *path = [[NSBundle mainBundle] pathForResource:sound ofType:@"mp3"];//a string named path was created, it is equal to the main bundle of NSBundle. it gathers its resources from the file bounce_sound.mp3
    AVAudioPlayer* theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];//the name of the AVAudioPlayer is theAudio. the AVaudioplayer is allocated. its contents are the contents of the url that contains an NSUrl with a fileURLPath that we named path
    theAudio.delegate = self; //this AVAudioplayer "theAudio" delegates to its self
    [theAudio play];//then it plays
    [AVAudioPlayer release];
}

-(void)animate
{
    if (livesLeft == 3)lives.image = [UIImage imageNamed:@"ice_lives3.png"];//3 lives, sets new image for lives
    
    if ((paddle.center.y)<(fireball.center.y+25)){//if center of paddle is higher than the center of the fireball, run the following code
    
        if ((paddle.center.y -5)>fireball.center.y) {//if the center of the paddle is more than 5 pixels about the center of the fireball run the following code
            
            if ((fireball.center.x>(paddle.center.x - 70))&&(fireball.center.x<(paddle.center.x + 70))) {//if the fireball's x value is 79 greater than the value or 70 less then the paddle, run the following code
                  
                [self playSound:@"bounce_sound"];// the action, (void), "playSound" runs through the code to play the sound @"bounce_sound". self means that the function is located in the same file/class
                
                points +=10;//add 10 points
                newTopScore +=10;//add 10 points to highscore for current round
                score.text = [NSString stringWithFormat:@"%i points ",points];//displays points as the text of the label score and displayes value as string instead of integer, but doesn't turn the int into a string.
                position.y = -position.y;//this reverses the value of y
                ballspeed -= 0.01;
                //NSLog(@"ballspeed is: %f", ballspeed);
                //prints in comp screen the ballspeed variable's value
                
            }
            
        }
    
    }
//    if (CGRectIntersectsRect(fireball.frame, paddle.frame))//if fireball or paddle hits the border of the screen then the direction of y will reverse 
//    {}
    fireball.center = CGPointMake(fireball.center.x + position.x, fireball.center.y + position.y);// sets the center of the fireball picture to the same coordinates as the center of the cgpoint, the object
    if (fireball.center.x > 288 || fireball.center.x <32)// if center of fireball is > 288 or < 32 pixels on the screen, then the value of x will be reversed
        position.x = -position.x;
    
    
    if (fireball.center.y < 20)//if the ball goes to high, run through code

    {
        //if center of fireball is lower than 20 pixels on the y axis, y value is reversed
        position.y = -position.y;
    }
    
    if (fireball.center.y > 480)//if fireball hits bottom of screen run function
    {  
        if (livesLeft > 0)//if # of lives is greater than zero run this
        {
            if (livesLeft >1) //run if lives greater than 1
            {
                position = CGPointMake(15.0, 7.5); //coordinates of object i.e. (fireball)
                fireball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ice_balls.png"]]; //declare fireball as image to represent object in game.
                fireball.frame = CGRectMake(50, 50, 32, 32);//controls the size of the image i.e. (the fireball)
                [self.view addSubview:fireball]; //???
            }
            livesLeft --;  //subtract a life
            if (livesLeft == 2){ //run if 2 lives left
             lives.image = [UIImage imageNamed:@"ice_lives2.png"];//2 lives left, sets new image for lives   
            }
            else if (livesLeft == 1){
                lives.image = [UIImage imageNamed:@"ice_balls.png"];// 1 life left, sets new image for lives
                lives.frame = CGRectMake(0, 420, 33, 33);//changes picture, "lives" to adjusted measurements. first two numbers position, second 2 r width and height
                
            }
            
            
        }
      
        if (livesLeft == 0)
        {
           
            gameOver.alpha = 1;//make game over pic visible
            paddle.alpha = 0;//make paddle invisible
            lives.alpha = 0; //sets the alpha of lives to zero making it clear
 
           if (newTopScore > [topScores intValue]) //if the int value of string topScores is greater than newTopScore
            {
                topScores = ([NSString stringWithFormat: @"%i", newTopScore]); // = means make equal, == means check for congruent values
            }
       
            highScore.alpha = 1; //makes highscore label visible
          
           // dog= @"600"; assigns the string dog a character value of 600
           // dog = [dog intValue]; converts the character value of 600 to an int value of 600
            
           [self saveData];
        
        [self performSelector:@selector(loseSwitch) withObject:nil afterDelay:4];//preform loseswitch with no objects after a 4 second delay

            
        }
    }
    
    if (paddle.center.x < 0) {//if center of padlle is less than 0 on x plane
        paddle.center = CGPointMake(320, paddle.center.y);//
    }
    
    if (paddle.center.x > 320) {
        paddle.center = CGPointMake(0, paddle.center.y);
    }
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    if (livesLeft > 0) {
        paddle.center = CGPointMake(paddle.center.x + acceleration.x*10, paddle.center.y);
        
    }
}


-(void)saveData
{
    //get paths from root directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    //get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
    
    //set the variables to the values in the text fields
    self.topScores = topScores;
    
    //create dictionary with values in UITextFields
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: topScores, nil] forKeys:[NSArray arrayWithObjects: @"bestScore", nil]];
    
    NSString *error = nil;
    //create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList: plistDict format: NSPropertyListXMLFormat_v1_0 errorDescription: &error];
    
    //check if plist data exists
    if (plistData)
    {
        //write plistData to our Data.plist file
        [plistData writeToFile:plistPath atomically:YES];
    }
    else
    {
        NSLog(@"Error in saveData: %@", error);
       [error release];
    }

}


-(void)loseSwitch {
    [self performSegueWithIdentifier:@"loseSegue"sender:self];//preforms the segue called losesegue

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end


