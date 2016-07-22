//
//  NSString+NSStringExt.m
//  15-QQ聊天布局
//
//  Created by shadandan on 16/7/14.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "NSString+NSStringExt.h"

@implementation NSString (NSStringExt)

-(CGSize)sizeOfTextWithMaxSize:(CGSize) maxSize font:(UIFont *)font{
    NSDictionary *attrs=@{NSFontAttributeName:font};
return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+(CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}
@end
