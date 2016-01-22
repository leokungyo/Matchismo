//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by QingYu on 15/12/27.
//  Copyright © 2015年 QingYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount: (NSUInteger)count usingDeck:(Deck *)deck withMatchMode:(NSInteger)mode;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)NSInteger score;
@property (nonatomic, readonly)NSString *userActivity;
@property NSInteger gameMode;//0 for 2-card mode, 1 for 3-card mode

@end
