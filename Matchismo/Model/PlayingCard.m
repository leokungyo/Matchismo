//
//  PlayingCard.m
//  Matchismo
//
//  Created by QingYu on 15/12/17.
//  Copyright © 2015年 QingYu. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards{

    int score = 0;
    //2-card match mode
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        }else if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }
    }
    
    //3-card match mode
    if ([otherCards count] == 2) {
        PlayingCard *firstCard = [otherCards objectAtIndex:0];
        PlayingCard *secondCard = [otherCards objectAtIndex:1];
        if (firstCard.rank == self.rank) {
            if (secondCard.rank == self.rank) {
                if (![firstCard.suit isEqualToString:secondCard.suit] && ![firstCard.suit isEqualToString:self.suit]){
                    score = 8;
                }
                else if(([firstCard.suit isEqualToString:secondCard.suit] + [firstCard.suit isEqualToString:self.suit])){
                    score = 9;
                }
                else
                    score = 10;
            }
            else if([secondCard.suit isEqualToString:self.suit]){
                if ([firstCard.suit isEqualToString:self.suit]) {
                    
                    score = 6;
                }
                else
                    score = 5;
            }
            else{
            
                score = 4;
            }
        }
        else if([firstCard.suit isEqualToString:self.suit]){
            
            if (secondCard.rank == self.rank) {
                if ([firstCard.suit isEqualToString:secondCard.suit]) {
                    score = 6;
                }
                else
                    score = 5;
            }
            else if([secondCard.suit isEqualToString:self.suit]){
                score = 2;
            }
            else
                score = 1;
        }
        else{
        
            if (firstCard.rank == secondCard.rank || secondCard.rank == self.rank) {
                score = 4;
            }
            else if([firstCard.suit isEqualToString:secondCard.suit]||[secondCard.suit isEqualToString:self.suit]){
                score = 1;
            }
        }
    }
    
    return score;
}

-(NSString *)contents{

    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit=_suit;

+(NSArray *)validSuits{

    return @[@"♠️",@"♣️",@"♥️",@"♦️"];
}

+(NSUInteger)maxRank{

    return 13;
}

-(void)setSuit:(NSString *)suit{

    if ([[PlayingCard validSuits]containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit{

    return _suit ? _suit :@"?";
    
}

+(NSArray *)rankStrings{

    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}




@end
