//
//  AppCell.m
//  19-应用管理
//
//  Created by shadandan on 16/7/19.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "AppCell.h"
@interface AppCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
- (IBAction)btnDownloadClick;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

@end
@implementation AppCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//重写app的set方法
-(void)setApp:(AppModel *)app{
    _app=app;
    self.iconView.image=[UIImage imageNamed:app.icon];
    self.titleLabel.text=app.name;
    self.introLabel.text=[NSString stringWithFormat:@"大小：%@ | 下载量：%@",app.size,app.download];
    self.app.isDownloaded=app.isDownloaded;
    if (self.app.isDownloaded) {
        self.downloadBtn.enabled=NO;
    }else{
        self.downloadBtn.enabled=YES;
    }
}
- (IBAction)btnDownloadClick {
    //已经在右侧设置了按钮禁用时的文字，所以只要设置按钮为禁用，就可以显示已下载
    self.downloadBtn.enabled=NO;
    self.app.isDownloaded=1;
    //弹出消息提示Label
    if ([self.delegate respondsToSelector:@selector(appCellDidClickDownLoadButton:)]) {
        [self.delegate appCellDidClickDownLoadButton:self];
    }
}
@end
