//
//  AppView.h被代理对象
//  xib
//
//  Created by shadandan on 16/6/28.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"
@class AppView;
//定义协议
@protocol appViewDelegate<NSObject>
-(void)appViewBtnClick:(AppView *)appview;
@end

//用来描述appView.xib的
@interface AppView : UIView
//创建模型属性
@property(nonatomic,strong)AppModel *appModel;
@property(nonatomic,weak)id<appViewDelegate>delegate;//代理
+(instancetype)loadView;//加载appView
@end
