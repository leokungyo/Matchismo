//
//  PlayingCard.h
//  Matchismo
//
//  Created by QingYu on 15/12/17.
//  Copyright © 2015年 QingYu. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
