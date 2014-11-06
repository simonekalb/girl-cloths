//
//  RIDetailViewController.h
//  Rocket
//
//  Created by Simone Kalb on 15/10/14.
//
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>
#import "WomanCloth.h"

@interface RIDetailViewController : UIViewController<iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) IBOutlet iCarousel *carousel;

/* Item to be displayed */
@property(strong, nonatomic) WomanCloth *currentCloth;
@property(strong, nonatomic) IBOutlet UILabel *productName;
@property(strong, nonatomic) IBOutlet UILabel *productBrand;

@end
