//
//  HomeViewController.m
//  HZMHIOS
//
//  Created by MCEJ on 2018/7/17.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "WebViewController.h"
#import "DetailViewController.h"
#import "YYInfiniteLoopView.h"
#import "WebUrlViewController.h"

#define headScrollHeight 140
#define scrollHeight 90

@interface HomeViewController () <UICollectionViewDelegate,UICollectionViewDataSource,YYInfiniteLoopViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic, strong) NSMutableArray * sectionArr;
@property(nonatomic, strong) NSMutableArray * rowArr0;
@property(nonatomic, strong) NSMutableArray * rowArr1;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"能手";
    
    //初始化数组
    NSArray *array1 = @[@{@"id":@"0",@"title":@""},
                        @{@"id":@"1",@"title":@""}];
    self.sectionArr = [NSMutableArray arrayWithArray:array1];
    
    //公交
    NSString *gongjiao = @"https://web.chelaile.net.cn/ch5/index.html?src=webapp_app_zhihuijinfeng&hideFooter=1&switchCity=0&showFav=0&supportSubway=0&homePage=linearound&cityId=100";
    //人事考试
    NSString *renshi = @"http://zg.cpta.com.cn/examfront/register/login.jsp";
    //美团
    NSString *meituan = @"https://www.meituan.com";
    //电影
    NSString *maoyan = @"https://maoyan.com";
    //头条
    NSString *eastday = @"http://mini.eastday.com";
    //滴滴
    NSString *diditaxi = @"https://common.diditaxi.com.cn/general/webEntry?wx=true&bizid=257&channel=70365#/";
    //火车票
    NSString *ctripFlight = @"https://m.ctrip.com/html5/Flight/swift/index";
    //旅游
    NSString *fliggy = @"https://www.fliggy.com/?ttid=sem.000000736&hlreferid=baidu.082076&route_source=seo";
    //快递
    NSString *postGood = @"http://www.kuaidi100.com";
    
    self.rowArr0 = [NSMutableArray arrayWithArray:@[
  @{@"id":@"0",@"url":meituan,@"imgName":@"meishi",@"title":@"美团"},
  @{@"id":@"3",@"url":maoyan,@"imgName":@"dianying",@"title":@"电影"},
  @{@"id":@"4",@"url":renshi,@"imgName":@"kaoshi",@"title":@"人事考试"},
  @{@"id":@"6",@"url":eastday,@"imgName":@"toutiao",@"title":@"头条"},
  @{@"id":@"7",@"url":gongjiao,@"imgName":@"gongjiao",@"title":@"公交查询"},
  @{@"id":@"9",@"url":@"",@"imgName":@"shoujihao",@"title":@"手机号归属"},
  @{@"id":@"10",@"url":@"",@"imgName":@"shenfenzheng",@"title":@"身份证查询"},
  @{@"id":@"11",@"url":@"",@"imgName":@"ip",@"title":@"IP查询"}]];
    
    self.rowArr1 = [NSMutableArray arrayWithArray:@[
  @{@"id":@"1",@"url":diditaxi,@"imgName":@"didi",@"title":@"滴滴"},
  @{@"id":@"2",@"url":postGood,@"imgName":@"kuaidi",@"title":@"快递"},
  @{@"id":@"8",@"url":ctripFlight,@"imgName":@"huochepiao",@"title":@"火车票"},
  @{@"id":@"5",@"url":fliggy,@"imgName":@"lvyou",@"title":@"旅游"},]];
    
    [self layoutCollectionView];
    
}


- (void)layoutCollectionView
{
    //设置 cell
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置 cell item的大小
//    layout.itemSize = CGSizeMake(80, 80); //cell 的大小
    layout.itemSize = CGSizeMake((mz_width-50)/4, (mz_width-50)/4); //cell 的大小
    //设置item 左右最小距离
    layout.minimumInteritemSpacing = 10; //默认为10;
    //设置上下最小距离
    layout.minimumLineSpacing = 10; //默认为10;
    //设置 item 的范围
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10); //cell上下左右之间的距离
    //设置滑动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:mz_frame(0, iPhoneNavH, mz_width, mz_height-iPhoneNavH) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.collectionView.backgroundColor = [UIColor greenColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HeaderCollectionViewCell"];
    //注册头部
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    //添加到父视图
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - DataSource  Delegate
//分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.sectionArr count];
}

//设置每一个分区的item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (0 == section) {
        return [self.rowArr0 count];
    }else if (1 == section) {
        return [self.rowArr1 count];
    }
    
    
    
    
    return 0;
    
    
    
}

//cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //从重用队列中去取
    HeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderCollectionViewCell" forIndexPath:indexPath];
    if (0 == indexPath.section) {
        cell.imgName.image = [UIImage imageNamed:self.rowArr0[indexPath.row][@"imgName"]];
        cell.title.text = self.rowArr0[indexPath.row][@"title"];
    }else if (1 == indexPath.section) {
        cell.imgName.image = [UIImage imageNamed:self.rowArr1[indexPath.row][@"imgName"]];
        cell.title.text = self.rowArr1[indexPath.row][@"title"];
    }
    return cell;
}

