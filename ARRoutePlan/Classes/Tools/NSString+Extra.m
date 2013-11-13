//
//  NSString+Extra.m
//  Fimm
//
//  Created by The Coder on 3/16/12.
//  Copyright (c) 2012 Cleancode. All rights reserved.
//

#import "NSString+Extra.h"

@implementation NSString (Extra)
-(NSString *)stringByAddingPercentEscapesUsingEncoding:(NSStringEncoding)encoding {
	return  (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                               (__bridge CFStringRef)self,
                                                               NULL,
                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                               CFStringConvertNSStringEncodingToEncoding(encoding));
}@end
