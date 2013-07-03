//
//  GraphViewController.m
//  Target Golf
//
//  Created by Claire Wright on 02/07/2013.
//  Copyright (c) 2013 Claire Wright. All rights reserved.
//

#import "GraphViewController.h"
#import "Shot.h"
#import "Location.h"
#import "ShotType.h"

@interface GraphViewController ()

@property (nonatomic, strong) CPTGraphHostingView *hostingView;

-(void)initPlot;
-(void)configureHost;
-(void)configureGraph;
-(void)configurePlot;
-(void)configureLegend;

@property (nonatomic, strong) NSArray *dataSource;

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
    return [self.dataSource count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    
    NSInteger valueCount = [self numberOfRecordsForPlot:plot];
    Shot *shot = [self.dataSource objectAtIndex:index];
    
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            if (index < valueCount) {
            
                double ballX = [shot.ballLocation.latitude doubleValue];
                double teeX = [shot.teeLocation.latitude doubleValue];
                
                NSNumber *xOffset = [NSNumber numberWithDouble:(ballX - teeX)];
                
                return xOffset;
            }
            break;
            
        case CPTScatterPlotFieldY:
        {
            double ballY = [shot.ballLocation.longitude doubleValue];
            double teeY = [shot.teeLocation.longitude doubleValue];
            
            NSNumber *yOffset = [NSNumber numberWithDouble:(ballY - teeY)];
            return yOffset;
        }
            break;
    }
    return [NSDecimalNumber zero];
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
    [self configurePlot];
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
    self.hostingView.allowPinchScaling = YES;
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

-(void)configurePlot {
    
    // 1 - Get graph and plot space
    CPTGraph *graph = self.hostingView.hostedGraph;
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    // 2 - Create the plot
    CPTScatterPlot *shotTypePlot = [[CPTScatterPlot alloc] init];
    shotTypePlot.dataSource = self;
    shotTypePlot.identifier = nil;
    CPTColor *shotTypeColor = [CPTColor redColor];
    [graph addPlot:shotTypePlot toPlotSpace:plotSpace];
    /*
    CPTScatterPlot *googPlot = [[CPTScatterPlot alloc] init];
    googPlot.dataSource = self;
    googPlot.identifier = CPDTickerSymbolGOOG;
    CPTColor *googColor = [CPTColor greenColor];
    [graph addPlot:googPlot toPlotSpace:plotSpace];
    CPTScatterPlot *msftPlot = [[CPTScatterPlot alloc] init];
    msftPlot.dataSource = self;
    msftPlot.identifier = CPDTickerSymbolMSFT;
    CPTColor *msftColor = [CPTColor blueColor];
    [graph addPlot:msftPlot toPlotSpace:plotSpace];
     */
    
    // 3 - Set up plot space
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:shotTypePlot, nil]];
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
    plotSpace.yRange = yRange;
    
    // 4 - Create styles and symbols
   
    
    shotTypePlot.dataLineStyle = nil;
    CPTMutableLineStyle *aaplSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    aaplSymbolLineStyle.lineColor = shotTypeColor;
    CPTPlotSymbol *aaplSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    aaplSymbol.fill = [CPTFill fillWithColor:shotTypeColor];
    aaplSymbol.lineStyle = aaplSymbolLineStyle;
    aaplSymbol.size = CGSizeMake(6.0f, 6.0f);
    shotTypePlot.plotSymbol = aaplSymbol;
    
    
}

-(void)configureLegend {
}

#pragma mark - Getters and Setters

-(NSArray *)dataSource
{
    if (!_dataSource) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shot" inManagedObjectContext:self.context];
        [fetchRequest setEntity:entity];
        
        NSError *error;
        _dataSource = [NSArray arrayWithArray:[self.context executeFetchRequest:fetchRequest error:&error]];
        
    }
    return _dataSource;
}

@end
