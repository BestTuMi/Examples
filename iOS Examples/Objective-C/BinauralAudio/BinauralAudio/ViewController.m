//
//  ViewController.m
//  BinauralAudio
//
//  Created by Aurelius Prochazka on 4/24/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#define degrees(rad) (180.0*rad/M_PI)

#import "ViewController.h"
#import "Player.h"
@import CoreMotion;
#import "AKFoundation.h"
#import "HeadView.h"

@implementation ViewController {
    Player *player;
    CMMotionManager *motionManager;
    NSNotificationCenter *center;
    BOOL isPlaying;
    IBOutlet HeadView *headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isPlaying = NO;
    
    player = [[Player alloc] init];
    [AKOrchestra addInstrument:player];
    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval = 1/10.0;
    motionManager.gyroUpdateInterval = 0.1;
    
    [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXTrueNorthZVertical
                                                       toQueue:[NSOperationQueue mainQueue]
                                                   withHandler:
     ^(CMDeviceMotion *motion, NSError *error) {
         
         // Attitude -----------------------------------------------------------
         
         CMAttitude *attitude = motion.attitude;
         NSMutableDictionary *d = [NSMutableDictionary dictionary];
         [d setObject:[NSNumber numberWithFloat:attitude.roll]  forKey:@"roll"];
         [d setObject:[NSNumber numberWithFloat:attitude.pitch] forKey:@"pitch"];
         [d setObject:[NSNumber numberWithFloat:attitude.yaw]   forKey:@"yaw"];
         [self receivedOrientationDictionary:d];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)play:(UIButton *)sender {
    if (!isPlaying) {
        [player play];
        isPlaying = YES;
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
    } else if (isPlaying) {
        [player stop];
        isPlaying = NO;
        [sender setTitle:@"Play" forState:UIControlStateNormal];
    }
}


- (void)receivedOrientationDictionary:(NSDictionary *)data {
    
    float pitch = [(NSNumber *)data[@"pitch"] floatValue];
    float yaw   = [(NSNumber *)data[@"yaw"]   floatValue];
    player.elevation.value = degrees(pitch);
    player.azimuth.value =degrees(yaw);
    player.reverbFeedback.value = fabs(degrees(yaw))/360.0;
    player.reverbLevel.value = fabs(degrees(yaw))/360.0;
    headView.azimuth = - degrees(yaw);
    [headView setNeedsDisplay];
}



@end
