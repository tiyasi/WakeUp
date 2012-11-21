//
//  NewsDetailViewController.m
//  WakeUp
//
//  Created by Tiyasi on 27/11/12.
//  Copyright (c) 2012 Tiyasi. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "MyMBProgressHUD.h"
#import "WebImageOperations.h"

@interface NewsDetailViewController ()<UIWebViewDelegate>
{
    NSString *urlAddressFromNewsController;
}
@end

@implementation NewsDetailViewController

-(void)dealloc
{
    [urlAddressFromNewsController release];
    urlAddressFromNewsController=nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)setUrlAddress:(NSString *)urlAddress
{
    NSLog(@"urlAddress in DetailsViewController=%@",urlAddress);
    urlAddressFromNewsController=[[NSString alloc]init];
    urlAddressFromNewsController=urlAddress;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor brownColor]];
    NSLog(@"urlAddress in DetailsViewController in ViewDiDLoad=%@",urlAddressFromNewsController);

    UIWebView *webV=[[UIWebView alloc]initWithFrame:[self.view bounds]];
    [webV setDelegate:self];
    [self.view addSubview:webV];
    [webV release];
    
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddressFromNewsController];
    //URL Request Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //Load the request in the UIWebView.
    [webV loadRequest:requestObj];
}

//Called whenever the view starts loading something
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
}

//Called whenever the view finished loading something
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    [MBProgressHUD hideHUDForView:self.view animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
