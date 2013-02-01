//
//  ScrollableViewController.m
//  AboutERS
//
//  Created by Dina Li on 2/1/13.
//  Copyright (c) 2013 ers. All rights reserved.
//

#import "ScrollableViewController.h"

#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 1.5

@interface ScrollableViewController (UtilityMethods)
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
@end

@interface ScrollableViewController ()

@end

@implementation ScrollableViewController{
    BOOL finishedLayout;
}

@synthesize chart = _chart;
@synthesize description = _description;
@synthesize url = _url;
@synthesize contentView = _contentView;
@synthesize imageView = _imageView;
@synthesize feedScrollView = _feedScrollView;

@synthesize tapRecognizer = _tapRecognizer;

// did not work
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.contentView.translatesAutoresizingMaskIntoConstraints = YES;
//    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [self.feedScrollView removeConstraints:self.constraints];
//}
//
//-(void)viewWillLayoutSubviews {
//    if (!finishedLayout) {
//        finishedLayout = YES;
//        self.feedScrollView.contentSize = self.contentView.bounds.size;
//        // [self.view layoutSubviews];
//         NSLog(@"%@", @"here");
//    }
//}


- (void)loadView {
    [super loadView];
    
    // set the tag for the image view
    [_imageView setTag:ZOOM_VIEW_TAG];
    
    // add gesture recognizers to the image view
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
//    UITapGestureRecognizer *doubleTapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    
    [doubleTap setNumberOfTapsRequired:2];
    [twoFingerTap setNumberOfTouchesRequired:2];
    
    [_imageView addGestureRecognizer:singleTap];
    [_imageView addGestureRecognizer:doubleTap];
  //  [_imageView addGestureRecognizer:doubleTapImage];
    [_imageView addGestureRecognizer:twoFingerTap];
    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = [_feedScrollView frame].size.width  / [_imageView frame].size.width;
    [_feedScrollView setMinimumZoomScale:minimumScale];
    [_feedScrollView setZoomScale:minimumScale];
}

#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [_feedScrollView viewWithTag:ZOOM_VIEW_TAG];
}

/************************************** NOTE **************************************/
/* The following delegate method works around a known bug in zoomToRect:animated: */
/* In the next release after 3.0 this workaround will no longer be necessary      */
/**********************************************************************************/
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    [scrollView setZoomScale:scale+0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // single tap does nothing for now
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    NSLog(@"handleDoubleTap - tap on the image: this should zoom the image");
    // double tap zooms in
    float newScale = [_feedScrollView zoomScale] * ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [_feedScrollView zoomToRect:zoomRect animated:YES];
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    // two-finger tap zooms out
    float newScale = [_feedScrollView zoomScale] / ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [_feedScrollView zoomToRect:zoomRect animated:YES];
}

//- (IBAction)handleTapFrom:(UITapGestureRecognizer *)recognizer {
//
//    NSLog(@"handleTapFrom tap on the image: this should zoom the image");
//
//    float newScale = [_feedScrollView zoomScale] * ZOOM_STEP;
//    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[recognizer locationInView:recognizer.view]];
//    [_feedScrollView zoomToRect:zoomRect animated:YES];
//}

