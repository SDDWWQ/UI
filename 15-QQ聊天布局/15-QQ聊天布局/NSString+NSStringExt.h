//
//  NSString+NSStringExt.h
//  15-QQ聊天布局
//
//  Created by shadandan on 16/7/14.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (NSStringExt)

/**
*  NSString类的分类，添加一个根据文本内容计算文本框大小的对象方法,NSString类型的对象调用该方法
*
*  @param maxSize 最大宽和最大高
*  @param font    字体相关的属性（例如大小，是一个字典）
*
*  @return 大小（宽和高）
*/
-(CGSize)sizeOfTextWithMaxSize:(CGSize) maxSize font:(UIFont *)font;
/**
 *  NSString类的分类，添加一个根据文本内容计算文本框大小的类方法
 *
 *  @param text    文本内容
 *  @param maxSize 最大宽和最大高
 *  @param font    字体相关的属性（例如大小，是一个字典）
 *
 *  @return 大小（宽和高）
 */
+(CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;
@end
