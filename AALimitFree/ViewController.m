//
//  ViewController.m
//  AALimitFree
//
//  Created by MS on 15-9-16.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "ViewController.h"
#import "MyConnection.h"
#import "AppCellTableViewCell.h"

//代理方第一步：遵守委托方的协议
@interface ViewController ()<MyConnectionDelegate,UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray *_dataArr;
    UITableView *_tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [[NSMutableArray alloc] init];
    
    NSString *urlStr = @"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=2";
    MyConnection *mc = [[MyConnection alloc] initWithUrlStr:urlStr];
    
    //代理方第二步：成为代理
    mc.delegate = self;
    
    [mc start];
    
    [self createUI];
    
    NSLog(@"aaa");
    //先打印aaa，后打印000，因为代码执行速度比网络快，另外一条副线去执行数据下载
    
    //mc虽然是局部变量，但是还不会消失，因为他成为了下载数据中的代理方
    
    //回调的三种方法：代理，block,选择器
    //谁定协议谁是委托方
    //程序中谁在干活谁就是委托方，因为只要有一个人干活即可，而且他是委托方的话，能够清楚明白的把结果回调给代理方，即谁在让它干活。和生活中的委托协议相反。
    
    //传值 其实就是 调函数,传递的是事件，即我做了这件事，数据只是附带的
   
}

- (void)createUI
{
    CGRect frame = self.view.frame;
    //20 是除去导航条的高度，即从导航条下面开始cell
    frame.origin.y = 20;
    frame.size.height -= 20;
    _tableView = [[UITableView alloc] initWithFrame:frame];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    //注册cell（（让tableView和cell的xib文件产生绑定关系））
    [_tableView registerNib:[UINib nibWithNibName:@"AppCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"qqq"];
    
    //   纯代码用 [_tableView registerClass:<#(__unsafe_unretained Class)#> forCellReuseIdentifier:<#(NSString *)#>] 这个方法
}
#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    //和xib中cell的高度对应相等
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果提前注册了，就用这种方式复用cell
    //从复用队列里查询，查到就直接用，查不到就加载一个新的出来
    AppCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qqq" forIndexPath:indexPath];
    //将对应的数据模型传给cell
    [cell customWithModel:[_dataArr objectAtIndex:indexPath.row]];
    
    return cell;
}




//代理方第三步：实现协议方法（回调）

- (void)myConnectionDidFinish:(MyConnection *)mc
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:mc.downloadData options:0 error:nil];
    
    for (NSDictionary *appDic in [dic objectForKey:@"applications"]){
        
       /* AppModel *am = [AppModel modelWithDic:appDic];
        
        AppModel *am = [[AppModel alloc] init];
        
        for (NSString *keyStr in appDic){            
        [am setValue:[appDic objectForKey:keyStr] forKey:keyStr];
        
        }
        [am setValuesForKeysWithDictionary:appDic];//等价于上面的for遍历
        
        [_dataArr addObject:am];
        
        
        第一种：
                AppModel *am = [[AppModel alloc] init];
        
                for (NSString *keyStr in appDic){
                    [am setValue:[appDic objectForKey:keyStr] forKey:keyStr];
                }
             [_dataArr addObject:am]
        
        第二种：
        
        AppModel *am = [[AppModel alloc] init];
        [am setValuesForKeysWithDictionary:appDic];//等价于上面的for遍历
        
        [_dataArr addObject:am];
        
        第三种：
        AppModel *am = [AppModel modelWithDic:appDic]
        [_dataArr addObject:am];
        
        第四种：
        
        [_dataArr addObject:[AppModel modelWithDic:appDic]];
        */
        
        [_dataArr addObject:[AppModel modelWithDic:appDic]];
    }
    NSLog(@"====%zd",_dataArr.count);
    
    [_tableView reloadData];
    
    //网络请求完成后，mc才消失
}


- (void)myConnectionDidFail:(MyConnection *)mc withError:(NSError *)error
{
    NSLog(@"fail");
}

- (void)dealloc
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
