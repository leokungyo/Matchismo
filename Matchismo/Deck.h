//
//  Deck.h
//  Matchismo
//
//  Created by QingYu on 15/12/19.
//  Copyright © 2015年 QingYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
