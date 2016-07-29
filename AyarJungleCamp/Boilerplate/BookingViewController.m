//
//  BookingViewController.m
//  Boilerplate
//
//  Created by agatsa on 7/29/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "BookingViewController.h"
#import "UIWebView+AFNetworking.h"
#import "AFNetworking.h"

@interface BookingViewController () {
    
    UIWebView *webView;
}

@end

@implementation BookingViewController

-(instancetype) init {
    
    self = [super init];
    if(self) {
        
        [self setTitle:@"Booking View"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self createSubview];
    }
    return self;
}

-(void) createSubview {
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height)];
    [webView setDelegate:self];
    [webView setOpaque:FALSE];
    [webView setBackgroundColor:[UIColor clearColor]];
//    [webView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:webView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"start Loading!!");
    AFHTTPRequestSerializer *requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    NSURLRequest *bookingURLRequest = [requestSerializer requestWithMethod:@"GET"
                                                                 URLString:@"https://www.secure-booking-engine.com/booking/IFbZIpGo8NGkPDczEKQ-ltZcrAvwxOYVNhoSsWiR-O48JhZSEhPNrkPOQ-7h8IiV/76/"
                                                     parameters:nil error:nil];
    
    [webView setScalesPageToFit:YES]; // sizes webpages to fit in the UIWebView
//    [webView loadRequest:bookingURLRequest];
    
    NSProgress *progress;
    //Working Option #1
//    [webView loadRequest:bookingURLRequest progress:&progress success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
//        NSLog(@"html : %@",HTML);
//        return HTML;
//    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"Error : %@",[error localizedDescription]);
//    }];
    [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:NULL];
    
    NSData *da = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:@"https://www.secure-booking-engine.com/booking/IFbZIpGo8NGkPDczEKQ-ltZcrAvwxOYVNhoSsWiR-O48JhZSEhPNrkPOQ-7h8IiV/76/"]]; //not tested
//    NSLog(@"da : %@",da);
    NSLog(@"%@",[[NSString alloc]initWithData:da encoding:NSUTF8StringEncoding]);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    //    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = (NSProgress *)object;
        NSLog(@"Progress is %f", progress.fractionCompleted);
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
