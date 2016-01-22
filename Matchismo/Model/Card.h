//
//  Card.h
//  Matchismo
//
//  Created by QingYu on 15/12/17.
//  Copyright © 2015年 QingYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;

@property (nonatomic,getter=isChosen)BOOL chosen;
@property (nonatomic,getter=isMatched)BOOL matched;

-(int)match:(NSArray *)otherCards;

@end
