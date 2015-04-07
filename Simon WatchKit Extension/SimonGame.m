//
//  SimonGame.m
//  Simon
//
//  Created by Kamal Hunzai on 4/5/15.
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
@property (assign,nonatomic)NSUInteger currentPlayerTurn;
@property (assign,nonatomic)BOOL isBlockingButtons;
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
-(NSArray*) gameButtons{
    return @[self.upperLeftButton,self.upperRightButton,self.lowerLeftButton,self.lowerRightButton];
}
-(NSArray*)quadrantColors{
    return @[[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor greenColor]];
}
-(NSArray*)quadrantFlashColors{
    NSMutableArray *flashColors = [NSMutableArray new];
    for (NSInteger ii=0; ii < [[self quadrantColors]count]; ii++) {
        UIColor *flashColor = [[self quadrantColors][ii]colorWithAlphaComponent:1];
        [flashColors addObject:flashColor];
    }
    return flashColors;
}

-(void)flashQuadrantWithIndex:(NSInteger)quadrantIndex {
    UIColor *startingColor = [[self quadrantColors] objectAtIndex:quadrantIndex];
    UIColor *flashColor = [[self quadrantFlashColors] objectAtIndex:quadrantIndex];
    WKInterfaceButton *buttonToFlash = [[self gameButtons]objectAtIndex:quadrantIndex];
    [buttonToFlash setBackgroundColor:flashColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [buttonToFlash setBackgroundColor:startingColor];
    });
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self startGame];
}
-(void)playSeriseFromIndex:(NSInteger)index toIndex:(NSInteger)finishIndex{
    if(index == finishIndex){
    // Start next player turn
        return;
    }
  
    NSNumber* currentQuadrant = [self.currentGameSequence objectAtIndex:index];
    [self flashQuadrantWithIndex:[currentQuadrant unsignedIntegerValue] ];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playSeriseFromIndex:1 toIndex:finishIndex];
    });
}
-(void)playSeriseForTurn:(NSUInteger)turnIndex{
    [self playSeriseFromIndex:0 toIndex:turnIndex];
}
-(void)startGame{
    self.currentPlayerTurn = 0;
    self.isBlockingButtons = YES;
    [self.notificationLabel setText:@"Ready"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.notificationLabel setText:@"Set"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.notificationLabel setText:@"Go"];
        });
    });
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



