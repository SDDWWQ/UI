//
//  AppView.h
//  xib
//
//  Created by shadandan on 16/6/28.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"
//用来描述appView.xib的
@interface AppView : UIView
//创建模型属性
@property(nonatomic,strong)AppModel *appModel;
+(instancetype)loadView;//加载appView
@end
