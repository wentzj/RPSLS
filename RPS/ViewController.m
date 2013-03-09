//
//  ViewController.m
//  RPS
//
//  Created by kuwaharg on 2/26/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#define BUTTONWIDTH 240
#define BUTTONHEIGHT 240

@implementation ViewController
@synthesize buttonScroller;
@synthesize pageControl;
@synthesize pageControlUsed;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.buttonScroller setContentSize:CGSizeMake(5*BUTTONWIDTH, BUTTONHEIGHT)];
    for (int i = 0; i<5; i++) 
    {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString* imageName;
        switch (i) {
            case 0:
                imageName = @"rock.png";
                break;
            case 1:
                imageName = @"tan-index-card-hi.png";
                break;
            case 2:
                imageName = @"scissors-open1.jpg";
                break;
            case 3:
                imageName = @"cartoon-lizard-10.gif";
                break;
            case 4:
                imageName = @"spock-vulcan-salute-.JPG";
                break;
            
            
            default:
                break;
        }
        [button setBackgroundImage: [UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(BUTTONWIDTH*i, 0, BUTTONWIDTH, BUTTONHEIGHT)];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i;
    //Add to scrollview
        [self.buttonScroller addSubview:button]; 
    }
    self.buttonScroller.pagingEnabled = YES;
    [self.navigationController setNavigationBarHidden:1];
}

- (IBAction)changePage:(id)sender {
    self.pageControlUsed = YES;
    CGFloat pageWidth = self.buttonScroller.contentSize.width /self.pageControl.numberOfPages;
    CGFloat x = self.pageControl.currentPage * pageWidth;
    [self.buttonScroller scrollRectToVisible:CGRectMake(x, 0, pageWidth, self.buttonScroller.contentSize.height) animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.pageControlUsed)
    {    self.pageControl.currentPage = lround(self.buttonScroller.contentOffset.x /
                                          (self.buttonScroller.contentSize.width / self.pageControl.numberOfPages));
    }
}

- (void)buttonPressed:(UIButton*)sender
{
    NSLog(@"tag%d", sender.tag);
    [self performSegueWithIdentifier:@"moveSelected" sender:self];
}

- (void)viewDidUnload
{
    [self setButtonScroller:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
