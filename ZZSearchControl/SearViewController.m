//
//  SearViewController.m
//  ZZSearchControl
//
//  Created by heheda on 2016/11/9.
//  Copyright © 2016年 呵呵嗒. All rights reserved.
//


#import "SearViewController.h"
#import "ZZTextTagList.h"
#import "SearchResultViewController.h"
@interface SearViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *mSearch;
@property (nonatomic, strong) UITableView *mTabV;

@property (nonatomic, strong) NSArray            *hotKeyWord;
@property (nonatomic, strong) NSMutableArray     *historyKeyWord;

@end

@implementation SearViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.mSearch.text = @"";
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.title = @"呵呵嗒";
    
    [self initUI];
    
    [self initData];
    
}
#pragma mark - initUI
- (void)initUI
{
    //构造searchBar
    [self buildSearchBarView];
    
    //构造列表
    [self buildTableView];
}

//构造searchBar
- (void)buildSearchBarView
{
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f, 60.0f, SCREEN_WIDTH, 50.0f)];
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.delegate = self;
    searchBar.placeholder = @"想要搜索什么";
    [self.view addSubview:searchBar];
    self.mSearch = searchBar;
}

//构造列表
- (void)buildTableView
{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 110.0f, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStylePlain];
    table.backgroundColor = [UIColor clearColor];
    table.delegate = self;
    table.dataSource = self;
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:table];
    self.mTabV = table;
}

#pragma mark - initData
- (void)initData
{
    self.hotKeyWord = @[@"星期一",@"Monday",@"星期二",@"Tuesday",@"星期三",@"Wednesday",@"星期四",@"Thursday",@"星期五",@"Friday",@"星期六",@"Saturday"];
    self.historyKeyWord = [[NSMutableArray alloc]initWithCapacity:0];
}
#pragma mark - UISearchDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self.historyKeyWord addObject:searchBar.text];
    [self.mTabV reloadData];
    
    [self.mTabV setContentOffset:CGPointMake(0, 0)];
    [searchBar resignFirstResponder];
#warning TODO 这里添加网络请求
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger section = ([self.hotKeyWord count] > 0 && [self.historyKeyWord count] > 0)?2:1;
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = (section == 0) ? 1 : [self.historyKeyWord count];
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor lightGrayColor];
    view.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 30.0f);
    
    UILabel *lab = [UILabel new];
    lab.frame = CGRectMake(20.0f, 5.0f, SCREEN_WIDTH, 20.0f);
    lab.text = (section == 0)?@"热门关键词":@"搜索历史";
    [view addSubview:lab];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        CGFloat height = ([self.historyKeyWord count] > 0) ? 50 : 0;
        return height;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view  = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 50.0f);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];;
    btn.frame = CGRectMake(80.0f, 8.0f, SCREEN_WIDTH - 160, 34.0f);
    [btn setTitle:@"清空历史记录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:10];
    [btn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [btn.layer setBorderWidth: 1];
    [btn addTarget:self action:@selector(onRemoveHistoryWord:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 30;
    }
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (UITableViewCell *)hotKeyCell:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_id = @"cell_hotKey";
    UITableViewCell *cell = [self.mTabV dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cell_id];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        ZZTextTagList * tagList = [[ZZTextTagList alloc] initWithFrame:CGRectMake(20.0f, 10.0f, SCREEN_WIDTH - 40, 70.0f)];
        tagList.tag = 1001;
        [cell.contentView addSubview:tagList];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    ZZTextTagList * tagList = (ZZTextTagList *)[cell.contentView viewWithTag:1001];
    NSInteger height = [tagList getHotKeyHeightWithArray:self.hotKeyWord];
    CGRect cellFrame = [cell frame];
    cellFrame.origin = CGPointMake(0, 0);
    cellFrame.size.height = height;
    [cell setFrame:cellFrame];
    tagList.block = ^(NSString *labelText){
        self.mSearch.text = labelText;
    };
    return cell;
}
- (UITableViewCell *)historyCell:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_id = @"cell_history";
    UITableViewCell *cell = [self.mTabV dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cell_id];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.imageView.image = [UIImage imageNamed:@"history.png"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [self.historyKeyWord objectAtIndex:indexPath.row];
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self hotKeyCell:tableView atIndexPath:indexPath];
    }else {
        return [self historyCell:tableView atIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        SearchResultViewController *vc = [SearchResultViewController new];
        vc.keyWords = [self.historyKeyWord objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - 事件
//清空搜索历史
- (void)onRemoveHistoryWord:(UIButton *)sender
{
    [self.historyKeyWord removeAllObjects];
    [self.mTabV reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
