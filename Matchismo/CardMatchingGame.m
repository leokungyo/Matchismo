//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by QingYu on 15/12/27.
//  Copyright © 2015年 QingYu. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()

@property (nonatomic,readwrite)NSInteger score;
@property (nonatomic, readwrite)NSString *userActivity;
@property (nonatomic, strong)NSMutableArray *cards; //of Card
@property (nonatomic, strong)NSMutableArray *otherCards;

@end

@implementation CardMatchingGame

-(NSMutableArray *)cards{
    if(!_cards){
        _cards = [[NSMutableArray alloc]init];
        _otherCards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck withMatchMode:(NSInteger)mode{

    self = [super init];
    self.gameMode = mode;
    if (self) {
        for (int i =0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
            
        }
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index{

    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS =4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index{

    Card *card = [self cardAtIndex:index];
    //NSMutableArray *otherCards = [[NSMutableArray alloc]init];
    if(self.gameMode == 0){
        //2-card match mode
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
            }else{
                //match against other chosen cards
                self.userActivity = [NSString stringWithFormat:@"%@",card.contents];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            self.userActivity = [NSString stringWithFormat:@"Matched %@,%@ for %d points",card.contents,otherCard.contents,matchScore*MATCH_BONUS];
                            otherCard.matched = YES;
                            card.matched = YES;
                        
                        }else{
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            self.userActivity = [NSString stringWithFormat:@"%@ and %@ don't match! %d points penalty!",card.contents,otherCard.contents,MISMATCH_PENALTY];
                        }
                        break;
                    }
                
                }
            
            self.score -= COST_TO_CHOOSE;
           // self.userActivity = [NSString stringWithFormat:@"%@",card.contents];
            card.chosen = YES;
            }
        }
    }
    //3-card match mode
    else{
        //close the card if it's currently opened
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
            }
        //open the card  if it's currently closed
        else{
            card.chosen = YES;
            
            if ([_otherCards count]<2) {
                [_otherCards addObject:card];
                self.userActivity = [NSString stringWithFormat:@"%@",card.contents];
            }
            else{
                int matchScore = [card match:_otherCards];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    self.userActivity = [NSString stringWithFormat:@"%@ matches with %@ and %@ for %d points!", card.contents,[[_otherCards firstObject] contents],[[_otherCards lastObject] contents], MATCH_BONUS * matchScore];
                    
                    [_otherCards addObject:card];
                    for (Card *otherCard in _otherCards) {
                        otherCard.matched = YES;
                        //card.chosen = YES;
                    }
                    [_otherCards removeAllObjects];
                }
                else{
                    card.chosen = YES;
                    self.score -= MISMATCH_PENALTY;
                    self.userActivity = [NSString stringWithFormat:@"%@ doesn't match with %@ and %@! %d points penalty!",card.contents,[[_otherCards firstObject] contents],[[_otherCards lastObject] contents],MISMATCH_PENALTY];
                    //already chosen 2 cards but 3rd card doesn't match
                    //show the 3rd card then flip over previous opened cards
                    for (Card *openedCard in _otherCards) {
                        openedCard.chosen = NO;
                    }
                    [_otherCards removeAllObjects];
                 
                    }
                }
            }
            
        }
    }
        
}


@end
