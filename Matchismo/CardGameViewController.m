//
//  ViewController.m
//  Matchismo
//
//  Created by QingYu on 15/12/16.
//  Copyright © 2015年 QingYu. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic)CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UILabel *userActivityLabel;

@property  NSUInteger gameMode;

@end

@implementation CardGameViewController

-(CardMatchingGame *)game{

    if (!_game) {
        _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] withMatchMode:self.gameMode];
    }
    return _game;
}

-(Deck *)createDeck{

    return [[PlayingCardDeck alloc]init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void)updateUI{

    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",(long)self.game.score];
        self.userActivityLabel.text = [NSString stringWithFormat:@"%@",self.game.userActivity];
        
    }
    
}

-(NSString *)titleForCard:(Card *)card{

    return card.isChosen ? card.contents:@"";
}

-(UIImage *)backgroundImageForCard:(Card *)card{

    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchRestartButton:(UIButton *)sender {
    
    if (sender.touchInside) {
        self.game = nil;
        [self game];
        [self updateUI];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",(long)self.game.score];
    }
}




@end