#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the _feedScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [_feedScrollView frame].size.height / scale;
    zoomRect.size.width  = [_feedScrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)loadView {
//    
//    [super loadView];
//       
//   // _chart = [UIImage imageNamed:@"ChartsOfNote_test.jpeg"];
//   // [_imageView setImage:_chart];
//    [_imageView setTag:ZOOM_VIEW_TAG];
//    
//   // _imageView.contentMode = UIViewContentModeScaleAspectFit;
//   // _imageView.userInteractionEnabled = YES;
//    
//    // add gesture recognizers to the image view
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    
//    singleTap.numberOfTapsRequired = 1;
//    singleTap.numberOfTouchesRequired = 1;
//   // [self.view addGestureRecognizer:singleTap];
//    
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)]; // changed the method call, this is an IBAction!!
//    
//    doubleTap.numberOfTapsRequired = 2;
//    doubleTap.numberOfTouchesRequired = 1;
// //   [self.view addGestureRecognizer:doubleTap];
//    [singleTap requireGestureRecognizerToFail:doubleTap];
//    
//    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
//    
//    [twoFingerTap setNumberOfTouchesRequired:2];
//        
//    // ========================
//    // zoom on image when tapped
//    // ========================
//     UITapGestureRecognizer *doubleTapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapImage:)];
//    
//    doubleTapImage.numberOfTapsRequired = 2;
//    doubleTapImage.numberOfTouchesRequired = 1;
//    
//    [_imageView addGestureRecognizer:singleTap];
//    [_imageView addGestureRecognizer:twoFingerTap];
//    [_imageView addGestureRecognizer:doubleTap];
//    
//    // calculate minimum scale to perfectly fit image width, and begin at that scale
//    float minimumScale = [_feedScrollView frame].size.width  / [_imageView frame].size.width;
//    [_feedScrollView setMinimumZoomScale:minimumScale];
//    [_feedScrollView setZoomScale:minimumScale];
//}
//
//#pragma mark UIScrollViewDelegate methods
//
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    return [_feedScrollView viewWithTag:ZOOM_VIEW_TAG];
//}
//
///************************************** NOTE **************************************/
///* The following delegate method works around a known bug in zoomToRect:animated: */
///* In the next release after 3.0 this workaround will no longer be necessary      */
///**********************************************************************************/
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
//    [scrollView setZoomScale:scale+0.01 animated:NO];
//    [scrollView setZoomScale:scale animated:NO];
//}
//
//#pragma mark TapDetectingImageViewDelegate methods
//
//- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
//    // single tap does nothing for now
//    NSLog(@"handleSinglTap selected");
//}
//
//- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
//    // double tap zooms in
//    float newScale = [_feedScrollView zoomScale] * ZOOM_STEP;
//    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
//    [_feedScrollView zoomToRect:zoomRect animated:YES];
//}
//
//- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
//    // two-finger tap zooms out
//    float newScale = [_feedScrollView zoomScale] / ZOOM_STEP;
//    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
//    [_feedScrollView zoomToRect:zoomRect animated:YES];
//}
//
///*
// In response to a tap gesture, show the image view appropriately  */
//- (IBAction)handleTapFrom:(UITapGestureRecognizer *)recognizer {
//    
//    NSLog(@"handle tap on the image: this should zoom the image");
//    
//    float newScale = [_feedScrollView zoomScale] * ZOOM_STEP;
//    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[recognizer locationInView:recognizer.view]];
//    [_feedScrollView zoomToRect:zoomRect animated:YES];
//}
//
//// does this have to be an IBAction?
//- (void)handleDoubleTapImage:(UITapGestureRecognizer *)gestureRecognizer {
//   
//   NSLog(@"handle tap on the image: this should zoom the image");
//    float newScale = [_feedScrollView zoomScale] * ZOOM_STEP;
//    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
//    [_feedScrollView zoomToRect:zoomRect animated:YES];
//}
//
//#pragma mark Utility methods
//
//- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
//    
//    CGRect zoomRect;
//    
//    // the zoom rect is in the content view's coordinates.
//    //    At a zoom scale of 1.0, it would be the size of the _feedScrollView's bounds.
//    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
//    zoomRect.size.height = [_feedScrollView frame].size.height / scale;
//    zoomRect.size.width  = [_feedScrollView frame].size.width  / scale;
//    
//    // choose an origin so as to get the right center.
//    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
//    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
//    
//    return zoomRect;
//}
//
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    self.feedScrollView.delegate = self;
//    // NSString *descriptionNoImage = [self.detailItem description];
//    NSString *descriptionTEST = @"may all beings be free from suffering";
//    
//    NSString *myDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
//                                   "<head> \n"
//                                   "<style type=\"text/css\"> \n"
//                                   "body {font-family: \"%@\"; font-size: %@; margin: %@%@ %@%@ %@%@ %@%@;}\n"
//                                   "</style> \n"
//                                   "</head> \n"
//                                   "<body>%@</body> \n"
//                                   "</html>", @"helvetica", [NSNumber numberWithInt:36],  [NSNumber numberWithInt:20], @"px", [NSNumber numberWithInt:90], @"px", [NSNumber numberWithInt:20], @"px", [NSNumber numberWithInt:20], @"px", descriptionTEST];
//    
//    //  NSLog(@"descriptionHTML = %@", myDescriptionHTML);
//    
//   // [self.webView loadHTMLString:myDescriptionHTML baseURL:self.url];
//    
//    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
//    
//    [_feedScrollView setBackgroundColor:[UIColor whiteColor]];
//    
//	//[_feedScrollView setCanCancelContentTouches:NO];
//	//_feedScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
//	//_feedScrollView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
//    
//	_feedScrollView.scrollEnabled = YES;
//    
//    [super viewDidLoad];
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
