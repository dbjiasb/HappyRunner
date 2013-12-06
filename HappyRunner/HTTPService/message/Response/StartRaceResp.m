//
//  StartRaceResp.m
//  HappyRunner
//
//  Created by chinatsp on 13-12-5.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "StartRaceResp.h"

@implementation StartRaceResp

- (void)fillFromeDictionary:(NSDictionary *)dic {
    
    if (ISNULL(dic))
        return;
    [super fillFromeDictionary:dic];
    
    if (self.PARAMS) {
        
        self.MATCH_ID = [self.PARAMS objectForKey:@"MATCH_ID"];
        self.GROUP_ID = [self.PARAMS objectForKey:@"GROUP_ID"];
        self.USER_ID = [self.PARAMS objectForKey:@"USER_ID"];
    }
    
}


@end
