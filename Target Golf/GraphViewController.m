//
//  GraphViewController.m
//  Target Golf
//
//  Created by Claire Wright on 02/07/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@property (nonatomic, strong) CPTGraphHostingView *hostingView;

-(void)initPlot;
-(void)configureHost;
-(void)configureGraph;
-(void)configureChart;
-(void)configureLegend;

@end


@implementation GraphViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initPlot];
    
}


#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return 0;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    return 0;
}

-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index {
    return nil;
}

-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index {
    return @"";
}

#pragma mark - Chart behavior
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configureChart];
    [self configureLegend];
}

-(void)configureHost {
    
    // 1 - Set up view frame
    CGRect parentRect = self.view.bounds;
    CGSize toolBarSize = self.navigationController.toolbar.bounds.size;
    
    parentRect = CGRectMake(parentRect.origin.x,
                            (parentRect.origin.y + toolBarSize.height),
                            parentRect.size.width,
                            (parentRect.size.height - toolBarSize.height));
    // 2 - Create host view
    self.hostingView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:parentRect];
    self.hostingView.allowPinchScaling = NO;
    [self.view addSubview:self.hostingView];
}

-(void)configureGraph {
    
    // 1 - Create and initialize graph
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostingView.bounds];
    self.hostingView.hostedGraph = graph;
    graph.paddingLeft = 0.0f;
    graph.paddingTop = 0.0f;
    graph.paddingRight = 0.0f;
    graph.paddingBottom = 0.0f;
    graph.axisSet = nil;
    // 2 - Set up text style
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = 16.0f;
    // 3 - Configure title
    NSString *title = [NSString stringWithFormat:@"%@ %@", self.currentShotType.club, self.currentShotType.length];
    graph.title = title;
    graph.titleTextStyle = textStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, -12.0f);
    // 4 - Set theme
    // self.selectedTheme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    // [graph applyTheme:self.selectedTheme];
}

-(void)configureChart {
}

-(void)configureLegend {
}

@end
