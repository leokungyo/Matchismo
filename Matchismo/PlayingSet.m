//
//  PlayingSet.m
//  Matchismo
//
//  Created by QingYu on 16/3/11.
//  Copyright © 2016年 QingYu. All rights reserved.
//

#import "PlayingSet.h"

@implementation PlayingSet

-(NSString *)contents{

    
}

+(NSArray *)validSuits{
    
    return @[@"▲",@"▲▲",@"▲▲▲",@"●",@"●●",@"●●●",@"◼︎",@"◼︎◼︎",@"◼︎◼︎◼︎"];
}



+(NSUInteger)maxRank{
    
    return 81;
}



@end
