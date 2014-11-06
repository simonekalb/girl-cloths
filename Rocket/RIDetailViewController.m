//
//  RIDetailViewController.m
//  Rocket
//
//  Created by Simone Kalb on 15/10/14.
//
//

#import "RIDetailViewController.h"

#import <FXImageView.h>

@interface RIDetailViewController ()

@end

@implementation RIDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    [self.carousel reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Configure carousel type
    self.carousel.type = iCarouselTypeCoverFlow2;
    
    /* Setting Labels for Display item's name and brand */
    self.title = self.currentCloth.productName;
    [self.productName setText:self.currentCloth.productName];
    [self.productBrand setText:self.currentCloth.brand];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


#pragma mark - iCarousel methods
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [self.currentCloth.imageNames count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.5f;
        imageView.reflectionAlpha = 0.25f;
        imageView.reflectionGap = 10.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
        imageView.shadowBlur = 5.0f;
        view = imageView;
    }
    
    //show placeholder (Sorry no @2x @3x items due to lack of time)
    ((FXImageView *)view).processedImage = [UIImage imageNamed:@"placeholder.png"];
    
    //set image with URL. FXImageView will then download and process the image
    NSURL *currentURL = [NSURL URLWithString:[self.currentCloth.imageNames objectAtIndex:index]];
    [(FXImageView *)view setImageWithContentsOfURL:currentURL];
    
    return view;
}

@end
