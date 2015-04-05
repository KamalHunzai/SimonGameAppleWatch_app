//
//  SimonWatchVC.m
//  Simon
//
//  Created by Kamal Hunzai on 4/5/15.
//  Copyright (c) 2015 self. All rights reserved.
//

#import "SimonWatchVC.h"


@interface SimonWatchVC()
@property (weak, nonatomic) IBOutlet WKInterfaceButton *startGameButton;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *gameOverLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *scoreLabel;


@end


@implementation SimonWatchVC

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)startGamePressed {
    [self pushControllerWithName:@"SimonGame" context:self];
    
}

@end