#pragma mark - 头部视图大小
//第二步
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size;
    if (section == 0) {
        size = CGSizeMake(mz_width, headScrollHeight+10);
    }else {
        size = CGSizeMake(mz_width, scrollHeight+10);
    }
    return size;
}

#pragma mark - 头部视图内容
//第三步
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = [[UICollectionReusableView alloc] init];
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = (UICollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            UIView *headView = [[UIView alloc]init];
            headView.frame = CGRectMake(0, 0, mz_width, headScrollHeight);
            [self addSdCycleScrollView:headView];
            [headerView addSubview:headView];
        }else if (indexPath.section == 1) {
            UIView *headView = [[UIView alloc]init];
            headView.frame = CGRectMake(0, 0, mz_width, scrollHeight);
            headView.backgroundColor = mz_color(235, 235, 241);
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, headView.frame.size.width, headView.frame.size.height-20)];
            imgView.image = mz_image(@"carImage");
            [headView addSubview:imgView];
//            [self addSdCycleScrollView:headView];
            [headerView addSubview:headView];
            
        }
        reusableView = headerView;
    }
    return reusableView;
}

-(void)addSdCycleScrollView:(UIView *)view
{
    SDCycleScrollView *cycView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, view.frame.size.height) delegate:nil placeholderImage:nil];
    cycView.placeholderImage = [UIImage imageNamed:@"bg_baner"];
    cycView.imageURLStringsGroup = @[@"banar1",@"banar2",@"banar3"];
    cycView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycView.hidesForSinglePage = YES;
    cycView.autoScrollTimeInterval = 2.0;
    cycView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    cycView.pageDotColor = [UIColor lightGrayColor];
    cycView.currentPageDotColor = mz_yiDongBlueColor;
    [view addSubview:cycView];
}

- (void)playerView:(UIView *)headView
{
    NSArray *imgArr = @[@"carImage.png", @"carImage.png"];
    YYInfiniteLoopView *loopView = [YYInfiniteLoopView infiniteLoopViewWithImages:imgArr didSelectedImage:^(NSInteger index) {
//        [self showWithTouchIndex:index];
    }];
    loopView.hideTitleLabel = YES;
    loopView.titlePosition = InfiniteLoopViewTitlePositionTop;
    loopView.pagePosition = InfiniteLoopViewPagePositionRight;
    loopView.animationDuration = 2.0f;
    loopView.animationType = InfiniteLoopViewAnimationTypeRippleEffect;
    loopView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    loopView.pageIndicatorColor = [UIColor grayColor];
    loopView.currentPageIndicatorColor = mz_yiDongBlueColor;
    [self.scrollView addSubview:loopView];
    [headView addSubview:self.scrollView];
}

//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [AVAnalytics updateOnlineConfigWithBlock:^(NSDictionary * _Nullable dict, NSError * _Nullable error) {
        if (error == nil) {
            if (mzisequal(dict[@"parameters"][@"type"], @"1")) {
                if (indexPath.section == 0) {
                    NSString *url = mzstring(self.rowArr0[indexPath.row][@"url"]);
                    if (mzisequal(url, @"")) {
                        DetailViewController *vc = [[DetailViewController alloc] init];
                        vc.title = mzstring(self.rowArr0[indexPath.row][@"title"]);
                        vc.type = [self.rowArr0[indexPath.row][@"id"] intValue];
                        [self.navigationController pushViewController:vc animated:YES];
                    }else {
                        WebViewController *vc = [[WebViewController alloc] init];
                        vc.url = mzstring(dict[@"parameters"][@"url"]);
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }else{
                    WebViewController *vc = [[WebViewController alloc] init];
                    vc.url = mzstring(dict[@"parameters"][@"url"]);
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else if (mzisequal(dict[@"parameters"][@"type"], @"0")) {
                if (indexPath.section == 0) {
                    NSString *url = mzstring(self.rowArr0[indexPath.row][@"url"]);
                    if (mzisequal(url, @"")) {
                        DetailViewController *vc = [[DetailViewController alloc] init];
                        vc.title = mzstring(self.rowArr0[indexPath.row][@"title"]);
                        vc.type = [self.rowArr0[indexPath.row][@"id"] intValue];
                        [self.navigationController pushViewController:vc animated:YES];
                    }else {
                        WebUrlViewController *vc = [[WebUrlViewController alloc] init];
                        vc.title = mzstring(self.rowArr0[indexPath.row][@"title"]);
                        vc.url = url;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }else{
                    WebUrlViewController *vc = [[WebUrlViewController alloc] init];
                    vc.title = mzstring(self.rowArr1[indexPath.row][@"title"]);
                    vc.url = mzstring(self.rowArr1[indexPath.row][@"url"]);
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else{
                [MHProgressHUD showMsgWithoutView:@"type不等于0或1,请后台检查"];
            }
        }
    }];
}



- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 10, mz_width, scrollHeight-20);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.contentSize = CGSizeMake(mz_width, scrollHeight-20);
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
