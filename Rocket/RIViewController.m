//
//  RIViewController.m
//  Rocket
//
//  Created by Simone Kalb on 15/09/14.
//
//

#import "RIViewController.h"
#import "RIDetailViewController.h"
#import "WomanClothTableViewCell.h"
#import "RIDataManager.h"
#import "WomanCloth.h"

#import <MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface RIViewController ()

@property(strong, nonatomic) RIDataManager *dataManager;
@property(strong, nonatomic) MBProgressHUD *hud;
@property(strong, nonatomic) WomanCloth *currentCloth;

@end

@implementation RIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /* Setting the title */
    self.title = NSLocalizedString(@"Woman Clothes", nil);
    
    /* Resistering nib for WomanCloth with xib's class name */
    NSString* name = [[WomanClothTableViewCell class] description];
    UINib* nib = [UINib nibWithNibName:name bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:name];
    
    /* Registering for notification as the application finishes calling the API */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataFetchedAndParsed:) name:WOMAN_CLOTH_DATA_INSERTION_FINISHED object:nil];
    
	if(!self.dataManager) self.dataManager = [RIDataManager new];
    
    /* Check if the database has been already populated or populate it */
    if(![self isDataBasePopulated]) {
        if(!self.hud) {
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud.labelText = NSLocalizedString(@"Loading...", nil);
        
        [self.dataManager fetch];
    } else {
        [self.dataManager fillProductCatalog];
    }
    
    /* Add an event listener to segmented view controller */
    [self.filter addTarget:self action:@selector(filterBy:)
      forControlEvents:UIControlEventValueChanged];
}

/* Notification that data has been fetched from API and objects inserted in DB */
-(void)dataFetchedAndParsed:(NSNotification *)notification {
    [self.hud hide:YES];
    [self.tableView reloadData];
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:DATABASE_POPULATED];
}

/* Check if the database is already populated and returns YES if it is */
-(BOOL)isDataBasePopulated {
    BOOL isDBPopulated = (BOOL)[[NSUserDefaults standardUserDefaults] objectForKey:DATABASE_POPULATED];
    return isDBPopulated;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataManager.productsCatalog count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* No need fot identifier since we're using name of the class, much more reliable solution */
    NSString* name = [[WomanClothTableViewCell class] description];
    WomanClothTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    
    if (cell == nil) {
        cell = [[WomanClothTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
    }
    
    /* Retrieve the ith product from array of fetched objects */
    WomanCloth *currentCloth = [self.dataManager.productsCatalog objectAtIndex:indexPath.row];
    
    [cell.clothImage sd_setImageWithURL:[NSURL URLWithString:currentCloth.imageNames[0]]
                       placeholderImage:[UIImage new]];
    
    cell.name.text = currentCloth.productName;
    cell.brand.text = currentCloth.brand;
    cell.price.text = [NSString stringWithFormat:@"Price: %.2f", currentCloth.price];
    
    return cell;
}


/** Filter on the segmented control */
- (IBAction)filterBy:(id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    long segmentedIndex = [segmentedControl selectedSegmentIndex];
    switch (segmentedIndex)
    {
        // Popularity
        case SORT_KEY_CLOTH_POPULARITY:
        {
            if(![self isDataBasePopulated]) {
                [self.hud show:YES];
                [self.dataManager fetch];
            } else {
                [self.dataManager fillProductCatalog];
                [self.tableView reloadData];
            }
            break;
        }
        // Price
        case SORT_KEY_CLOTH_PRICE:
        {

            [self.dataManager fillProductCatalogWithKey:@"price"];
            [self.tableView reloadData];
            break;
        }
        // Brand
        case SORT_KEY_CLOTH_BRAND:
        {

            [self.dataManager fillProductCatalogWithKey:@"brand"];
            [self.tableView reloadData];
            break;
        }
        // Name
        case SORT_KEY_CLOTH_NAME:
        {
            [self.dataManager fillProductCatalogWithKey:@"productName"];
            [self.tableView reloadData];
            break;
        }

        default:
            break;
    }
}

/* Setting up the height of table's view cell */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.0f;
}

/* Performs a segue in the detail view */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _currentCloth = [_dataManager.productsCatalog objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailPush" sender:self];
}

/* Fill the Detail view currentCloth variable */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RIDetailViewController *detail = [segue destinationViewController];
    detail.currentCloth = self.currentCloth;
}

@end
