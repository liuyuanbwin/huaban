//
//  PSViewController.m
//  BroBoard
//
//  Created by Peter Shih on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PSViewController.h"
#import "PSBroView.h"
#define baseURL @"http://img.hb.aicdn.com/"
#import "JCRBlurView.h"
/**
 This is an example of a controller that uses PSCollectionView
 */

/**
 Detect iPad
 */
static BOOL isDeviceIPad() {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES; 
    }
#endif
    return NO;
}

@interface PSViewController ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) PSCollectionView *collectionView;

@end

@implementation PSViewController

@synthesize
items = _items,
collectionView = _collectionView;

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.items = [NSMutableArray array];
        
    }
    return self;
}
-(void)getJsonHuaban
{
#warning -文本地址""
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"ii" ofType:@"txt"];
   // NSString * ss = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@",@"/Users/leo/Desktop/oo.txt"] usedEncoding:NSUTF8StringEncoding error:nil];
    self.items = [NSMutableArray array];
    NSData * uus = [[NSData alloc ] initWithContentsOfFile:path];
    //NSData * uus = [[NSData alloc] initWithContentsOfFile:@"/Users/leo/Desktop/ii.txt"];
  //  [uus writeToFile:@"/Users/leo/Desktop/op.txt" atomically:YES];
    
    //NSDictionary * yy = [NSDictionary alloc] init
  //  NSData * data = [[NSData alloc] initWithContentsOfFile: @"/Users/leo/Desktop/oo.txt"];
  //  NSLog(@"data length = %lu",data.length);
    //NSDictionary * dic = [NSDictionary d]
  //  NSDictionary * rr = [NSDictionary dictionaryWithContentsOfFile:@"/Users/leo/Desktop/pic.html"];
  //  NSLog(@"%@",rr.count);
    NSMutableArray * result = [NSJSONSerialization JSONObjectWithData:uus options:0 error:nil];
   // NSLog(@"%@",result[0]);
    for (NSDictionary * pic in result) {
        NSDictionary * dict = [NSDictionary dictionaryWithDictionary:pic];
        NSString * text = [pic objectForKey:@"raw_text"];
      //  NSLog(@"%@",dict);
        NSDictionary * dict1 = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"file"]];
      //  NSLog(@"%@",dict1);
        NSMutableDictionary * tempDict = [NSMutableDictionary dictionary];
        NSString * imgUrl = [NSString stringWithFormat:@"%@%@",baseURL,[dict1 objectForKey:@"key"]];
      //  NSLog(@"%@",imgUrl);
        [tempDict setObject:imgUrl forKey:@"imgUrl"];
        [tempDict setObject:[dict1 objectForKey:@"width"] forKey:@"width"];
        [tempDict setObject:[dict1 objectForKey:@"height"] forKey:@"height"];
        [tempDict setObject:text forKey:@"raw"];
        //NSLog(@"%@",[tempDict objectForKey:@"raw"]);
      //  NSLog(@"%@",tempDict);
        [self.items addObject:tempDict];
        [self dataSourceDidLoad];

    }
       //NSArray * array = [NSArray arrayWithArray:[result objectForKey:@"file"]];
    //NSLog(@"%lu",array.count);
//    NSLog(@"%@",array[0]);
//    NSMutableArray * resultArr = [NSMutableArray arrayWithCapacity:array.count];
//    for (NSDictionary * dict in array) {
//        NSMutableDictionary * resultDict = [NSMutableDictionary dictionary];
//        [resultDict setObject:dict[@"raw_text"] forKey:@"desc"];
//        [resultDict setObject:[NSString stringWithFormat:@"%@%@",baseURL,dict[@"file"][@"key"]] forKey:@"imgURL"];
//        NSString * imgType = [dict[@"file"][@"type"] substringFromIndex:6];
//        [resultDict setObject:imgType forKey:@"imgType"];
//        [resultDict setObject:dict[@"file"][@"width"] forKey:@"width"];
//        [resultDict setObject:dict[@"file"][@"height"] forKey:@"height"];
//        [resultArr addObject:resultDict];
//        NSLog(@"load");
//        self.items = [NSMutableArray arrayWithArray:resultArr];
        //[self dataSourceDidLoad];
         
        //到此为止把所有图片的属性描述保存在了resultArr数组中
        
        
        
        
        
        
        
   // }
    
}
- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.collectionView.delegate = nil;
    self.collectionView.collectionViewDelegate = nil;
    self.collectionView.collectionViewDataSource = nil;
    
    self.collectionView = nil;
}

