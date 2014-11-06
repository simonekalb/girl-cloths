//
//  RIViewController.h
//  Rocket
//
//  Created by Simone Kalb on 15/09/14.
//
//

#import <UIKit/UIKit.h>


@interface RIViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate>

@property(strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) IBOutlet UISegmentedControl *filter;

@end
