//
//  SimonGame.m
//  Simon
//
//  Created by PanaCloud on 4/5/15.
//  Copyright (c) 2015 self. All rights reserved.
//

#import "SimonGame.h"


@interface SimonGame()

@property (weak, nonatomic) IBOutlet WKInterfaceButton *upperLeftButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *upperRightButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *lowerLeftButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *lowerRightButton;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *notificationLabel;
@property (strong,nonatomic)NSArray *currentGameSequence;

@end


@implementation SimonGame
#define kGameTurnCount (1000)
-(NSArray*)generateNewGameSequence{
    NSMutableArray *newSequence =[NSMutableArray new];
    for (NSInteger ii; ii<kGameTurnCount; ii++) {
        NSInteger randomNumb = arc4random()%4;
        [newSequence addObject:@(randomNumb)];
    }
    NSLog(@"New Game Sequence: %@",newSequence);
    return newSequence;
}
- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    self.currentGameSequence = [self generateNewGameSequence];
    
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)upperLeftPressed {
}
- (IBAction)upperRightPressed {
}
- (IBAction)lowerLeftPressed {
}
- (IBAction)lowerRightPressed {
}

@end