- (void)dealloc {
    self.collectionView.delegate = nil;
    self.collectionView.collectionViewDelegate = nil;
    self.collectionView.collectionViewDataSource = nil;
    
    self.collectionView = nil;
    self.items = nil;
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    img.image = [UIImage imageNamed:@"p6946337.jpg"];
    JCRBlurView * blurView = [JCRBlurView new];
    [blurView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [blurView setTintColor:[UIColor greenColor]];
    blurView.alpha = 0.98;
   // [img addSubview:blurView];
                              
    
    
    [self.view addSubview:img];
    //self.view.backgroundColor = [UIImage imageNamed:p6946337.jpg];
    self.collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.collectionView];
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (isDeviceIPad()) {
        self.collectionView.numColsPortrait = 4;
        self.collectionView.numColsLandscape = 5;
    } else {
        self.collectionView.numColsPortrait = 2;
        self.collectionView.numColsLandscape = 3;
    }
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:self.collectionView.bounds];
    loadingLabel.text = @"Loading...";
    loadingLabel.textAlignment = UITextAlignmentCenter;
    self.collectionView.loadingView = loadingLabel;
    self.collectionView.emptyView = loadingLabel;
    [self getJsonHuaban];
    //[self setdd];
 //   [self loadDataSource];

}
-(void)setdd
{
    for (int i = 0 ; i < 10; i ++) {
        NSDictionary * temp = [NSDictionary dictionaryWithObjectsAndKeys:@"孙燕姿",@"title",@"2.jpg",@"img",[NSString stringWithFormat:@"%d",i+ arc4random()%3 *30+50],@"width",[NSString stringWithFormat:@"%d",i + arc4random()%3 *50+50],@"height", nil];
        [self.items addObject:temp];
    }
    [self dataSourceDidLoad];
}

- (void)loadDataSource {
    // Request
    NSString *URLPath = [NSString stringWithFormat:@"http://imgur.com/gallery.json"];
    NSURL *URL = [NSURL URLWithString:URLPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (!error && responseCode == 200) {
            id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (res && [res isKindOfClass:[NSDictionary class]]) {
                self.items = [res objectForKey:@"gallery"];
                [self dataSourceDidLoad];
            } else {
                [self dataSourceDidError];
            }
        } else {
            [self dataSourceDidError];
        }
    }];
//    for (int i= 0; i < 10; i ++) {
//        <#statements#>
//    }
}

- (void)dataSourceDidLoad {
    [self.collectionView reloadData];
}

- (void)dataSourceDidError {
    [self.collectionView reloadData];
}

#pragma mark - PSCollectionViewDelegate and DataSource
- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return [self.items count];
    //return 5;
    
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    NSDictionary *item = [self.items objectAtIndex:index];
    
    PSBroView *v = (PSBroView *)[self.collectionView dequeueReusableView];
    if (!v) {
        v = [[PSBroView alloc] initWithFrame:CGRectZero];
    }
    
    //[v fillViewWithObject:item];
    [v fillViewWithObject:item];
    return v;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    NSDictionary *item = [self.items objectAtIndex:index];
    
    return [PSBroView heightForViewWithObject:item inColumnWidth:self.collectionView.colWidth];
    //return 200;
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    NSDictionary *item = [self.items objectAtIndex:index];
    //NSLog(@"%@",[item objectForKey:@"width"]);
    // You can do something when the user taps on a collectionViewCell here
}

@end
