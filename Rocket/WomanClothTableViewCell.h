//
//  WomanClothTableViewCell.h
//  Rocket
//
//  Created by Simone Kalb on 14/10/14.
//
//

#import <UIKit/UIKit.h>

@interface WomanClothTableViewCell : UITableViewCell

@property(strong, nonatomic) IBOutlet UIImageView *clothImage;
@property(strong, nonatomic) IBOutlet UILabel *name;
@property(strong, nonatomic) IBOutlet UILabel *brand;
@property(strong, nonatomic) IBOutlet UILabel *price;

@end
