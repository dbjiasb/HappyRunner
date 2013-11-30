//
//  Model_Delegate.h
//  eMarketingProject
//
//  Created by OuYiJian on 13-3-13.
//  Copyright (c) 2013年 eshore. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectToDic <NSObject>

@required

- (NSDictionary *) dictionary;

@end


@protocol FillFromDic <NSObject>

@required

- (void) fillFromeDictionary:(NSDictionary *)dic;

@end