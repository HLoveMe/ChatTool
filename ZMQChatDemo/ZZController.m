//
//  ZZController.m
//  HMenu
//
//  Created by HMenu on 16/5/18.
//  Copyright © 2016年 HMenu. All rights reserved.
//


#import "ZZController.h"
#import "HInvocation.h"
#import "ZZModel.h"

#import "ZZModelFrame.h"
#import <objc/runtime.h>

#import "ZZCell.h"

#import "ZZBottomView.h"

//#import "NSString+Extension.h"
#import "HMenuController.h"
@interface ZZController ()<UITableViewDelegate,UITableViewDataSource,ZZBottomViewDelegate,HMenuDataSource,HMenuDelegate>
@property(nonatomic,strong)NSMutableArray *async;
@property(nonatomic,retain)UITableView *tableView;

@property(nonatomic,copy)NSString *currentPage;

@property(nonatomic,retain)NSMutableArray *dataArray;

@property(nonatomic,retain)ZZBottomView *bottomView;

@property(nonatomic,retain)NSTimer *refreshTimer;

@property(nonatomic,assign)BOOL isFire;
@property(nonatomic,strong)HMenuController *controller;
@property(nonatomic,strong)NSMutableArray *titles;

@property(nonatomic,strong)UIDynamicAnimator *animator;
@end

@implementation ZZController
-(HMenuController *)controller{
    if (!_controller) {
        _controller = [HMenuController menuControllerByDefaultLayout];
        _controller.delegate=self;
        _controller.dataSource = self;
//        _controller.textColor = [UIColor redColor];
    }
    return _controller;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.currentPage = @"1";
    
    [self _requestData:NO];
    
    [self _createTableView];

    [self _createBottomView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(longPressButton:) name:@"longPressButton" object:nil];
}


- (void)uploadChatContentAction{
    
    self.currentPage = @"1";
    [self _requestData:NO];
}

- (void)_createTableView{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, kScreenHeight - 44) style:UITableViewStylePlain];
    _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:_tableView];
}

- (void)_createBottomView{

    _bottomView = [[ZZBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
    
    _bottomView.delegate = self;
    
    [self.view addSubview:_bottomView];
}


- (void)_requestData:(BOOL)last{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"temp.plist" ofType:nil];
    NSArray *arr= [NSArray arrayWithContentsOfFile:path];
    NSArray *array = [ZZModel modelsWithArray:arr];
    NSMutableArray *data = [NSMutableArray array];

    [array  enumerateObjectsUsingBlock:^(ZZModel * obj, NSUInteger idx, BOOL * _Nonnull stop)  {
        ZZModelFrame *modelFrame = [[ZZModelFrame alloc] init];
        modelFrame.zzModel = obj;
        
        [data addObject:modelFrame];
        
    }];
    self.dataArray=data;
    [self.tableView reloadData];

}

#pragma mark -- 获取系统时间
- (NSString*)getTimeStamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    NSString *strDate = [formatter stringFromDate:[NSDate date]];
    return strDate;
}


#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ZZCell * cell = [tableView dequeueReusableCellWithIdentifier:@"zzCell"];
    
    if (!cell) {
        
        cell = [[ZZCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"zzCell"];
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //删除cell之间的分割线
    
    cell.zzModelframe = _dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZZModelFrame *modelFrame = _dataArray[indexPath.row];
    
    return modelFrame.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;//section头部高度
}

//当cell被选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    
}


#pragma -mark 
-(void)longPressButton:(NSNotification *)notifacation{
    UIView *tag = notifacation.object;
    [self.controller showMenuToolWithTarget:tag];
}
-(NSMutableArray<id<HStringExchange>> *)menuController:(HMenuController *)menu withTarget:(UIView *)view{
//    return [NSMutableArray arrayWithObjects:@"Copy",@"点我,我这么帅",@"不要脸啊",@"AAAAA",@"BBBBB",@"Sasahsioasha",@"CCCC",@"DDDD",nil];
    NSMutableArray<id<HStringExchange>> *data = [NSMutableArray array];
    __weak typeof(self) this = self;
    HInvocation *one1 =[HInvocation invocation:@"Copy" target:this sel:@selector(copyContnet:)];
    HInvocation *one2 =[HInvocation invocation:@"点我,我这么帅" target:this sel:@selector(copyContnet:)];
    HInvocation *one3 =[HInvocation invocation:@"不要脸啊" target:this sel:@selector(copyContnet:)];
    HInvocation *one4 =[HInvocation invocation:@"AAAAA" target:this sel:@selector(copyContnet:)];
    HInvocation *one5 =[HInvocation invocation:@"BBBBB" target:this sel:@selector(copyContnet:)];
    HInvocation *one6 =[HInvocation invocation:@"Sasahsioasha" target:this sel:@selector(copyContnet:)];
    HInvocation *one7 =[HInvocation invocation:@"CCCC" target:this sel:@selector(copyContnet:)];
    HInvocation *one8 =[HInvocation invocation:@"DDDD" target:this sel:@selector(copyContnet:)];
    [data addObject:one1];
    [data addObject:one2];
    [data addObject:one3];
    [data addObject:one4];
    [data addObject:one5];
    [data addObject:one6];
    [data addObject:one7];
    [data addObject:one8];
    return data;
}
-(void)menuController:(HMenuController *)menu didSelectedIndex:(id<HStringExchange>)indexContent content:(id)content{
    UIPasteboard *past = [UIPasteboard generalPasteboard];
    past.string=content[@"text"];
    NSLog(@"%@",indexContent);
    id this = [(HInvocation *)indexContent target];
    SEL sel = [(HInvocation *)indexContent aSel];
    [this performSelector:sel withObject:content];
}
-(void)copyContnet:(id)content{
    NSLog(@"点击的Cell msg:%@",content);
}

@end
